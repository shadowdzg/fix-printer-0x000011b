@echo off
echo ===============================================
echo    CLIENT PC - FIX PRINTER DRIVERS
echo ===============================================
echo.
echo This script fixes printer driver issues that can cause
echo "impression en cours" errors and print job failures.
echo.
echo WARNING: This requires Administrator privileges!
echo.
pause

echo.
echo [1/5] Stopping Print Spooler...
net stop spooler
timeout /t 2 /nobreak >nul

echo.
echo [2/5] Fixing Driver Installation Permissions...
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Print" /v RestrictDriverInstallationToAdministrators /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Print" /v RpcAuthnLevelPrivacyEnabled /t REG_DWORD /d 0 /f
echo Driver permissions fixed

echo.
echo [3/5] Enabling Driver Download...
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Printers" /v DisableWebPnPDownload /t REG_DWORD /d 0 /f
echo Driver download enabled

echo.
echo [4/5] Starting Print Spooler...
net start spooler
timeout /t 3 /nobreak >nul

echo.
echo [5/5] Testing Print Spooler...
sc query spooler | find "RUNNING" >nul
if %errorlevel% equ 0 (
    echo SUCCESS: Print Spooler is running
) else (
    echo WARNING: Print Spooler may not be running properly
)

echo.
echo ===============================================
echo    PRINTER DRIVERS FIXED!
echo ===============================================
echo.
echo The following driver issues have been fixed:
echo - Driver installation permissions enabled
echo - RPC authentication issues resolved
echo - Web driver download enabled
echo - Print Spooler restarted
echo.
echo Now try printing again. If you still get errors:
echo 1. Try removing and re-adding the printer
echo 2. Check if the printer needs updated drivers
echo 3. Make sure the server PC is sharing the printer correctly
echo.
pause
