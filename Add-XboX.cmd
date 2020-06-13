@echo off
for /f "tokens=6 delims=[]. " %%G in ('ver') do if %%G lss 16299 goto :version
%windir%\system32\reg.exe query "HKU\S-1-5-19" 1>nul 2>nul || goto :uac
setlocal enableextensions
cd /d "%~dp0"

if not exist "*FlightDashboard*.appx" goto :nofiles
if not exist "*FlightDashboard*.cer" goto :nofiles
if not exist "*NET.Native.Framework*2.1*.appx" goto :nofiles
if not exist "*NET.Native.Runtime*2.1*.appx" goto :nofiles

set "PScommand=PowerShell -NoLogo -NoProfile -NonInteractive -InputFormat None -ExecutionPolicy Bypass"

echo.
echo ------------------------------------------------------------
echo Installing XboX Insider Hub
echo ============================================================
echo.
%PScommand% Import-Certificate -FilePath Microsoft.FlightDashboard_469.2003.9001.0_x64__8wekyb3d8bbwe.cer -CertStoreLocation Cert:\LocalMachine\Root
%PScommand% Add-AppxPackage "*NET.Native.Framework*2.1*.appx"
%PScommand% Add-AppxPackage "*NET.Native.Runtime*2.1*.appx"
%PScommand% Add-AppxPackage "*FlightDashboard*.appx"
goto :final

:uac
echo.
echo ------------------------------------------------------------
echo Run The Script In Admin Mode
echo ============================================================
echo.
echo.
echo Press any key to Exit
pause >nul
exit

:version
echo.
echo ------------------------------------------------------------
echo Only Support For Windows 1803+
echo ============================================================
echo.
echo.
echo Press any key to Exit
pause >nul
exit

:nofiles
echo.
echo ------------------------------------------------------------
echo Somefiles were missing, cannot execute...
echo ============================================================
echo.
echo.
echo Press any key to Exit
pause >nul
exit

:final
echo.
echo ------------------------------------------------------------
echo Finished
echo ============================================================
echo.
echo Press any Key to Exit.
pause >nul
exit
