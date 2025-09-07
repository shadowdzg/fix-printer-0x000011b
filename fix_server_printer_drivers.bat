@echo off
echo ===============================================
echo    SERVER PC - FIX PRINTER DRIVERS
echo ===============================================
echo.
echo This script fixes printer driver issues on the server PC
echo that can cause "impression en cours" errors.
echo.
echo WARNING: This requires Administrator privileges!
echo.
pause

echo.
echo [1/6] Stopping Print Services...
net stop spooler
sc stop "PrintNotify"
timeout /t 2 /nobreak >nul

echo.
echo [2/6] Fixing Driver Installation Permissions...
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Print" /v RestrictDriverInstallationToAdministrators /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Print" /v RpcAuthnLevelPrivacyEnabled /t REG_DWORD /d 0 /f
echo Driver permissions fixed

echo.
echo [3/6] Enabling Driver Download and Sharing...
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Printers" /v DisableWebPnPDownload /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Print" /v DisableServerThread /t REG_DWORD /d 0 /f
echo Driver sharing enabled

echo.
echo [4/6] Starting Print Services...
net start spooler
sc start "PrintNotify"
timeout /t 3 /nobreak >nul

echo.
echo [5/6] Resetting Printer Sharing...
netsh advfirewall firewall set rule group="File and Printer Sharing" new enable=Yes
netsh advfirewall firewall set rule group="Network Discovery" new enable=Yes

echo.
echo [6/6] Testing Print Services...
sc query spooler | find "RUNNING" >nul
if %errorlevel% equ 0 (
    echo SUCCESS: Print services are running
) else (
    echo WARNING: Print services may not be running properly
)

echo.
echo ===============================================
echo    SERVER PRINTER DRIVERS FIXED!
echo ===============================================
echo.
echo The following driver issues have been fixed:
echo - Driver installation permissions enabled
echo - RPC authentication issues resolved
echo - Web driver download enabled
echo - Driver sharing enabled for network clients
echo - Print services restarted
echo - Printer sharing reset
echo.
echo IMPORTANT: After this fix, you may need to:
echo 1. Re-share your printer (Control Panel > Devices and Printers)
echo 2. Tell client PCs to reconnect to the printer
echo 3. Try printing a test page
echo.
pause
