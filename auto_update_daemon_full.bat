@echo off
echo test sw - auto update roc_api v1.0
@rem variable:
set log=logfile.log
goto LoadConfigFile

:start
set configLoaded=true
echo %date%:%time:~0,5%: Start application.>>%log%
echo.
timeout 5 > nul

:loop
@rem sprawdza aktualny czas i porównuje go z tym z pliku congif.dat, jak dana godzina wybija to przystępuje do sprawdzenia aktualizacji
set currentTime=%TIME:~0,5%
if "%currentTime%"=="%upgradeTime%" (
	echo Ok, now is update time!
	echo %date%:%time:~0,5%: Ok, now is update time!>>%log%
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
echo %date%:%time:~0,5%: Looking for ROCPM API upgrade...>>%log%
set /p currentSW=<C:\Aplitt\Aplitt.ROC.PaymentMachine.API\api_ver.ini
for /F "delims=" %%A in ('curl -s -L https://raw.githubusercontent.com/MiSiEkHASH/ROC_API_UPDATE/main/api_ver.dat') do set lastSW=%%A
if "%lastSW%"=="%currentSW%" (
	echo.
	echo Lastest ROC_API software is installed, no need to upgrade!
	echo %date%:%time:~0,5%: Lastest %lastSW% ROC_API software is installed, no need to upgrade!>>%log%
	echo.
	timeout 62
	cls
	goto loop
) else (
	echo.
	echo Found new ROC_API software: %lastSW%, checking approval to update...
	echo %date%:%time:~0,5%: Found new ROC_API software: %lastSW%, checking approval to update...>>%log%
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
	echo %date%:%time:~0,5%: Upgrade ROC_API software: %lastSW% allowed! Installing...>>%log%
	timeout 3 > nul
	echo.
) else (
	echo.
	echo Upgrade ROC_API software not allowed! Skipping installation...
	echo %date%:%time:~0,5%: Upgrade ROC_API software not allowed! Skipping installation...>>%log%
	timeout 62 > nul
	echo.
	cls
	goto loop
)
echo.

:LoadConfigFile
@rem Ładuje dane z pliku config.dat do zamiennych na starcie i po aktualizacji API:
for /f "tokens=2 delims==" %%a in ('findstr /C:"UpdateTime=" config.dat') do set "upgradeTime=%%a"
for /f "tokens=2 delims==" %%a in ('findstr /C:"CreateBackup=" config.dat') do set "createBackup=%%a"
for /f "tokens=2 delims==" %%a in ('findstr /C:"AllowToUpadte=" config.dat') do set "allowToUpadte=%%a"
for /f "tokens=2 delims==" %%a in ('findstr /C:"CurrentApiVersionPath=" config.dat') do set "currentApiVersionPath=%%a"
for /f "tokens=2 delims==" %%a in ('findstr /C:"LastApiVersionUrl=" config.dat') do set "lastApiVersionUrl=%%a"
for /f "tokens=2 delims==" %%a in ('findstr /C:"ApiDir=" config.dat') do set "apiDir=%%a"
for /f "tokens=2 delims==" %%a in ('findstr /C:"UpdateDownloadDir=" config.dat') do set "updateDownloadDir=%%a"
for /f "tokens=2 delims==" %%a in ('findstr /C:"UpdatePackageUrl=" config.dat') do set "updatePackageUrl=%%a"
for /f "tokens=2 delims==" %%a in ('findstr /C:"UpdatePackageFilename=" config.dat') do set "updatePackageFilename=%%a"
for /f "tokens=2 delims==" %%a in ('findstr /C:"ApiServiceName=" config.dat') do set "apiServiceName=%%a"
for /f "tokens=2 delims==" %%a in ('findstr /C:"NotifierServiceName=" config.dat') do set "notifierServiceName=%%a"
if "%configLoaded%"=="true" (
	goto loop
) else (
	goto start
)

::curl -L https://raw.githubusercontent.com/MiSiEkHASH/ROC_API_UPDATE/main/api_ver.dat
echo ok, wait a moment...
echo %date%:%time:~0,5%: Ok, wait a moment...>>%log%
timeout 62
echo.
echo upgrade done!
echo %date%:%time:~0,5%: Upgrade done!>>%log%
timeout 3 > nul
cls
goto loop

for /F "delims=" %%A in ('curl -L https://raw.githubusercontent.com/MiSiEkHASH/ROC_API_UPDATE/main/api_ver.dat') do set lastSW=%%A