# Pulsana site — what to fill in before launch

Plain HTML/CSS/JS, no build step. Open `index.html` directly in a browser,
or upload the whole folder to any static host (the `pulsana.org` domain
from your screenshots, GitHub Pages, Netlify, etc).

## Files
- `index.html` — home / project overview
- `join.html` — study agreement + placeholder "get your code" screen
- `instructions.html` — device setup walkthrough
- `faq.html` — 10 Q&A
- `contact.html` — email / WhatsApp / WeChat / per-person Telegram+WhatsApp+WeChat / contact form
- `assets/style.css` — all styling (colors match the app screenshots: sage green + cream)
- `assets/i18n.js` — every string in EN / RO / ZH — edit here to change copy or fix translations
- `assets/main.js` — language switcher + mobile nav + FAQ accordion
- `assets/join.js` — the front-end-only "reveal code" demo on join.html

## Still needs your input
1. **Photos** — drop files into `assets/photos/` using these exact names and
   they'll appear automatically (no HTML editing needed); until a file
   exists, the dashed placeholder box shows instead:
   - `step1-website-code.jpg`, `step1-app-enter-code.jpg` — ✅ filled in
   - `step2-device-icon.jpg` — ✅ filled in (step 2 now only shows this
     one photo — there was no second real screenshot for it, so the empty
     placeholder slot was removed rather than left dangling)
   - `step3-device-list.jpg` — ✅ filled in (same thing — step 3 is a
     single photo now, no "connected" placeholder box)
   - `step5-app-list.jpg`, `step5-record-screen.jpg` — ✅ filled in
     (cropped from your `bangle_on_wrist.jpg`)
   (Step 4 and step 6 don't have photo slots — step 4 is a bullet list,
   step 6 is text-only.)
   
   If you do get a second real screenshot for step 2 (mid-scan) or step 3
   (connected confirmation) later, just add a second `.photo-slot` block
   back in `instructions.html` next to the existing one — copy the
   pattern from step 5, which still has two.
2. **Video** — ✅ set to your real tutorial
   (`https://youtu.be/UnONfSz2LXM`). If you ever need to swap it for a
   re-upload or a new cut, open `instructions.html`, find
   `data-youtube-id="UnONfSz2LXM"`, and replace it with the new video's ID
   (the part after `v=` or after `youtu.be/` in the URL, before any `?`).
3. **Bracelet Bluetooth name** — ✅ filled in as "Bangle.js 5993" in
   `instr_step3_watch_name` (all three languages). If you ever pair a
   different unit, search `i18n.js` for that key to update it.
4. **Consent text** — `join_consent_li1..li5` on the join page is a
   *draft* summary I wrote for this preview, flagged as such on the page
   itself. Swap it for your faculty's reviewed consent form before this
   goes live.
5. **Real enrollment flow** — `join.html` only *previews* the "you're all
   set" screen with a hardcoded demo code (`TRCZFBPD`). Your colleague's
   backend needs to be wired in to actually generate codes and links.
6. **WeChat QR codes** — ✅ filled in (`assets/fateme_qr.png` and
   `assets/daria_qr.png`), cropped from the screenshots you sent so just
   the scannable code shows on the contact page.
7. **Download link** — the "Download the Android app" button on
   `join.html` points to `#`; point it at your APK / Play Store link.

## How the photo/QR fallback works
Every photo and QR spot is a real `<img>` tag pointing at the filename
above, with a dashed placeholder sitting behind it. If the browser can't
load the image (because the file isn't there yet, or the name doesn't
match exactly — case-sensitive on most web hosts), it quietly falls back
to the placeholder instead of showing a broken-image icon. So you can
add images one at a time, in any order, and the site always looks
intentional either way.


## Language switcher
Stored in `localStorage` under `pulsana-lang`, defaults to the visitor's
browser language (falls back to English). Add a new string anywhere by
adding the same key to all three (`en`, `ro`, `zh`) blocks in `i18n.js`
and referencing it with `data-i18n="yourKey"` in the HTML.
