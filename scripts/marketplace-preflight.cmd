@echo off
setlocal

REM Convenience wrapper for Windows users.
REM Runs the marketplace preflight checks using PowerShell 5.1+.

set "SCRIPT_DIR=%~dp0"
powershell -NoProfile -ExecutionPolicy Bypass -File "%SCRIPT_DIR%marketplace-preflight.ps1"
exit /b %ERRORLEVEL%
