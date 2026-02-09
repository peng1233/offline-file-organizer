@echo off
setlocal

set "PS_SCRIPT=%~dp0marketplace-pack.ps1"

if not exist "%PS_SCRIPT%" (
  echo [ERR] missing: %PS_SCRIPT%
  exit /b 2
)

powershell -NoProfile -ExecutionPolicy Bypass -File "%PS_SCRIPT%" %*
set EXITCODE=%ERRORLEVEL%
echo EXITCODE=%EXITCODE%
exit /b %EXITCODE%
