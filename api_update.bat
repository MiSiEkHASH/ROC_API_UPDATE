@echo off
echo --------------------------------------------
echo ROC API UPDATE: 2022_08_10_API_ver_1.4.0.133
echo --------------------------------------------
echo.
pause
echo.
echo *** DOWNLOADING UPDATE PACKAGE... ***
echo.
curl -L https://github.com/MiSiEkHASH/ROC_API_UPDATE/raw/main/2022_08_10_API_ver_1.4.0.133.exe?raw=true -o C:\Aplitt\2022_08_10_API_ver_1.4.0.133.exe
timeout 2 > nul
echo.
echo *** CREATING BACKUP... ***
echo.
Xcopy /E /I C:\Aplitt\Aplitt.ROC.PaymentMachine.API C:\Aplitt\Aplitt.ROC.PaymentMachine.API_backup%date%
timeout 2 > nul
if exist C:\Aplitt\Aplitt.ROC.PaymentMachine.API_backup%date% (
	echo.
	echo job done!
	echo.
) else (
	echo.
	echo error! backup not exist! cannot continue...
	echo.
	pause
	exit
)
echo.
echo *** STOP SERVICES... ***
echo.
C:\Aplitt\Aplitt.ROC.PaymentMachine.API\nssm.exe stop Aplitt.ROC.PaymentMachine.API
C:\Aplitt\Aplitt.ROC.PaymentMachine.API\nssm.exe stop Aplitt.ROC.PaymentMachine.StateNotifier
timeout 2 > nul
echo.
echo *** INSTALL UPDATE... ***
echo.
start C:\Aplitt\2022_08_10_API_ver_1.4.0.133.exe
echo.
pause > nul
echo Press any key after package install will be done...
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


