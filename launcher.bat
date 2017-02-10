@echo off
title PORTABLE MINECRAFT LAUNCHER
set nag=BE SURE TO TURN CAPS LOCK OFF! (never said it was on just make sure)

:REPLACERREMOVER
if exist replacer.bat del replacer.bat

:FOLDERCHECK
if not exist %CD%\doc mkdir %CD%\doc
if not exist %CD%\bin mkdir %CD%\bin
if not exist %CD%\data\profiles mkdir %CD%\data\profiles

:VERSION
cls
echo 11 > %CD%\doc\version.txt
set /p current_version=<%CD%\doc\version.txt

:CREDITS
if exist %CD%\doc\license.txt goto FILECHECK
echo ================================================== > %CD%\doc\license.txt
echo =              Script by MarioMasta64            = >> %CD%\doc\license.txt
echo =            Script Version: v%current_version%-beta             = >> %CD%\doc\license.txt
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
if not exist %CD%\bin\minecraft.jar goto DOWNLOADMINECRAFT
if not exist %CD%\data\.minecraft\launcher.pack.lzma set nag=COPY %APPDATA%\.minecraft TO %CD%\data IF YOU HAVE EXISTING SAVEDATA AND THEN LAUNCH DEFAULT PROFILE

:WGETUPDATE
wget https://eternallybored.org/misc/wget/current/wget.exe
move wget.exe %CD%\bin\
if exist %CD%\bin\wget.exe.1 goto WGETREPLACE
goto MENU

:WGETREPLACE
del %CD%\bin\wget.exe
ren %CD%\bin\wget.exe.1 %CD%\bin\wget.exe
goto MENU

:DOWNLOADMINECRAFT
cls
if not exist %CD%\bin\wget.exe set return=DOWNLOADMINECRAFT
if not exist %CD%\bin\wget.exe goto DOWNLOADWGET
%CD%\bin\wget.exe http://s3.amazonaws.com/Minecraft.Download/launcher/Minecraft.jar
move %CD%\Minecraft.jar %CD%\bin
goto FILECHECK

:DOWNLOADWGET

:CHECKWGETDOWNLOADER
if exist %CD%\bin\downloadwget.vbs goto EXECUTEWGETDOWNLOADER

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

:EXECUTEWGETDOWNLOADER
cscript.exe %CD%\bin\downloadwget.vbs
move wget.exe %CD%\bin\
goto %RETURN%

:MENU
title PORTABLE MINECRAFT LAUNCHER - MAIN MENU
cls
echo %NAG%
set nag=SELECTION TIME!
echo 1. new profile
echo 2. default profile
echo 3. launch profile
echo 4. delete profile
echo 5. update
echo 6. exit
set /p choice="enter a number and press enter to confirm: "
if %choice%==1 goto NEW
if %choice%==2 goto DEFAULT
if %choice%==3 goto SELECT
if %choice%==4 goto DELETE
if %choice%==5 goto UPDATECHECK
if %choice%==6 goto END
goto ERROR

:NEW
title PORTABLE MINECRAFT LAUNCHER - NEW PROFILE
cls
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
title PORTABLE MINECRAFT LAUNCHER - CREATE PROFILE
cls
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
cls
if exist %CD%\data\profiles\%PROFILE% goto EXISTS
mkdir %CD%\data\profiles\%PROFILE%
if exist %CD%\data\profiles\%PROFILE% goto LAUNCH
set LEGITCHECK="INVALID NAME"
goto NEW

:EXISTS
title PORTABLE MINECRAFT LAUNCHER - LAUNCH PROFILE
cls
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
cls
set nag="ENTER A DIFFERENT TITLE THEN"
goto NEW

:SELECT
title PORTABLE MINECRAFT LAUNCHER - SELECT PROFILE
cls
echo %NAG%
set nag=SELECTION TIME!
echo type the name of the profile
echo only use letters and numbers
echo type menu to return to the main menu
set /p profile="enter a name for the profile to launch: "
set appdata=%CD%\data\profiles\%PROFILE%
if %PROFILE%==default goto DEFAULT
if %profile%==menu goto MENU
if exist %CD%\data\profiles\%PROFILE% goto LAUNCH
set nag=PROFILE "%profile%" DOES NOT EXISTS
goto CREATE
goto ERROR

:LAUNCH
cls
set APPDATA=%CD%\data\profiles\%PROFILE%
goto oscheck

:DEFAULT
cls
set APPDATA=%CD%\data
goto OSCHECK

:DELETE
title PORTABLE MINECRAFT LAUNCHER - DELETE PROFILE
cls
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
cls
rmdir /s %CD%\data\profiles\%PROFILE%
goto MENU

:DELETEMAIN
cls
ECHO TO PROTECT MY SAVES I MADE THIS THE HARDEST OPTION TO DO. PLEASE LEAVE THE COMPUTER. > %CD%\doc\README.TXT
START NOTEPAD.EXE %CD%\doc\README.TXT
GOTO MENU

:OSCHECK
title PORTABLE MINECRAFT LAUNCHER - JAVA
cls
echo type y for system or anything else for portable java
echo press enter afterwards
set /p choice="choice: "
if %choice%==y goto JAVALAUNCH
goto JAVACHECK
goto ERROR

:JAVALAUNCH
cls
start %CD%\bin\Minecraft.jar
goto END

:JAVACHECK
cls
if not exist %CD%\bin\commonfiles\java\bin\javaw.exe goto JAVAINSTALLERCHECK
start "" "%CD%\bin\commonfiles\java\bin\javaw.exe" -jar "%CD%\bin\Minecraft.jar
goto END

:JAVAINSTALLERCHECK
cls
if not exist jPortable_8_Update_121.paf.exe goto DOWNLOADJAVA
start jPortable_8_Update_121.paf.exe
title READMEREADMEREADMEREADMEREADMEREADMEREADMEREADMEREADMEREADMEREADMEREADMEREADMEREADMEREADME
echo INSTALL JAVA TO %CD%\bin\commonfiles\Java AND PRESS ENTER TO CONTINUE
pause
del jPortable_8_Update_121.paf.exe
goto JAVACHECK

:DOWNLOADJAVA
cls
if not exist %CD%\bin\wget.exe set return=DOWNLOADJAVA
if not exist %CD%\bin\wget.exe goto DOWNLOADWGET
%CD%\bin\wget.exe http://downloads.sourceforge.net/portableapps/jPortable_8_Update_121.paf.exe
goto JAVAINSTALLERCHECK

:UPDATECHECK
cls
if exist version.txt del versiont.txt
if not exist %CD%\bin\wget.exe set return=UPDATECHECK
if not exist %CD%\bin\wget.exe goto DOWNLOADWGET
%CD%\bin\wget.exe https://github.com/MarioMasta64/MinecraftPortable/raw/master/version.txt
set /p new_version=<version.txt
if %current_version% EQU %new_version% goto LATEST
if %current_version% LSS %new_version% goto NEWUPDATE
if %current_version% GTR %new_version% goto NEWEST
goto ERROR

:LATEST
cls
title PORTABLE MINECRAFT LAUNCHER - LATEST BUILD :D
echo you are using the latest version!!
echo Current Version: v%current_version%
echo New Version: v%new_version%
echo ENTER TO CONTINUE
pause
start launcher.bat
exit

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
cls
if not exist %CD%\bin\wget.exe set return=UPDATE
if not exist %CD%\bin\wget.exe goto DOWNLOADWGET
%CD%\bin\wget.exe https://raw.githubusercontent.com/MarioMasta64/MinecraftPortable/master/launcher.bat
if exist launcher.bat.1 goto REPLACERCREATE
goto UPDATEFAILED

:REPLACERCREATE
cls
echo del launcher.bat > replacer.bat
echo rename launcher.bat.1 launcher.bat >> replacer.bat
echo start launcher.bat >> replacer.bat
echo exit >> replacer.bat
start replacer.bat
exit

:NEWEST
cls
title PORTABLE MINECRAFT LAUNCHER - TEST BUILD :0
echo YOURE USING A TEST BUILD MEANING YOURE EITHER
echo CLOSE TO ME OR YOURE SOME SORT OF PIRATE
echo Current Version: v%current_version%
echo New Version: v%new_version%
echo ENTER TO CONTINUE
pause
start launcher.bat
exit

:UPDATEFAILED
cls
echo UPDATE FAILED PRESS ENTER TO GOTO THE MAIN MENU
pause
start launcher.bat
exit

:ERROR
cls
echo ERROR OCCURED
pause
goto END

:END
