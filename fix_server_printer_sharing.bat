@echo off
echo ===============================================
echo    SERVER PC - FIX PRINTER SHARING
echo ===============================================
echo.
echo This script is for the PC that HAS the printer installed
echo and wants to SHARE it with other PCs on the network
echo.
echo Fixing error 0x00011b for printer sharing...
echo.
echo WARNING: This requires Administrator privileges!
echo.
pause

echo.
echo [1/6] Fixing Registry for Server Sharing...
echo Setting RpcAuthnLevelPrivacyEnabled = 0...
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Print" /v RpcAuthnLevelPrivacyEnabled /t REG_DWORD /d 0 /f
if %errorlevel% equ 0 (
    echo SUCCESS: Registry setting updated for server sharing
) else (
    echo ERROR: Failed to update registry
    echo Please run this script as Administrator
    pause
    exit /b 1
)

echo.
echo [2/6] Stopping Print Services...
net stop spooler
sc stop "PrintNotify"
timeout /t 3 /nobreak >nul

echo.
echo [3/6] Enabling Printer Sharing...
netsh advfirewall firewall set rule group="File and Printer Sharing" new enable=Yes
netsh advfirewall firewall set rule group="Network Discovery" new enable=Yes
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Printers" /v DisableWebPnPDownload /t REG_DWORD /d 0 /f

echo.
echo [4/6] Starting Print Services...
net start spooler
sc start "PrintNotify"
timeout /t 3 /nobreak >nul

echo.
echo [5/6] Enabling SMB Sharing...
sc config "LanmanServer" start= auto
sc start "LanmanServer"
sc config "LanmanWorkstation" start= auto
sc start "LanmanWorkstation"

echo.
echo [6/6] Setting Printer Permissions...
echo Enabling printer sharing permissions...
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Print" /v RestrictDriverInstallationToAdministrators /t REG_DWORD /d 0 /f

echo.
echo ===============================================
echo    SERVER FIX COMPLETE!
echo ===============================================
echo.
echo The server PC is now configured to share printers.
echo.
echo NEXT STEPS:
echo 1. Go to Control Panel ^> Devices and Printers
echo 2. Right-click your printer ^> Printer Properties
echo 3. Go to Sharing tab ^> Check "Share this printer"
echo 4. Give it a share name (e.g., "CanonPrinter")
echo 5. Tell other PCs to run the CLIENT_PC scripts
echo.
echo IMPORTANT: Make sure your printer is actually shared!
echo.
pause
