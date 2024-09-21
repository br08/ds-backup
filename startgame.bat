@echo off
set rootdir=%~dp0

:: Read the game path from config.ini
for /f "tokens=2 delims==" %%A in ('findstr /i "gamepath" "%rootdir%config.ini"') do set gamepath=%%A

:: Start the game
cd %gamepath%
start "" "%gamepath%\DarkSoulsRemastered.exe"
exit
