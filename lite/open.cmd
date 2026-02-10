@echo off
setlocal

REM One-click launcher for Windows users who prefer double-clicking a .cmd file.
REM It runs the PowerShell script next to it (open.ps1) to open Lite in your browser.

set "SCRIPT_DIR=%~dp0"
set "PS1=%SCRIPT_DIR%open.ps1"

if not exist "%PS1%" (
  echo ERROR: Not found: %PS1%
  exit /b 1
)

powershell -NoProfile -ExecutionPolicy Bypass -File "%PS1%" %*
set EXITCODE=%ERRORLEVEL%

if not "%EXITCODE%"=="0" (
  echo.
  echo Failed with exit code %EXITCODE%
  exit /b %EXITCODE%
)

exit /b 0
