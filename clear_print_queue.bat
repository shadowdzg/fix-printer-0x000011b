@echo off
echo ===============================================
echo    CLIENT PC - CLEAR PRINT QUEUE
echo ===============================================
echo.
echo This script quickly clears the print queue
echo to resolve stuck print jobs.
echo.

echo [1/3] Stopping Print Spooler...
net stop spooler
timeout /t 2 /nobreak >nul

echo [2/3] Clearing Print Queue...
del /q /f "%SystemRoot%\System32\spool\PRINTERS\*" 2>nul
echo Print queue cleared

echo [3/3] Starting Print Spooler...
net start spooler
timeout /t 2 /nobreak >nul

echo.
echo ===============================================
echo    PRINT QUEUE CLEARED!
echo ===============================================
echo.
echo The print queue has been cleared.
echo Try printing again now.
echo.
pause
