# Nizomiddin Soibnazarov: portfolio

A portfolio that plays like a short story instead of a page of text.

A small star glows in a spiral galaxy. Click it and a Big Bang goes off. Six stars are left hanging in the dark: About me, Projects, Skills, Activities, Interests, Contact. Click one and the camera flies into it, then a full-screen panel opens with the real content.

Built with Three.js (custom GLSL shaders, bloom) and plain HTML and CSS. No framework, no build step.

## Run it locally

The site has to be served over http, so don't just double-click `index.html`.

- Windows: double-click `start.bat` (needs Python). It opens http://localhost:8000/index.html
- Mac or Linux: run `./start.sh`
- Anything else: `python -m http.server 8000` in this folder

## Deploy

It is a static site. Point any static host at the repo root with no build command and no output directory (Vercel, Netlify, GitHub Pages all work).

## What is in here

| Path | What it is |
| --- | --- |
| `index.html` | The whole site: styles, template, and the Three.js scene |
| `support.js` | Small template runtime the page needs. Don't edit |
| `vendor/bb-three.js` | Three.js bundled into one file |
| `img/` | Blender renders and certificate images |
| `source/` | Original design-canvas version and the files to rebuild the Three.js bundle |
| `HANDOFF.md` | How the code is laid out, current progress, known issues |

To change text, edit the panel sections in `index.html`. `HANDOFF.md` lists where each piece lives.

## Notes

- Works on desktop and phone. With reduced motion turned on, the animations shorten. Without WebGL, a plain CSS background takes over.
- Fonts (Unbounded, IBM Plex Mono, Instrument Serif) load from Google Fonts.

## Contact

[GitHub](https://github.com/nvidiarogforce-art) · [LinkedIn](https://www.linkedin.com/in/nizomiddin-soibnazarov) · [Chess.com](https://www.chess.com/member/4ereb1)
