@echo off
echo test sw - auto update roc_api
echo %date%:%time:~0,5%: Start application.>>logfile.log
echo.
timeout 5 > nul

:loop
set timer=%TIME:~0,5%
set /p checkUpgradeTime=<upgrade_time.dat
if "%timer%"=="%checkUpgradeTime%" (
	echo Ok, now is update time!
	echo %date%:%time:~0,5%: Ok, now is update time!>>logfile.log
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
echo Looking for ROCPM API upgrade...
echo %date%:%time:~0,5%: Looking for ROCPM API upgrade...>>logfile.log
set /p currentSW=<C:\Aplitt\Aplitt.ROC.PaymentMachine.API\api_ver.ini
for /F "delims=" %%A in ('curl -s -L https://raw.githubusercontent.com/MiSiEkHASH/ROC_API_UPDATE/main/api_ver.dat') do set lastSW=%%A
if "%lastSW%"=="%currentSW%" (
	echo.
	echo Lastest ROC_API software is installed, no need to upgrade!
	echo %date%:%time:~0,5%: Lastest %lastSW% ROC_API software is installed, no need to upgrade!>>logfile.log
	echo.
	timeout 62
	cls
	goto loop
) else (
	echo.
	echo Found new ROC_API software: %lastSW%, checking approval to update...
	echo %date%:%time:~0,5%: Found new ROC_API software: %lastSW%, checking approval to update...>>logfile.log
	timeout 3 > nul
	echo.
	cls
	goto CheckUpgradeAproval
)

:CheckUpgradeAproval
for /F "delims=" %%A in ('curl -s -L https://raw.githubusercontent.com/MiSiEkHASH/ROC_API_UPDATE/main/update.dat') do set aprovalUpgrade=%%A
if "%aprovalUpgrade%"=="allowed" (
	echo.
	echo Upgrade ROC_API software: %lastSW% allowed! Installing...
	echo %date%:%time:~0,5%: Upgrade ROC_API software: %lastSW% allowed! Installing...>>logfile.log
	timeout 3 > nul
	echo.
) else (
	echo.
	echo Upgrade ROC_API software not allowed! Skipping installation...
	echo %date%:%time:~0,5%: Upgrade ROC_API software not allowed! Skipping installation...>>logfile.log
	timeout 62 > nul
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