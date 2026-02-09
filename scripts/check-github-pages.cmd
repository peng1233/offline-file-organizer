@echo off
setlocal
REM Wrapper for PowerShell script (for users who prefer cmd.exe)

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0check-github-pages.ps1" %*
set EXITCODE=%ERRORLEVEL%
echo EXITCODE=%EXITCODE%
exit /b %EXITCODE%
