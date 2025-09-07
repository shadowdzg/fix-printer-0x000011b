@echo off
echo ===============================================
echo    CLIENT PC - FIX PRINTER CONNECTION
echo ===============================================
echo.
echo This script is for the PC that wants to CONNECT to a printer
echo (not the PC that has the printer installed)
echo.
echo Fixing error 0x00011b for client connections...
echo.
echo WARNING: This requires Administrator privileges!
echo.
pause

echo.
echo [1/5] Fixing Registry for Client Connection...
echo Setting RpcAuthnLevelPrivacyEnabled = 0...
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Print" /v RpcAuthnLevelPrivacyEnabled /t REG_DWORD /d 0 /f
if %errorlevel% equ 0 (
    echo SUCCESS: Registry setting updated for client connection
) else (
    echo ERROR: Failed to update registry
    echo Please run this script as Administrator
    pause
    exit /b 1
)

echo.
echo [2/5] Stopping Print Spooler...
net stop spooler
timeout /t 2 /nobreak >nul

echo.
echo [3/5] Enabling Network Discovery...
netsh advfirewall firewall set rule group="Network Discovery" new enable=Yes
netsh advfirewall firewall set rule group="File and Printer Sharing" new enable=Yes

echo.
echo [4/5] Flushing DNS Cache...
ipconfig /flushdns
ipconfig /registerdns

echo.
echo [5/5] Starting Print Spooler...
net start spooler
if %errorlevel% equ 0 (
    echo SUCCESS: Print Spooler started
) else (
    echo WARNING: Could not start Print Spooler
)

echo.
echo ===============================================
echo    CLIENT FIX COMPLETE!
echo ===============================================
echo.
echo The client PC is now configured to connect to network printers.
echo.
echo NEXT STEPS:
echo 1. Try connecting to the printer again
echo 2. If it still doesn't work, make sure the SERVER PC
echo    (the one with the printer) has run the SERVER_PC scripts
echo 3. Restart your computer if needed
echo.
pause
