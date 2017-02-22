@echo off
title PORTABLE MINECRAFT LAUNCHER
set nag=BE SURE TO TURN CAPS LOCK OFF! (never said it was on just make sure)
set new_version=OFFLINE
if exist replacer.bat del replacer.bat
del version.txt
del version.txt.1
:FOLDERCHECK
if not exist %CD%\bin mkdir %CD%\bin
if not exist %CD%\doc mkdir %CD%\doc
if not exist %CD%\extra mkdir %CD%\extra
if not exist %CD%\data\profiles mkdir %CD%\data\profiles
:VERSION
echo 18 > %CD%\doc\version.txt
set /p current_version=<%CD%\doc\version.txt
:CREDITS
if exist %CD%\doc\license.txt goto FILECHECK
echo ================================================== > %CD%\doc\license.txt
echo =              Script by MarioMasta64            = >> %CD%\doc\license.txt
echo =            Script Version: v%current_version%- beta          = >> %CD%\doc\license.txt
echo ================================================== >> %CD%\doc\license.txt
echo =You may Modify this WITH consent of the original= >> %CD%\doc\license.txt
echo = creator, as long as you include a copy of this = >> %CD%\doc\license.txt
echo =      as you include a copy of the License      = >> %CD%\doc\license.txt
echo ================================================== >> %CD%\doc\license.txt
echo =    You may also modify this script without     = >> %CD%\doc\license.txt
echo =         consent for PERSONAL USE ONLY          = >> %CD%\doc\license.txt
echo ================================================== >> %CD%\doc\license.txt
start notepad.exe %CD%\doc\license.txt
:FILECHECK
if not exist %CD%\bin\minecraft.jar goto :DOWNLOADMINECRAFT
if not exist %CD%\data\.minecraft\launcher.pack.lzma set nag=COPY %APPDATA%\.minecraft TO %CD%\data IF YOU HAVE EXISTRING SAVEDATA AND THEN LAUNCH DEFAULT PROFILE
:WGETUPDATE
wget https://eternallybored.org/misc/wget/current/wget.exe
move wget.exe %CD%\bin\
goto MENU
:DOWNLOADMINECRAFT
cls
if not exist %CD%\bin\wget.exe call :DOWNLOADWGET
%CD%\bin\wget.exe http://s3.amazonaws.com/Minecraft.Download/launcher/Minecraft.jar
move %CD%\Minecraft.jar %CD%\bin
goto FILECHECK
:DOWNLOADWGET
call :CHECKWGETDOWNLOADER
exit /b
:CHECKWGETDOWNLOADER
if not exist %CD%\bin\downloadwget.vbs call :CREATEWGETDOWNLOADER
if exist %CD%\bin\downloadwget.vbs call :EXECUTEWGETDOWNLOADER
exit /b
:CREATEWGETDOWNLOADER
echo ' Set your settings > %CD%\bin\downloadwget.vbs
echo    strFileURL = "https://eternallybored.org/misc/wget/current/wget.exe" >> %CD%\bin\downloadwget.vbs
echo    strHDLocation = "wget.exe" >> %CD%\bin\downloadwget.vbs
echo. >> %CD%\bin\downloadwget.vbs
echo ' Fetch the file >> %CD%\bin\downloadwget.vbs
echo     Set objXMLHTTP = CreateObject("MSXML2.XMLHTTP") >> %CD%\bin\downloadwget.vbs
echo. >> %CD%\bin\downloadwget.vbs
echo     objXMLHTTP.open "GET", strFileURL, false >> %CD%\bin\downloadwget.vbs
echo     objXMLHTTP.send() >> %CD%\bin\downloadwget.vbs
echo. >> %CD%\bin\downloadwget.vbs
echo If objXMLHTTP.Status = 200 Then >> %CD%\bin\downloadwget.vbs
echo Set objADOStream = CreateObject("ADODB.Stream") >> %CD%\bin\downloadwget.vbs
echo objADOStream.Open >> %CD%\bin\downloadwget.vbs
echo objADOStream.Type = 1 'adTypeBinary >> %CD%\bin\downloadwget.vbs
echo. >> %CD%\bin\downloadwget.vbs
echo objADOStream.Write objXMLHTTP.ResponseBody >> %CD%\bin\downloadwget.vbs
echo objADOStream.Position = 0    'Set the stream position to the start >> %CD%\bin\downloadwget.vbs
echo. >> %CD%\bin\downloadwget.vbs
echo Set objFSO = Createobject("Scripting.FileSystemObject") >> %CD%\bin\downloadwget.vbs
echo If objFSO.Fileexists(strHDLocation) Then objFSO.DeleteFile strHDLocation >> %CD%\bin\downloadwget.vbs
echo Set objFSO = Nothing >> %CD%\bin\downloadwget.vbs
echo. >> %CD%\bin\downloadwget.vbs
echo objADOStream.SaveToFile strHDLocation >> %CD%\bin\downloadwget.vbs
echo objADOStream.Close >> %CD%\bin\downloadwget.vbs
echo Set objADOStream = Nothing >> %CD%\bin\downloadwget.vbs
echo End if >> %CD%\bin\downloadwget.vbs
echo. >> %CD%\bin\downloadwget.vbs
echo Set objXMLHTTP = Nothing >> %CD%\bin\downloadwget.vbs
exit /b
:EXECUTEWGETDOWNLOADER
cscript.exe %CD%\bin\downloadwget.vbs
move wget.exe %CD%\bin\
exit /b
:MENU
cls
title PORTABLE MINECRAFT LAUNCHER - MAIN MENU
echo %NAG%
set nag=SELECTION TIME!
echo 1. new profile
echo 2. default profile
echo 3. launch profile
echo 4. delete profile
echo 5. update
echo 6. about
echo 7. exit
set /p choice="enter a number and press enter to confirm: "
if %choice%==1 goto NEW
if %choice%==2 goto DEFAULT
if %choice%==3 goto SELECT
if %choice%==4 goto DELETE
if %choice%==5 goto UPDATECHECK
if %choice%==6 goto ABOUT
if %choice%==7 exit
set nag="PLEASE SELECT A CHOICE 1-6"
goto MENU
:NEW
cls
title PORTABLE MINECRAFT LAUNCHER - NEW PROFILE
echo %NAG%
set nag=SELECTION TIME!
echo type the name of the profile
echo only use letters and numbers
echo type menu to return to the main menu
set /p profile="enter a name for the new profile: "
if %profile%==menu goto MENU
if exist %CD%\data\%profile% then goto EXIST
goto CREATE
:CREATE
cls
title PORTABLE MINECRAFT LAUNCHER - CREATE PROFILE
echo %NAG%
set nag=SELECTION TIME!
echo create profile "%PROFILE%"?
echo type yes or no and press enter
set /p choice="choice: "
if %choice%==no goto NEWTITLE
if %choice%==yes goto NOWCREATING
set nag="please enter YES or NO"
goto CREATE
:NOWCREATING
if exist %CD%\data\profiles\%PROFILE% goto EXISTS
mkdir %CD%\data\profiles\%PROFILE%
if exist %CD%\data\profiles\%PROFILE% goto LAUNCH
set LEGITCHECK="INVALID NAME"
goto NEW
:EXISTS
cls
title PORTABLE MINECRAFT LAUNCHER - LAUNCH PROFILE
echo %NAG%
set nag=SELECTION TIME!
echo PROFILE "%PROFILE%" EXISTS
echo launch it?
echo type yes or no and press enter
set /p choice="choice: "
if %choice%==no goto NEWTITLE
if %choice%==yes goto LAUNCH
set nag="please enter YES or NO"
goto EXISTS
:NEWTITLE
set nag="ENTER A DIFFERENT TITLE THEN"
goto NEW
:SELECT
cls
title PORTABLE MINECRAFT LAUNCHER - SELECT PROFILE
echo %NAG%
set nag=SELECTION TIME!
echo type the name of the profile
echo only use letters and numbers
echo type menu to return to the main menu
set /p profile="enter a name for the profile to launch: "
if %profile%==menu goto MENU
if %PROFILE%==default goto DEFAULT
if exist %CD%\data\profiles\%PROFILE% goto LAUNCH
set nag=PROFILE "%profile%" DOES NOT EXISTS
goto CREATE
:LAUNCH
set APPDATA=%CD%\data\profiles\%PROFILE%
goto OSCHECK
:DEFAULT
set APPDATA=%CD%\data
goto OSCHECK
:DELETE
cls
title PORTABLE MINECRAFT LAUNCHER - DELETE PROFILE
echo %NAG%
set nag=SELECTION TIME!
echo type the name of the profile to delete
echo default for default profile
echo type menu to return to the main menu
set /p profile="enter a name for the profile you wish to delete: "
if exist %CD%\data\profiles\%PROFILE% goto NOWDELETING
if %profile%==menu goto MENU
if %profile%==default goto DELETEMAIN
set nag=PROFILE %profile% DOES NOT EXIST
goto DELETE
:NOWDELETING
rmdir /s %CD%\data\profiles\%PROFILE%
goto MENU
:DELETEMAIN
ECHO TO PROTECT MY SAVES I MADE THIS THE HARDEST OPTION TO DO. PLEASE LEAVE THE COMPUTER. > %CD%\doc\README.TXT
START NOTEPAD.EXE %CD%\doc\README.TXT
goto MENU
:OSCHECK
cls
title PORTABLE MINECRAFT LAUNCHER - JAVA
echo type y for system or anything else for portable java
echo press enter afterwards
set /p choice="choice: "
if %choice%==y goto JAVALAUNCH
goto JAVACHECK
:JAVALAUNCH
start %CD%\bin\Minecraft.jar
exit
:JAVACHECK
if not exist %CD%\bin\commonfiles\java\bin\javaw.exe goto JAVAINSTALLERCHECK
start "" "%CD%\bin\commonfiles\java\bin\javaw.exe" -jar "%CD%\bin\Minecraft.jar
exit
:JAVAINSTALLERCHECK
if not exist %CD%\extra\jPortable_8_Update_121.paf.exe goto DOWNLOADJAVA
start %CD%\extra\jPortable_8_Update_121.paf.exe
title READMEREADMEREADMEREADMEREADMEREADMEREADMEREADMEREADMEREADMEREADMEREADMEREADMEREADMEREADME
cls
echo INSTALL JAVA TO %CD%\bin\commonfiles\Java AND PRESS ENTER TO CONTINUE
pause
goto JAVACHECK
:DOWNLOADJAVA
if exist jPortable_8_Update_121.paf.exe goto MOVEJAVA
if not exist %CD%\bin\wget.exe call :DOWNLOADWGET
%CD%\bin\wget.exe http://downloads.sourceforge.net/portableapps/jPortable_8_Update_121.paf.exe
:MOVEJAVA
move jPortable_8_Update_121.paf.exe %CD%\extra\jPortable_8_Update_121.paf.exe
goto JAVAINSTALLERCHECK
:UPDATECHECK
if exist version.txt del version.txt
if not exist %CD%\bin\wget.exe call :DOWNLOADWGET
%CD%\bin\wget.exe https://github.com/MarioMasta64/MinecraftPortable/raw/master/version.txt
set /p new_version=<version.txt
if %new_version%==OFFLINE goto ERROROFFLINE
if %current_version% EQU %new_version% goto LAbeta
if %current_version% LSS %new_version% goto NEWUPDATE
if %current_version% GTR %new_version% goto NEWEST
goto ERROROFFLINE
:LAbeta
cls
title PORTABLE MINECRAFT LAUNCHER - LAbeta BUILD :D
echo you are using the labeta version!!
echo Current Version: v%current_version%
echo New Version: v%new_version%
echo ENTER TO CONTINUE
pause
goto MENU
:NEWUPDATE
cls
echo %NAG%
set nag=SELECTION TIME!
title PORTABLE MINECRAFT LAUNCHER - OLD BUILD D:
echo you are using an older version
echo enter yes or no
echo Current Version: v%current_version%
echo New Version: v%new_version%
set /p choice="Update?: "
if %choice%==yes goto UPDATE
if %choice%==no goto MENU
set nag="please enter YES or NO"
goto NEWUPDATE
:UPDATE
if not exist %CD%\bin\wget.exe call :DOWNLOADWGET
%CD%\bin\wget.exe https://raw.githubusercontent.com/MarioMasta64/MinecraftPortable/master/launcher.bat
if exist launcher.bat.1 goto REPLACERCREATE
goto ERROROFFLINE
:REPLACERCREATE
echo del launcher.bat >> replacer.bat
echo rename launcher.bat.1 launcher.bat >> replacer.bat
echo start launcher.bat >> replacer.bat
exit
:NEWEST
cls
title PORTABLE MINECRAFT LAUNCHER - beta BUILD :0
echo YOURE USING A beta BUILD MEANING YOURE EITHER
echo CLOSE TO ME OR YOURE SOME SORT OF PIRATE
echo Current Version: v%current_version%
echo New Version: v%new_version%
echo ENTER TO CONTINUE
pause
goto MENU
:ABOUT
del %CD%\doc\license.txt
start launcher.bat
exit
:ERROROFFLINE
cls
set nag="YOU SEEM TO BE OFFLINE PLEASE RECONNECT TO THE INTERNET TO USE THIS FEATURE"
goto MENU
:ERROR
cls
echo ERROR OCCURED
pause
exit
