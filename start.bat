@echo off
cd /d "%~dp0"
echo Serving on http://localhost:8000  (Ctrl+C to stop)
start "" http://localhost:8000/index.html
python -m http.server 8000
