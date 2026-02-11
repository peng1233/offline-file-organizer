@echo off
setlocal

set "ROOT=%~dp0"

rem Lightweight help in pure CMD so users can discover flags quickly.
if /I "%~1"=="-h" goto :help
if /I "%~1"=="-help" goto :help
if /I "%~1"=="/h" goto :help
if /I "%~1"=="/help" goto :help
if "%~1"=="/?" goto :help

rem Pass through any arguments to open.ps1 (e.g. -Server, -Lite, -NoOpen)
powershell -NoProfile -ExecutionPolicy Bypass -File "%ROOT%open.ps1" %*

endlocal
exit /b %errorlevel%

:help
echo offline-file-organizer launcher
echo.
echo Usage:
echo   open.cmd                ^(open index.html via file://^)
echo   open.cmd -Lite          ^(open lite/index.html via file://^)
echo   open.cmd -NoOpen        ^(print path only, do not open browser^)
echo   open.cmd -Server        ^(serve via http://127.0.0.1:5173^)
echo   open.cmd -Server -Port 8080
echo   open.cmd -Server -Lite  ^(serve lite at /lite/^)
echo.
echo Notes:
echo   -Server delegates to tools\serve.ps1 which uses Node.js when available,
echo   otherwise falls back to Python.
echo.
endlocal
exit /b 0
