CLIENT PC - PRINTER CONNECTION FIXES
=====================================

This folder contains scripts for PCs that want to CONNECT to a printer
(not the PC that has the printer installed).

WHICH PC IS THIS?
=================
- This PC does NOT have a printer physically connected
- This PC wants to print to a printer on another PC
- This PC is getting error 0x00011b when trying to connect

SCRIPTS IN THIS FOLDER:
======================

1. fix_client_printer_connection.bat
   - Main fix for client connection issues
   - Fixes registry and network settings
   - RUN THIS FIRST

2. connect_to_network_printer.bat
   - Helps you connect to a specific network printer
   - You'll need the IP address of the server PC
   - Use after running the main fix

HOW TO USE:
===========

STEP 1: Run the main fix
- Right-click "fix_client_printer_connection.bat"
- Select "Run as administrator"
- Follow the prompts

STEP 2: Connect to printer
- Right-click "connect_to_network_printer.bat"
- Select "Run as administrator"
- Enter the IP address of the PC with the printer
- Enter the printer name

IMPORTANT:
==========
- Make sure the SERVER PC (the one with the printer) has run
  the SERVER_PC scripts first
- You need Administrator privileges
- Both PCs must be on the same network
