@echo off
rem ============================================================
rem  Laundry Reminder - Windows launcher
rem  Opens index.html as a standalone app window.
rem  Tries Edge first, then Chrome, then the default browser.
rem ============================================================
setlocal

set "HTML=%~dp0index.html"
if not exist "%HTML%" (
  echo.
  echo   index.html was not found next to this script.
  echo   Keep laundry-reminder.bat and index.html in the same folder.
  echo.
  pause
  exit /b 1
)
set "URL=file:///%HTML:\=/%"

rem --- locate a Chromium browser (Edge is on every Windows 10/11 machine) ---
set "EDGE_64=%ProgramFiles%\Microsoft\Edge\Application\msedge.exe"
set "EDGE_32=%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe"
set "EDGE_USR=%LocalAppData%\Microsoft\Edge\Application\msedge.exe"
set "CHROME_64=%ProgramFiles%\Google\Chrome\Application\chrome.exe"
set "CHROME_32=%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe"
set "CHROME_USR=%LocalAppData%\Google\Chrome\Application\chrome.exe"

set "BROWSER="
if exist "%EDGE_64%"   set "BROWSER=%EDGE_64%"
if not defined BROWSER if exist "%EDGE_32%"   set "BROWSER=%EDGE_32%"
if not defined BROWSER if exist "%EDGE_USR%"  set "BROWSER=%EDGE_USR%"
if not defined BROWSER if exist "%CHROME_64%" set "BROWSER=%CHROME_64%"
if not defined BROWSER if exist "%CHROME_32%" set "BROWSER=%CHROME_32%"
if not defined BROWSER if exist "%CHROME_USR%" set "BROWSER=%CHROME_USR%"

if defined BROWSER (
  start "" "%BROWSER%" --app="%URL%" --window-size=460,820
) else (
  rem no Chromium found - fall back to whatever opens .html files
  start "" "%HTML%"
)
