@echo off
setlocal

set "ROOT=%~dp0"
rem Pass through any arguments to open.ps1 (e.g. -Server, -Lite, -NoOpen)
powershell -NoProfile -ExecutionPolicy Bypass -File "%ROOT%open.ps1" %*

endlocal
