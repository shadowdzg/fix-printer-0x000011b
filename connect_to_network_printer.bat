@echo off
echo ===============================================
echo    CLIENT PC - CONNECT TO NETWORK PRINTER
echo ===============================================
echo.
echo This script helps you connect to a network printer
echo from this client PC.
echo.
echo You will need:
echo - The IP address of the PC with the printer
echo - The name of the printer
echo.

set /p printer_ip="Enter the IP address of the PC with the printer: "
set /p printer_name="Enter the name of the printer: "

echo.
echo Attempting to connect to printer...
echo IP: %printer_ip%
echo Printer: %printer_name%
echo.

echo [1/3] Testing network connection...
ping -n 1 %printer_ip% >nul
if %errorlevel% equ 0 (
    echo SUCCESS: Can reach the printer PC
) else (
    echo ERROR: Cannot reach the printer PC at %printer_ip%
    echo Please check the IP address and network connection
    pause
    exit /b 1
)

echo.
echo [2/3] Adding printer connection...
rundll32 printui.dll,PrintUIEntry /in /n "\\%printer_ip%\%printer_name%"
if %errorlevel% equ 0 (
    echo SUCCESS: Printer connection added
) else (
    echo WARNING: Could not add printer connection automatically
    echo You may need to add it manually through Control Panel
)

echo.
echo [3/3] Setting as default printer...
rundll32 printui.dll,PrintUIEntry /y /n "\\%printer_ip%\%printer_name%"

echo.
echo ===============================================
echo    CONNECTION ATTEMPT COMPLETE!
echo ===============================================
echo.
echo If the connection failed:
echo 1. Make sure the SERVER PC has run the SERVER_PC scripts
echo 2. Check that printer sharing is enabled on the server
echo 3. Try adding the printer manually through:
echo    Control Panel ^> Devices and Printers ^> Add Printer
echo.
pause
