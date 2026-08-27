// Shared behaviour: language application, mobile nav, FAQ accordion.

// Used by <img onerror="pulsanaImgFallback(this)"> in instructions.html and
// contact.html: if a real photo hasn't been uploaded yet under the expected
// filename, silently fall back to the dashed placeholder box next to it.
window.pulsanaImgFallback = function (img) {
  img.style.display = "none";
  var sibling = img.nextElementSibling;
  if (sibling) sibling.style.display = "flex";
};

(function () {
  var STORAGE_KEY = "pulsana-lang";

  function getLang() {
    var saved = null;
    try { saved = localStorage.getItem(STORAGE_KEY); } catch (e) {}
    if (saved && window.I18N && window.I18N[saved]) return saved;
    var nav = (navigator.language || "en").toLowerCase();
    if (nav.indexOf("ro") === 0) return "ro";
    if (nav.indexOf("zh") === 0) return "zh";
    return "en";
  }

  function setLang(lang) {
    if (!window.I18N || !window.I18N[lang]) return;
    try { localStorage.setItem(STORAGE_KEY, lang); } catch (e) {}
    document.documentElement.setAttribute("lang", lang);
    var dict = window.I18N[lang];

    document.querySelectorAll("[data-i18n]").forEach(function (el) {
      var key = el.getAttribute("data-i18n");
      var val = dict[key];
      if (val !== undefined) el.innerHTML = val;
    });
    document.querySelectorAll("[data-i18n-attr]").forEach(function (el) {
      el.getAttribute("data-i18n-attr").split(";").forEach(function (pair) {
        var parts = pair.split(":");
        if (parts.length !== 2) return;
        var attr = parts[0].trim(), key = parts[1].trim();
        if (dict[key] !== undefined) el.setAttribute(attr, dict[key]);
      });
    });
    document.querySelectorAll(".lang-switch button").forEach(function (btn) {
      btn.classList.toggle("active", btn.getAttribute("data-lang") === lang);
    });
  }

  window.PulsanaI18n = { get: getLang, set: setLang };

  document.addEventListener("DOMContentLoaded", function () {
    setLang(getLang());

    // Swap the video placeholder for a real embed once a YouTube video ID
    // is filled in on the .video-frame element's data-youtube-id attribute.
    var videoFrame = document.querySelector(".video-frame[data-youtube-id]");
    if (videoFrame) {
      var ytId = videoFrame.getAttribute("data-youtube-id").trim();
      if (ytId) {
        var iframe = document.createElement("iframe");
        iframe.src = "https://www.youtube.com/embed/" + encodeURIComponent(ytId);
        iframe.title = "Pulsana device setup tutorial";
        iframe.frameBorder = "0";
        iframe.allow = "accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture";
        iframe.allowFullscreen = true;
        iframe.style.cssText = "position:absolute; inset:0; width:100%; height:100%; border:0; border-radius:inherit;";
        videoFrame.style.position = "relative";
        videoFrame.innerHTML = "";
        videoFrame.appendChild(iframe);
      }
    }

    document.querySelectorAll(".lang-switch button").forEach(function (btn) {
      btn.addEventListener("click", function () {
        setLang(btn.getAttribute("data-lang"));
      });
    });

    var toggle = document.querySelector(".nav-toggle");
    var links = document.querySelector(".nav-links");
    if (toggle && links) {
      toggle.addEventListener("click", function () {
        links.classList.toggle("open");
      });
    }

    document.querySelectorAll(".faq-item").forEach(function (item) {
      var q = item.querySelector(".faq-q");
      if (!q) return;
      q.addEventListener("click", function () {
        item.classList.toggle("open");
      });
    });
  });
})();
