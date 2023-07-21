@echo off
mkdir C:\Aplitt\update
echo.
echo *** LOOKING FOR UPDATE... ***
echo.
curl -s -L https://raw.githubusercontent.com/MiSiEkHASH/ROC_API_UPDATE/main/update.dat -o C:\Aplitt\update\update.dat
curl -s -L https://raw.githubusercontent.com/MiSiEkHASH/ROC_API_UPDATE/main/api_ver.dat -o C:\Aplitt\update\api_ver.dat
cls
set /p update=<C:\Aplitt\update\update.dat
set /p apiver=<C:\Aplitt\update\api_ver.dat
echo ---------------------------------------------------------------------
echo    ROC API UPDATE: %apiver% [UPGRADE:%update%]
echo ---------------------------------------------------------------------
echo.
pause
echo.
echo *** DOWNLOADING UPDATE PACKAGE... ***
echo.
curl -L https://github.com/MiSiEkHASH/ROC_API_UPDATE/raw/main/update.zip?raw=true -o C:\Aplitt\update\update.zip
timeout 2 > nul
echo.
echo *** CREATING BACKUP... ***
echo.
Xcopy /E /I C:\Aplitt\Aplitt.ROC.PaymentMachine.API C:\Aplitt\Aplitt.ROC.PaymentMachine.API_backup%date%>nul
timeout 2 > nul
if exist C:\Aplitt\Aplitt.ROC.PaymentMachine.API_backup%date% (
	echo job done, created backup dir Aplitt.ROC.PaymentMachine.API_backup%date%!
	echo.
) else (
	echo error! backup not exist! cannot continue...
	echo.
	pause
	exit
)
echo *** STOP SERVICES... ***
echo.
C:\Aplitt\Aplitt.ROC.PaymentMachine.API\nssm.exe stop Aplitt.ROC.PaymentMachine.API
C:\Aplitt\Aplitt.ROC.PaymentMachine.API\nssm.exe stop Aplitt.ROC.PaymentMachine.StateNotifier
timeout 2 > nul
echo.
echo *** INSTALL UPDATE... ***
echo.
powershell -command "Expand-Archive -Force 'C:\Aplitt\update\update.zip' 'C:\Aplitt\Aplitt.ROC.PaymentMachine.API'"
set /p ApiVerCheck=<C:\Aplitt\Aplitt.ROC.PaymentMachine.API\api_ver.ini
if "%ApiVerCheck%"=="%apiver%" (
	echo.
	echo update %ApiVerCheck%, done!
	echo %date%:%time%:Update OK, now API is: %ApiVerCheck% >> C:\Aplitt\update\api_update.log
	echo.
) else (
	echo.
	echo update fail! send email notification!
	echo %date%:%time%:Update API to %ApiVerCheck% FAIL! >> C:\Aplitt\update\api_update.log
	echo.
)
echo.
echo *** RESTART SERVICES... ***
echo.
C:\Aplitt\Aplitt.ROC.PaymentMachine.API\nssm.exe start Aplitt.ROC.PaymentMachine.API
C:\Aplitt\Aplitt.ROC.PaymentMachine.API\nssm.exe start Aplitt.ROC.PaymentMachine.StateNotifier
echo.
echo.
echo *** ALL DONE, UPDATE COMPLETE! ***
echo.
pause
exit


