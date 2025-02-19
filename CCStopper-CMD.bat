@echo off
title CCStopper by ESoda

:updateCHK
:: Update Checker
set local=1.1.0

:internetCHK
:: Check if comptuer can connect to google.com, if not, skip directly to menu

echo Checking internet connection...
echo.
Ping www.google.com -n 1 -w 1000
cls
if errorlevel 1 (
	set remote=N/A
	echo.
	echo                                      ---ESODA'S CREATIVE CLOUD STOPPER---
	echo.

	echo The internet cannot be reached right now, cannot check for updates.
	pause
	goto menu
)
:: Source: https://github.com/nicamoq/batupdate
:: Local is installed ver. remote is latest ver.
set remote=%local%
set link=https://raw.githubusercontent.com/E-Soda/CCStopper/main/version.bat
:: Deletes version.bat if it exists
:check
IF EXIST "version.bat" DEL /Q "version.bat"
goto download
pause

:: Main download process
:download
download %link% version.bat
call "version.bat"
goto check-2


:: Check-2 checks if the current version matches the remote.
:check-2
IF "%local%"=="%remote%" (goto menu) else (goto update)
:: IF NOT "%local%"=="%remote%" goto update

:update
cls
echo.
echo                                      ---ESODA'S CREATIVE CLOUD STOPPER---
echo.
echo Update found!  Current version: %local%. Latest version: %remote%.
echo.
echo It is recommended that you update the script. Would you like to go to the Github (1) or skip this update (2)?

set /p updatechoice= Select an option: (1/2):
If /I "%updatechoice%"=="1" start https://github.com/E-Soda/CCStopper/releases

goto menu
pause

:: Main script
:menu
cls
echo.
echo                                      ---ESODA'S CREATIVE CLOUD STOPPER---
echo.
echo. Get rid of Adobe's pesky background apps and more!
echo. Made by ESoda (E-Soda on Github)
echo.
echo. Current version: %local%. Latest version: %remote%.
echo.
echo.
echo. MAKE SURE TO SAVE YOUR FILES! This will kill all Adobe apps (INCLUDING Photoshop, After Effects, etc.)
echo.
echo. MENU:
echo. 1: Kill all running Adobe Processess 
echo. 2: Delete Adobe Genuine Software Integrity Service (AdobeGCClient)
echo. 3: Patch Acrobat
echo. 4: Check for updates
echo. 5: Github Repo
echo. 0: Quit
echo.
set /p menu=Select an option: (1/2/3/4/0): 

If /I "%menu%"=="1"  (
	cls
	Powershell.exe -executionpolicy remotesigned -File  .\scripts\ProcessKill.ps1
	goto menu
)
If /I "%menu%"=="2" (
	cls
	.\scripts\AGSKill.bat
	goto menu
)
If /I "%menu%"=="3" (
	cls
	.\scripts\acrobatfix.bat
	goto menu
)
If /I "%menu%"=="4" goto updateCHK
If /I "%menu%"=="5" (
	cls
	start https://github.com/E-Soda/CCStopper
	goto menu
)

If /I "%menu%"=="0" exit

goto other

:other
cls
echo.
echo                                      ---ESODA'S CREATIVE CLOUD STOPPER---
echo.

echo That's not a valid option!
pause
goto menu
