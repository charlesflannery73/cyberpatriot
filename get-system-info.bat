@echo off
echo Checking if script contains Administrative rights...
net sessions
if %errorlevel%==0 (
echo Success!
) else (
echo No admin, please run with Administrative rights...
pause
exit
)

cd c:\Users\%username%\Desktop

rem Set initial preferences folder view
reg add HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Modules\GlobalSettings\DetailsContainer /v "DetailsContainer" /t REG_BINARY /d 0200000001000000 /f
reg add HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Modules\GlobalSettings\Sizer /v "DetailsContainer" /t REG_BINARY /d 1501000001000000000000006d020000 /f
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v Hidden /t REG_DWORD /d 1 /f
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v ShowSuperHidden /t REG_DWORD /d 1 /f
taskkill /im explorer.exe /f
explorer

rem make directories
mkdir c:\Users\%username%\Desktop\SystemSettings\
cd SystemSettings

rem Create reports

REM Windows Features
echo ###### Windows Features##############^<BR^> ^<BR^>  >> c:\Users\%username%\Desktop\SystemSettings\WindowsFeatures.txt
dism /online /get-features /Format:table |findstr Enabled >> c:\Users\%username%\Desktop\SystemSettings\WindowsFeatures.txt

echo ##################################################################### ^<BR^>^<BR^>  >> c:\Users\%username%\Desktop\SystemSettings\WindowsFeatures.txt
echo HINT: Get rid of unneeded Windows installed features not in readme >> c:\Users\%username%\Desktop\SystemSettings\WindowsFeatures.txt
echo (EXAMPLE: iis, FTP, telnet) >> c:\Users\%username%\Desktop\SystemSettings\WindowsFeatures.txt
echo . >> c:\Users\%username%\Desktop\SystemSettings\WindowsFeatures.txt
echo To disable a feature like telnet enter the command:^<BR^> >> c:\Users\%username%\Desktop\SystemSettings\WindowsFeatures.txt
echo Dism /online /Disable-Feature /FeatureName:Telnet  ^<BR^> >> c:\Users\%username%\Desktop\SystemSettings\WindowsFeatures.txt
echo or left click  Turn Windows Features on or off^<BR^> >> c:\Users\%username%\Desktop\SystemSettings\WindowsFeatures.txt
echo ##################################################################### >> c:\Users\%username%\Desktop\SystemSettings\WindowsFeatures.txt

REM Share
wmic share get *  /format:htable > c:\Users\%username%\Desktop\SystemSettings\Shared-Folders.html
echo ##################################################^<BR^>^<BR^>  >> c:\Users\%username%\Desktop\SystemSettings\Shared-HINT.html
echo HINT:  Default Shares to keep are C$, ADMIN$, $IPC^<BR^>  >> c:\Users\%username%\Desktop\SystemSettings\Shared-HINT.html
echo To Delete a share named "C":   net share C /delete^<BR^>^<BR^>  >> c:\Users\%username%\Desktop\SystemSettings\Shared-HINT.html
echo ##################################################  >> c:\Users\%username%\Desktop\SystemSettings\Shared-HINT.html

REM Get a File HASH
echo ##################################################^<BR^>^<BR^>  >>  c:\Users\%username%\Desktop\SystemSettings\Hash-HINT.html
echo How to compute a hash using Powershell^<BR^>^<BR^> >> c:\Users\%username%\Desktop\SystemSettings\Hash-HINT.html
echo        Get-FileHash -Algorithm file name and path^<BR^> >> c:\Users\%username%\Desktop\SystemSettings\Hash-HINT.html
echo Algorithm Types SHA1, SHA256, SHA384, SHA512, MACTripleDES, MD5, RIPEMD160^<BR^>^<BR^> >> c:\Users\%username%\Desktop\SystemSettings\Hash-HINT.html
echo HINT:  use a command like this:^<BR^> >> c:\Users\%username%\Desktop\SystemSettings\Hash-HINT.html
echo        Get-FileHash -Algorithm md5 C:\Users\hwells\Documents\Flash_Research.txt^<BR^>^<BR^>  >> c:\Users\%username%\Desktop\SystemSettings\Hash-HINT.html
echo ################################################## >>  c:\Users\%username%\Desktop\SystemSettings\Hash-HINT.html

REM Get Externded user information
wmic useraccount get name,disabled,PasswordExpires,PasswordChangeable /format:htable  >> c:\Users\%username%\Desktop\SystemSettings\Users.html
echo ##################################################^<BR^>^<BR^> >> c:\Users\%username%\Desktop\SystemSettings\Users-HINT.html
echo ^<html^>^<body^>HINT:  Compare this list to the Readme^<BR^>^<BR^> >> c:\Users\%username%\Desktop\SystemSettings\Users-HINT.html
echo       Make sure the Aministrator is disabled:    NET user Administrator /active:no ^<BR^>  >> c:\Users\%username%\Desktop\SystemSettings\Users-HINT.html
echo       Delete  a user example:    NET user AWalker /delete ^<BR^> >> c:\Users\%username%\Desktop\SystemSettings\Users-HINT.html
echo       Create a user with temporary password example:  net user rdibney T3mp0raryP@ssw0rd /logonpasswordchg:yes ^<BR^> >> c:\Users\%username%\Desktop\SystemSettings\Users-HINT.html
echo       Create a user with a password example:  net user rdibney T3mp0raryPassw0rd^<BR^>^<BR^> >> c:\Users\%username%\Desktop\SystemSettings\Users-HINT.html
echo       Make sure Administrator account is disabled use this command: ^<BR^> >> c:\Users\%username%\Desktop\SystemSettings\Users-HINT.html
echo       NET user Administrator /active:no^<BR^>^<BR^>  >> c:\Users\%username%\Desktop\SystemSettings\Users-HINT.html
echo ################################################## >> c:\Users\%username%\Desktop\SystemSettings\Users-HINT.html

REM Get Administrator
wmic path win32_groupuser where (groupcomponent="win32_group.name=\"administrators\",domain=\"%ComputerName%\"") get partcomponent  /format:htable  >> c:\Users\%username%\Desktop\SystemSettings\Administrators.html
echo ##################################################^<BR^>^<BR^>  >> c:\Users\%username%\Desktop\SystemSettings\Administrators-HINT.html
echo HINT: Compare Members of the administrators group to authorized Administrators in Readme^<BR^> >> c:\Users\%username%\Desktop\SystemSettings\Administrators-HINT.html
echo HINT: to Delete OR ADD an Administrator:^<BR^> >> c:\Users\%username%\Desktop\SystemSettings\Administrators-HINT.html
echo       NET localgroup Administrators USERNAME /delete^<BR^> >> c:\Users\%username%\Desktop\SystemSettings\Administrators-HINT.html
echo       NET localgroup Administrators USERNAME /add^<BR^>^<BR^> >> c:\Users\%username%\Desktop\SystemSettings\Administrators-HINT.html
echo ##################################################^<BR^>  >> c:\Users\%username%\Desktop\SystemSettings\Administrators-HINT.html

REM Get Groups
wmic group get name,status /format:htable  >> c:\Users\%username%\Desktop\SystemSettings\Groups.html
echo ##################################################^<BR^>^<BR^>  >> c:\Users\%username%\Desktop\SystemSettings\Group-HINT.html
echo HINT: Compare Members of the administrators group to authorized Administrators in Readme^<BR^> >> c:\Users\%username%\Desktop\SystemSettings\Group-HINT.html
echo HINT: to Delete OR ADD from a group:^<BR^> >> c:\Users\%username%\Desktop\SystemSettings\Group-HINT.html
echo       NET localgroup GROUPNAME USERNAME /delete^<BR^> >> c:\Users\%username%\Desktop\SystemSettings\Group-HINT.html
echo       NET localgroup GROUPNAME USERNAME /add^<BR^>^<BR^> >> c:\Users\%username%\Desktop\SystemSettings\Group-HINT.html
echo ##################################################^<BR^>  >> c:\Users\%username%\Desktop\SystemSettings\Group-HINT.html

REM Get Password Policy
echo ##################################################^<BR^>^<BR^>  >> c:\Users\%username%\Desktop\SystemSettings\Password-Policy.html
echo HINT:  Do this from an Administrator cmd prompt^<BR^>^<BR^> >> c:\Users\%username%\Desktop\SystemSettings\Password-Policy.html
echo        NET ACCOUNTS /FORCELOGOFF:30^<BR^> >> c:\Users\%username%\Desktop\SystemSettings\Password-Policy.html
echo        NET ACCOUNTS /MINPWLEN:15^<BR^> >> c:\Users\%username%\Desktop\SystemSettings\Password-Policy.html
echo        NET ACCOUNTS /MAXPWAGE:30^<BR^> >> c:\Users\%username%\Desktop\SystemSettings\Password-Policy.html
echo        NET ACCOUNTS /UNIQUEPW:10^<BR^>^<BR^> >> c:\Users\%username%\Desktop\SystemSettings\Password-Policy.html
echo        NET ACCOUNTS   (to verify changes)^<BR^>^<BR^> >> c:\Users\%username%\Desktop\SystemSettings\Password-Policy.html
echo ##################################################  >> c:\Users\%username%\Desktop\SystemSettings\Password-Policy.html

REM Get Groups and members
for /f %%i in ('wmic group get name') do net localgroup %%i >> c:\Users\%username%\Desktop\SystemSettings\Groups.txt
echo HINT:  Look through each Group especially the Administrator and Remote Desktop >> c:\Users\%username%\Desktop\SystemSettings\Groups.txt
echo        ADD       NET localgroup GROUP USERNAME /add >> c:\Users\%username%\Desktop\SystemSettings\Groups.txt
echo        DELETE    NET localgroup GROUP USERNAME /delete >> c:\Users\%username%\Desktop\SystemSettings\Groups.txt


REM Get Installed Applications
wmic  product get name, version, vendor /format:htable  >> c:\Users\%username%\Desktop\SystemSettings\Installed-Applications.html
echo ##################################################^<BR^>  >> c:\Users\%username%\Desktop\SystemSettings\Installed-Applications-HINT.html
echo HINT: Unistall Applications not needed ^<BR^> >> c:\Users\%username%\Desktop\SystemSettings\Installed-Applications-HINT.html
echo wmic product where name="product name" call uninstall^<BR^>^<BR^>  >> c:\Users\%username%\Desktop\SystemSettings\Installed-Applications-HINT.html
echo add or remove programs from control panel^<BR^> >> c:\Users\%username%\Desktop\SystemSettings\Installed-Applications-HINT.html
echo ##################################################^<BR^>^<BR^>  >> c:\Users\%username%\Desktop\SystemSettings\Installed-Applications-HINT.html

REM Get Security Policy
secedit.exe /export /areas SECURITYPOLICY /cfg SecurityPolicy.txt
REM Get audit Policy
auditpol /get /category:* >> c:\Users\%username%\Desktop\SystemSettings\Audit-Policy.txt
echo ##################################################  >> c:\Users\%username%\Desktop\SystemSettings\Audit-Policy.txt
echo HINT:  Audit Success and Falure for all categories  >> c:\Users\%username%\Desktop\SystemSettings\Audit-Policy.txt
echo        Use the following two Commands:  >> c:\Users\%username%\Desktop\SystemSettings\Audit-Policy.txt
echo        auditpol /set /category:* /success:enable  >> c:\Users\%username%\Desktop\SystemSettings\Audit-Policy.txt
echo        auditpol /set /category:* /failure:enable  >> c:\Users\%username%\Desktop\SystemSettings\Audit-Policy.txt         
echo ################################################## >> c:\Users\%username%\Desktop\SystemSettings\Audit-Policy  >> c:\Users\%username%\Desktop\SystemSettings\Audit-Policy.txt

cd \users
REM Get media files in Users area
FOR %%A IN (png jpeg gif avi wav jpg mp3 mpeg mp4 ) DO dir /s /b *.%%A  >> c:\Users\%username%\Desktop\SystemSettings\MediaFiles.txt

REM Get executable files in Users area
FOR %%A IN (exe dll spk bat bin cmd com ps1 job scr msi reg vbs wsh ) DO dir /s /b *.%%A  >> c:\Users\%username%\Desktop\SystemSettings\Executable-Files.txt


cd c:\Users\%username%\Desktop\




