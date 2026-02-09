@echo off
setlocal

rem Wrapper for Windows CMD users.
rem Calls the PowerShell implementation and preserves exit code.

set "SCRIPT_DIR=%~dp0"
powershell -NoProfile -ExecutionPolicy Bypass -File "%SCRIPT_DIR%copy-marketplace-asset.ps1" %*
exit /b %ERRORLEVEL%
