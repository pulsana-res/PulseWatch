// PulseWatch Library - Shared between boot.js and app.js

// by defaulte it doesn't record until we let it record in the watch settings
let isRecording = false;
let dataBuffer = [];
let startTime = 0;
let lastSaveTime = 0;
let totalSaved = 0;

// Keep in sync with metadata.json's "version" and the top ChangeLog entry.
// Logged on every load (see the bottom of this file) so the BLE
// console/log makes it immediately obvious which firmware is actually
// running on the watch, rather than having to infer it from behavior.
const VERSION = "0.08";

const CONFIG = {
  saveInterval: 5 * 60 * 1000,  // 5 minutes for test, should be changed later
  appName: "pulsewatch"
};

// Storage.compact() is unsafe on Espruino firmware older than 2v26: a bug
// in the nRF52 internal flash-write path used during compaction (writes
// over 2KB) could corrupt the whole Storage area and wipe installed
// apps/files - confirmed on real Bangle.js2 hardware in
// github.com/espruino/Espruino/issues/2509 ("compacting corrupts .boot0
// and deletes most files"), root-caused by the Espruino maintainer to
// affect "all nRF52-series devices" (the chip Bangle.js2 uses), and fixed
// by commit 840271c112 which shipped in the 2v26 release (2025-05-09).
// compactStorage() below refuses to run on anything older than this - see
// isCompactSafeFirmware().
const MIN_COMPACT_SAFE_VERSION = { major: 2, minor: 26 };

// compact() only needs to run once meaningful trash has piled up - it's a
// real flash rewrite (not free, and historically the riskiest Storage
// operation this firmware has), so there's no reason to pay that cost on
// every sync cycle just because one ~12KB file got erased. 200KB is
// roughly 15+ erased files' worth of unreclaimed space.
const COMPACT_TRASH_THRESHOLD_BYTES = 200 * 1024;

// Parses process.env.VERSION (e.g. "2v29" or "2v26.104" on a cutting-edge
// build) and checks it against MIN_COMPACT_SAFE_VERSION. Defensive against
// an unrecognized/missing version string - treated as unsafe rather than
// assumed safe, since the cost of skipping a compact is just delayed space
// reclaim, not data loss.
function isCompactSafeFirmware() {
  var v = (process.env && process.env.VERSION) || "";
  var m = v.match(/^(\d+)v(\d+)/);
  if (!m) return false;
  var major = parseInt(m[1], 10);
  var minor = parseInt(m[2], 10);
  if (major !== MIN_COMPACT_SAFE_VERSION.major) return major > MIN_COMPACT_SAFE_VERSION.major;
  return minor >= MIN_COMPACT_SAFE_VERSION.minor;
}

function loadSettings() {
  var settings = require("Storage").readJSON("pulsewatch.json", 1) || {};
  if (!settings.recording) settings.recording = false;
  return settings;
}

function updateSettings(settings) {
  require("Storage").writeJSON("pulsewatch.json", settings);
}

// Keeps pulsewatch.json's "recording" flag in sync with the actual HRM
// listener state, regardless of whether start()/stop() was triggered from
// the watch's own menu (app.js, which already wrote this itself) or
// remotely from the phone over BLE (ble_service.dart's auto-start-on-
// connect, which — before this — only ever called exports.start() and left
// the persisted flag untouched). Without this:
//   - the widget's green recording dot never lit up during normal
//     phone-triggered recording, since widget.js reads this persisted flag,
//     not the live in-memory isRecording state
//   - a watch reboot mid-session (battery pull, crash, etc.) came back up
//     with recording:false and never resumed, since boot.js/widget.js only
//     auto-load and start based on this persisted flag
// Wrapped defensively, matching saveData()'s handling of storage errors —
// a failed write here shouldn't be able to block the actual sensor
// start/stop, which matters more than the persisted flag.
function persistRecordingFlag(value) {
  try {
    var settings = loadSettings();
    settings.recording = value;
    updateSettings(settings);
  } catch (e) {
    // Silent fail
  }
}

// One-time migration: erases pre-fix StorageFile "ghost" chunks — files
// created by the old saveData() (which used Storage.open()/StorageFile
// instead of a plain Storage.write(), see saveData()'s comment) that
// Storage.list()'s default output can't see because of the raw chunk-number
// byte Espruino appends to their stored name. Those files were written
// successfully and are permanently consuming flash, but were never found by
// any Storage.list(/^pw.../) call in this app, so they were never synced or
// erased. Runs once per watch — gated by a persisted flag in
// pulsewatch.json — the first time this fixed lib.js loads; a failure
// leaves the flag unset so it's simply retried on the next load rather than
// giving up permanently.
function cleanupGhostStorageFiles() {
  var settings = loadSettings();
  if (settings.ghostFilesCleaned) return;

  try {
    // {sf:true} asks specifically for StorageFile-type entries — the plain
    // files the fixed saveData() now writes don't carry that flag, so this
    // can't ever touch a current, correctly-synced file. No `$` anchor: the
    // returned raw name may have a trailing chunk byte after ".csv", and
    // matching against it (rather than requiring it) is what let this find
    // the ghost files in the first place.
    var raw = require("Storage").list(/^pw\d+\.csv/, { sf: true });
    var seen = {};
    var erased = 0;
    raw.forEach(function(name) {
      var m = name.match(/^pw\d+\.csv/);
      if (!m) return;
      var logicalName = m[0];
      if (seen[logicalName]) return;
      seen[logicalName] = true;
      // Storage.erase() is documented as not for StorageFiles — opening in
      // read mode and calling .erase() on the StorageFile object is what
      // correctly walks and erases every numbered chunk for this logical
      // name, regardless of how many chunks it actually has.
      require("Storage").open(logicalName, "r").erase();
      erased++;
    });
    console.log("Ghost StorageFile cleanup: erased " + erased + " old chunked file(s)");
  } catch (e) {
    return; // leave ghostFilesCleaned unset — retry next load
  }

  settings.ghostFilesCleaned = true;
  updateSettings(settings);
}

function saveData() {
  if (dataBuffer.length === 0) return;

  try {
    var timestamp = Math.floor(Date.now());  // Convert to integer (no decimals)
    var filename = "pw" + timestamp + ".csv";

    // Plain Storage.write(), not Storage.open()/StorageFile. StorageFile
    // stores content in chunks named "<filename>\1", "\2", etc (the chunk
    // number is a raw byte appended as the *last character* of the stored
    // name) — Storage.list()'s default output includes that suffix, which
    // breaks any regex anchored on `.csv$` (ours, everywhere in this
    // codebase, on both the watch and phone side) since the string no
    // longer ends in ".csv". The file was still written and permanently
    // consumed flash — just invisible to list()/read()/erase() by its
    // logical name, so it could never be synced or cleaned up. A single
    // plain write avoids chunking entirely (our per-flush data is at most
    // ~300 rows / ~12KB, well within one write), matching the plain
    // filename every reader in this app already assumes.
    var lines = ["timestamp,bpm,rr_interval_ms,confidence,accel_x,accel_y,accel_z"];
    for (var i = 0; i < dataBuffer.length; i++) {
      var d = dataBuffer[i];
      lines.push(d.t + "," + d.b + "," + d.r + "," + d.c + "," + d.x + "," + d.y + "," + d.z);
    }
    require("Storage").write(filename, lines.join("\n") + "\n");

    totalSaved += dataBuffer.length;
    dataBuffer = [];
    lastSaveTime = Math.floor(Date.now());  // Convert to integer (no decimals)
    
    // Update metadata
    var settings = loadSettings();
    settings.lastSave = timestamp;
    settings.totalRecordings = totalSaved;
    updateSettings(settings);
    
    // Update widget if it exists
    if (global.WIDGETS && WIDGETS["pulsewatch"]) {
      WIDGETS["pulsewatch"].draw();
    }
    
  } catch(e) {
    // Silent fail
  }
}

function onHRM(hrm) {
  if (!isRecording) return;

  var accel = Bangle.getAccel();
  var timestamp = Math.floor(Date.now());  // Convert to integer (no decimals)

  // Prepare data object
  var data = {
    t: timestamp,
    b: hrm.bpm || 0,
    c: hrm.confidence || 0,
    r: (Array.isArray(hrm.rr) && hrm.rr.length > 0)
       ? Math.round(hrm.rr[0])
       : (hrm.rr || 0),
    x: Math.round(accel.x * 1000),
    y: Math.round(accel.y * 1000),
    z: Math.round(accel.z * 1000)
  };

  dataBuffer.push(data);

  if (Math.floor(Date.now()) - lastSaveTime >= CONFIG.saveInterval) {
    saveData();
  }
}

exports.start = function() {
  if (isRecording) return;

  isRecording = true;
  startTime = Math.floor(Date.now());  // Convert to integer (no decimals)
  lastSaveTime = Math.floor(Date.now());  // Convert to integer (no decimals)
  dataBuffer = [];

  Bangle.on('HRM', onHRM);
  Bangle.setHRMPower(1, CONFIG.appName);
  persistRecordingFlag(true);

  console.log("✅ PulseWatch recording started");
};

exports.stop = function() {
  if (!isRecording) return;

  saveData();

  Bangle.removeListener('HRM', onHRM);
  Bangle.setHRMPower(0, CONFIG.appName);

  isRecording = false;
  persistRecordingFlag(false);
};

exports.isRecording = function() {
  return isRecording;
};

exports.getStatus = function() {
  var files = require('Storage').list(/^pw.*\.csv$/);
  var totalSize = 0;
  files.forEach(function(f) {
    var content = require('Storage').read(f);
    if (content) totalSize += content.length;
  });
  
  var settings = loadSettings();
  
  return {
    isRecording: isRecording,
    files: files.length,
    size: (totalSize / 1024).toFixed(1),
    lastSave: settings.lastSave || 0,
    totalRecordings: settings.totalRecordings || 0,
    bufferSize: dataBuffer.length,
    // Surfaced so app.js's on-watch menu (and the phone, if it ever wants
    // to show it) can show whether compactStorage() will actually reclaim
    // space on this watch's current firmware, without needing the BLE
    // console — see compactStorage()'s doc comment for why this isn't
    // unconditional.
    firmwareVersion: (process.env && process.env.VERSION) || "unknown",
    compactSafe: isCompactSafeFirmware()
  };
};

exports.deleteAllData = function() {
  var files = require('Storage').list(/^pw.*\.csv$/);
  files.forEach(function(f) {
    require('Storage').erase(f);
  });

  // Plain-file erase above misses any StorageFile-chunked ghost entries
  // (see cleanupGhostStorageFiles) — "delete all" should mean all.
  var ghosts = require('Storage').list(/^pw\d+\.csv/, { sf: true });
  var seen = {};
  ghosts.forEach(function(name) {
    var m = name.match(/^pw\d+\.csv/);
    if (!m || seen[m[0]]) return;
    seen[m[0]] = true;
    require('Storage').open(m[0], 'r').erase();
  });

  var settings = loadSettings();
  settings.lastSave = 0;
  settings.totalRecordings = 0;
  updateSettings(settings);

  totalSaved = 0;

  // Storage.erase() above only frees each file's slot in Espruino's Storage
  // index — it doesn't reclaim the underlying flash. Left uncompacted, that
  // space stays permanently unusable "trash" even though every file was
  // just erased. compact() is the only thing that actually defragments and
  // gives it back, so "delete all" should include it.
  exports.compactStorage();
};

// Defragments Storage, reclaiming flash held by erased-but-not-compacted
// file slots (see deleteAllData() and the per-file erase the phone's sync
// flow requests via this same function — ble_service.dart calls
// require("pulsewatch").compactStorage(), not Storage.compact() directly,
// specifically so it always goes through the two guards below rather than
// bypassing them). Wrapped defensively: compact() is a real flash rewrite
// and, per Espruino's docs, can take a noticeable moment on a heavily
// fragmented storage area — a failure here shouldn't be able to take down
// whatever called it.
exports.compactStorage = function() {
  try {
    // Guard 1: refuse on firmware where compact() is known to be able to
    // corrupt Storage outright (see MIN_COMPACT_SAFE_VERSION's comment).
    // Skipping just means erased space stays unreclaimed a while longer -
    // annoying, never destructive.
    if (!isCompactSafeFirmware()) {
      console.log("Storage.compact() skipped - firmware " +
        ((process.env && process.env.VERSION) || "?") +
        " predates the 2v26 fix for issue #2509");
      return;
    }
    // Guard 2: only worth the cost (and, even on fixed firmware, compact()
    // is still the single riskiest Storage operation this app calls) once
    // there's actually a meaningful amount to reclaim.
    var stats = require('Storage').getStats();
    // typeof-checked rather than just falsy: `undefined < N` is `false` in
    // JS, which would otherwise fail *open* (proceed to compact) if this
    // field were ever missing, instead of failing closed like every other
    // guard in this function.
    if (!stats || typeof stats.trashBytes !== 'number' || stats.trashBytes < COMPACT_TRASH_THRESHOLD_BYTES) return;

    require('Storage').compact();
  } catch (e) {
    // Silent fail
  }
};

// Reload - restart/stop based on current settings
exports.reload = function() {
  var settings = loadSettings();
  
  // Stop current recording if any
  if (isRecording) {
    Bangle.removeListener('HRM', onHRM);
    Bangle.setHRMPower(0, CONFIG.appName);
    isRecording = false;
  }
  
  // Start immediately if recording enabled
  if (settings.recording) {
    exports.start();
  }
};

// Call reload immediately when library loads
console.log("PulseWatch v" + VERSION + " loaded");
cleanupGhostStorageFiles();
exports.reload();