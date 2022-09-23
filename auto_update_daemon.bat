@echo off
echo test sw - auto update roc_api
echo.

:loop
set timer=%TIME:~0,5%
if "%timer%"=="14:08" (
	echo ok, now is update time!
	timeout 1 > nul
	goto upgrade
) else (
	echo not time to upgrade!
	timeout 1 > nul
)
cls
goto loop

:upgrade
cls
echo so, looking for ROCPM API upgrade...
set /p currentSW=<C:\Aplitt\Aplitt.ROC.PaymentMachine.API\api_ver.ini
for /F "delims=" %%A in ('curl -s -L https://raw.githubusercontent.com/MiSiEkHASH/ROC_API_UPDATE/main/api_ver.dat') do set lastSW=%%A
if "%lastSW%"=="%currentSW%" (
	echo.
	echo Lastest ROC_API software is installed, no need to upgrade!
	echo.
	timeout 62
	cls
	goto loop
) else (
	echo.
	echo Found new ROC_API software: %lastSW%, checking approval to update...
	timeout 2 > nul
	echo.
	cls
	goto CheckUpgradeAproval
)

:CheckUpgradeAproval
for /F "delims=" %%A in ('curl -s -L https://raw.githubusercontent.com/MiSiEkHASH/ROC_API_UPDATE/main/update.dat') do set aprovalUpgrade=%%A
if "%aprovalUpgrade%"=="allowed" (
	echo.
	echo Upgrade ROC_API software: %lastSW% allowed! Installing...
	timeout 2 > nul
	echo.
) else (
	echo.
	echo Upgrade ROC_API software not allowed! Skipping installation...
	timeout 20 > nul
	echo.
	cls
	goto loop
)
echo.

::curl -L https://raw.githubusercontent.com/MiSiEkHASH/ROC_API_UPDATE/main/api_ver.dat
echo ok, wait a moment...
timeout 62
echo.
echo upgrade done!
timeout 3 > nul
cls
goto loop

for /F "delims=" %%A in ('curl -L https://raw.githubusercontent.com/MiSiEkHASH/ROC_API_UPDATE/main/api_ver.dat') do set lastSW=%%A