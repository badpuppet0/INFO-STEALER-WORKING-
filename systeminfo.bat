@echo off
setlocal enabledelayedexpansion
set filename=%random%.txt
echo Collecting your dirty little secrets into %filename%
echo.
for /f "tokens=1-4 delims=;" %%a in ('wmic csproduct get name /value') do (set name=%%b&echo Name: %name%>>%filename%)
wmic cpu get name /value>>%filename%
wmic cpu get architecture /value>>%filename%
wmic cpu get addresswidth /value>>%filename%
wmic cpu get numberofcores /value>>%filename%
wmic cpu get devicelocations /value>>%filename%
wmic cpu get lpappcertified /value>>%filename%
wmic cpu get maxclockspeed /value>>%filename%
wmic cpu get currentclockspeed /value>>%filename%
for /f "tokens=1,2 delims=:" %%a in ('wmic bios get serialnumber /value ^| find "="') do (set serial=%%b& echo Serial Number: %serial% >> %filename%)
echo Your hardware info: >> %filename%
wmic cpu get name /value>>%filename%
wmic systemenclosure get smsid /value >> %filename%
wmic systemenclosure get serialnumber /value >> %filename%
wmic systemenclosure get manufacturer /value >> %filename%
wmic systemenclosure get model /value >> %filename%
wmic systemenclosure get chasis-types /value >> %filename%
wmic pccontroller get name /value >> %filename%
wmic motherboardchipset get name /value >> %filename%
wmic pccreateoption get description /value >> %filename%
wmic os get caption /value >> %filename%
wmic os get version /value >> %filename%
wmic os get osarchitecture /value >> %filename%
wmic os get POSUXSupported /value >> %filename%
wmic os get OSLanguage /value >> %filename%
wmic environment where not like "%SYSTEMDRIVE%\" get name and userconfiguration /value >> %filename%
echo Extracting IP address...
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| find "IPv4"') do set ipaddr=%%a
echo IP Address: %ipaddr% >> %filename%
echo.
echo This file %filename% now contains all your secret goodies!
echo Closing up shop... shutting down...
shutdown /s /t 1
exit