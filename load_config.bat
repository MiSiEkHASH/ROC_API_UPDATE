@echo off
echo example: load variable from config.dat
echo.

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

::UpdateTime=
::CreateBackup=
::AllowToUpadte=
::CurrentApiVersionPath=
::LastApiVersionUrl=
::ApiDir=
::UpdateDownloadDir=
::UpdatePackageUrl=
::UpdatePackageFilename=
::ApiServiceName=
::NotifierServiceName=

echo. 1.  Update time:		%upgradeTime%
echo. 2.  Create backup:		%createBackup%
echo. 3.  Allow to update:		%allowToUpadte%
echo. 4.  Cur.Api.Ver.Patch:		%currentApiVersionPath%
echo. 5.  Last.Api.Ver.URL:		%lastApiVersionUrl%
echo. 6.  API director:		%apiDir%
echo. 7.  Update download dir:	%updateDownloadDir%
echo. 8.  Update package URL:	%updatePackageUrl%
echo. 9.  Update package filename:	%updatePackageFilename%
echo. 10. API service name:		%apiServiceName%
echo. 11. Notyfier service name:	%notifierServiceName%
echo.
pause