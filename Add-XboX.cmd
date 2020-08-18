
@echo off
for /f "tokens=6 delims=[]. " %%G in ('ver') do if %%G lss 16299 goto :version
%windir%\system32\reg.exe query "HKU\S-1-5-19" 1>nul 2>nul || goto :uac
setlocal enableextensions
cd /d "%~dp0"

if not exist "*FlightDashboard*.appx" goto :nofiles
if not exist "*FlightDashboard*.cer" goto :nofiles

if not exist "Arm\*NET.Native.Framework*2.1*.appx" goto :nofiles
if not exist "Arm\*NET.Native.Runtime*2.1*.appx" goto :nofiles

if not exist "x64\*NET.Native.Framework*2.1*.appx" goto :nofiles
if not exist "x64\*NET.Native.Runtime*2.1*.appx" goto :nofiles

if not exist "x86\*NET.Native.Framework*2.1*.appx" goto :nofiles
if not exist "x86\*NET.Native.Runtime*2.1*.appx" goto :nofiles

set "PScommand=PowerShell -NoLogo -NoProfile -NonInteractive -InputFormat None -ExecutionPolicy Bypass"
set "Add=Add-AppxPackage"

:Menu
echo.
echo ------------------------------------------------------------
echo 1. Install Depedency (Required In Order XboX to Run)
echo ============================================================
echo ------------------------------------------------------------
echo 2. Install XboX Insider Hub (Do this after Depedency already Installed)
echo ============================================================
echo.
set /p op=
if "%op%"=="1" goto :Depedency
if "%op%"=="2" goto :APPX

:APPX
echo.
echo ============================================================
echo Adding XboX Insider Hub Certificate
echo ============================================================
echo.
%PScommand% Import-Certificate "*FlightDashboard*.cer" -CertStoreLocation Cert:\LocalMachine\Root
echo.
echo ============================================================
echo Installing XboX Insider Hub
echo ============================================================
echo.
%PScommand% %Add% "*FlightDashboard*.appx"
echo.
echo ============================================================
echo XboX Insider Hub Installed!
echo ============================================================
echo.
timeout 3
goto :final

:Depedency
echo.
echo ------------------------------------------------------------
echo 1. Depedency (Arm)
echo ============================================================
echo ------------------------------------------------------------
echo 2. Depedency x64 (64 Bit)
echo ============================================================
echo ------------------------------------------------------------
echo 3. Depedency x32 (32 Bit)
echo ============================================================
echo.
set /p op=
if "%op%"=="1" goto :Arm
if "%op%"=="2" goto :x64
if "%op%"=="3" goto :x86

:Arm
echo.
echo ============================================================
echo Installing Microsoft.NET.Native.Framework.2.1_2.1.27427.0 (Arm)
echo ============================================================
echo.
%PScommand% %Add% "Arm\*NET.Native.Framework*2.1*.appx"
echo.
echo ============================================================
echo Installing Microsoft.NET.Native.Runtime.2.1_2.1.26424.0 (Arm)
echo ============================================================
echo.
%PScommand% %Add% "Arm\*NET.Native.Runtime*2.1*.appx"
echo.
echo ============================================================
echo Depedency (Arm) Installed!
echo ============================================================
echo.
timeout 3
goto :Menu

:x64
echo.
echo ============================================================
echo Installing Microsoft.NET.Native.Framework.2.1_2.1.27427.0 (x64)[64 Bit]
echo ============================================================
echo.
%PScommand% %Add% "x64\*NET.Native.Framework*2.1*.appx"
echo.
echo ============================================================
echo Installing Microsoft.NET.Native.Runtime.2.1_2.1.26424.0 (x64) [64 Bit]
echo ============================================================
echo.
%PScommand% %Add% "x64\*NET.Native.Runtime*2.1*.appx"
echo.
echo ============================================================
echo Depedency x64 (64 Bit) Installed!
echo ============================================================
echo.
timeout 3
goto :Menu

:x86
echo.
echo ============================================================
echo Installing Microsoft.NET.Native.Framework.2.1_2.1.27427.0 (x86) [32 Bit]
echo ============================================================
echo.
%PScommand% %Add% "x86\*NET.Native.Framework*2.1*.appx"
echo.
echo ============================================================
echo Installing Microsoft.NET.Native.Runtime.2.1_2.1.26424.0 (x86) [32 Bit]
echo ============================================================
echo.
%PScommand% %Add% "x86\*NET.Native.Runtime*2.1*.appx"
echo.
echo ============================================================
echo Depedency x86 (32 Bit) Installed!
echo ============================================================
echo.
timeout 3
goto :Menu

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
echo Only Support For Windows 18362.0+
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
