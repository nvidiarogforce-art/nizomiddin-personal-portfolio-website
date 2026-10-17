# HANDOFF: Nizomiddin Soibnazarov portfolio

Last updated: 2026-10-17. Read this whole file before changing anything.

## What this is

A personal portfolio built as a small story instead of a page of text.

1. A loading screen counts up while the shaders compile.
2. The landing page is a spiral galaxy with one small glowing star. The visitor clicks it.
3. The star charges, then a Big Bang goes off: sparks, trails, shockwave rings, gas clouds, a flash, bloom.
4. Six stars are left hanging in the dark, each with a label: About me, Projects, Skills, Activities, Interests, Contact.
5. Clicking a star zooms the camera into it, and a full-screen panel opens with a circular reveal from that star. "Back to the stars" reverses it.

Stack: Three.js 0.186.1 for the 3D (custom GLSL, additive blending, UnrealBloom), a reactive HTML template for the panels, no build step for the page itself.

## Run it

It must be served over http. Double-clicking index.html mostly renders but logs a CORS error, so don't rely on it.

- Windows: double-click `start.bat` (needs Python), it opens http://localhost:8000/index.html
- Mac/Linux: `./start.sh`
- Any static host works as-is (Vercel, Netlify, GitHub Pages). Upload the whole folder. Nothing to build.

Google Fonts (Unbounded, IBM Plex Mono, Instrument Serif) load from the internet. Offline, the page falls back to system fonts and still works.

## Files

```
index.html          the entire site: CSS, HTML template, JS logic (about 1,460 lines)
support.js          the "dc runtime": React plus the <x-dc> template engine. Do not edit.
vendor/bb-three.js  Three.js bundled to one file, exposes the global BBThree. Minified.
img/                two Blender renders, two certificate images
source/Main.dc.html the same page in its original Claude Design form (see below)
source/canvas.json  Claude Design canvas index
source/bundle/      entry.js + package.json to rebuild vendor/bb-three.js
```

### Two versions of the same page

`index.html` and `source/Main.dc.html` are identical except for one line: the Three.js script tag. In Claude Design it points at an uploaded asset (`/_blob/...`). In `index.html` it points at `./vendor/bb-three.js`. If you edit one, copy the change to the other.

### Rebuilding vendor/bb-three.js

Only needed if the page starts using a Three.js class that is not exported yet.

```
cd source/bundle
npm install
# add the new class to the import/export lines in entry.js, then:
npx esbuild entry.js --bundle --minify --format=iife --global-name=BBThree --outfile=../../vendor/bb-three.js
```

## How index.html is laid out

- Lines 1-9: head, loads support.js and the Three bundle.
- Lines 10-271: `<x-dc>`, then `<helmet>` holding all CSS. Media queries near the end (hover: none, 980px, 860px, reduced motion).
- Lines 272-594: the template. Canvas `#bb-gl`, HUD, the seed star button, flash, the six orb buttons (`<sc-for>`), the panel with six `<sc-if>` sections (about, projects, skills, activities, interests, contact), the loader.
- Line 596: `ORBS` array. Each star has id, number, name, hint, colour, and screen positions for landscape (`land`) and portrait (`port`) as [x%, y%]. The 3D stars and the HTML labels both read these, which is what keeps them aligned.
- Lines 614-775: GLSL shader strings.
- Line 776: `class Component extends DCLogic`. State machine: loading, idle, charge, bang, stars, warp, panel, back. Methods: `boot`, `loadTick`, `finishLoad`, `doIgnite`, `openSection`, `doClose`, `focusBack`, `renderVals` (everything the template can read), `buildWorld` (all the Three.js code, returns an object with startIntro, charge, boom, warp, resize, dispose, hover).

Template rules of this engine, learned the hard way: only values returned by `renderVals()` can be used inside `{{ }}`. Handlers are whole-value, like `onClick="{{ fn }}"`. Control flow is `<sc-if>` and `<sc-for>`. The script is classic JS, no imports.

## Where the content lives (edit here to change text)

All content is plain HTML inside the panel sections of index.html. Search for these:

- About: `01 / About me`. Name, tagline, blurb, the four fact rows.
- Projects: `02 / Projects`. Six `<article class="card">` blocks. Each has a status chip, description, tag chips, links.
- Skills: `chip` spans, placed on three orbit rings by their `--a` angle.
- Activities: the `.tl` timeline. Items alternate left and right (class `r`).
- Interests: `.planet` links. Chess links to chess.com.
- Contact: `.rows`.
- The star labels and hints: `ORBS`.

## Content as of today (all given by the owner)

- Name: Nizomiddin Soibnazarov. City: Gulistan, Uzbekistan.
- Tagline: "My own curiosity led me to computer science."
- Languages: C# (Unity), Python, TypeScript, C++, JavaScript, HTML, CSS.
- Tests: IELTS 7. SAT 1410 (October; 800 Math, 610 English). The earlier August SAT was 1350.
- Projects: Arduinium (live at arduinium.vercel.app, old public repo ArduiniumV2-main), MitaAI (MiSide mod, github.com/nvidiarogforce-art/MitaAI), Chess.com game analyzer (public repo), Nukerod Beta (CurseForge), Blender scenes, small Unity games.
- Results: 1st place in Uzbekistan, 2026 Purple Comet Math Meet, high school mixed team "F Students" (28 of 30). ICO Uzbekistan 2026 Round 1, 76th of 1,200 (the certificate itself only says 200+ points, the rank is the owner's statement).
- Links: github.com/nvidiarogforce-art, linkedin.com/in/nizomiddin-soibnazarov, chess.com/member/4ereb1.
- Project card text was checked against the public GitHub and CurseForge pages. MitaAI's text follows the owner's own description.

## Progress

Done
- Concept, art direction, and the full Big Bang sequence.
- Loader, charge, bang, star reveal, camera zoom, panel reveal, return trip.
- All six panels with real content, and a crossfading Blender card.
- Phone layout (separate portrait star positions), reduced-motion path, no-WebGL CSS fallback, weak-device quality tier.
- Verified in headless Chromium (software WebGL) at 1440x900 and 390x844: page boots, WebGL initialises, six stars appear, click on the seed starts the bang, stars open About and Projects panels, no script errors.

Not done / open
- Photo. The About panel shows a "Photo coming soon" frame. Clicking it lets a visitor preview a local image, but that is not saved. To ship a photo: put it in `img/`, and in `renderVals()` set the default of `photo` (it reads `s.photo`) to that path, or replace the empty-state markup with a plain `<img>`.
- Public email and Telegram. No row exists yet. Contact has four link rows (GitHub, LinkedIn, Chess.com, CurseForge). Add rows in the `.rows` block. The `copyMail` handler already exists in the script for a copy-email button.
- The owner said design adjustments and "new things" are coming. Not specified yet. Ask.
- Timing and feel on a real GPU is unreviewed. All testing used software rendering, which is slow and exaggerates the flash. Judge bloom strength and the length of the white flash on real hardware before tuning.
- Real touch devices untested (only an emulated viewport).
- Possible extras the owner may want: downloadable CV, Uzbek or Russian toggle, a sound toggle.

## Known issues

- On a 390px-wide phone, the "Back to the stars" button wraps onto two lines. Cosmetic.
- One harmless 404 at load for the literal URL `{{ photo }}`. The hidden photo `<img>` is requested once before the template engine renders. Ignore it, or remove it by rendering the image only after a photo exists.
- `file://` opening logs a CORS error (the runtime fetches its own page). Use the local server.

## Rules for whoever edits next

- Keep `index.html` and `source/Main.dc.html` in sync (one differing line, see above).
- Do not add visitor-facing text that was not given by the owner. No invented achievements, numbers or claims. The brief is explicit: no filler, no clutter, no "AI slop".
- Keep the olympiad rank and every score exactly as the owner stated.
- The wow moment is the sequence. Do not add loading spinners, cookie-style popups or extra windows on top of it.
- Test the bang on desktop and phone after any change to `buildWorld`, the shaders or `ORBS` positions.

## Origin

Built in a Claude chat session in the "portfolio website" project (Claude Design canvas, then exported). The private working copy lives at claude.ai under that project.
