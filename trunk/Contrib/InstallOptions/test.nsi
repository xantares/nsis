;Install Options Test Script
;Written by Joost Verburg

!define TEMP1 $R0 ;Temp variable

;The name of the installer
Name "Install Options Test"

;The file to write
OutFile "Test.exe"

;The default installation directory
InstallDir "$PROGRAMFILES\IOTest"

;Things that need to be extracted on startup (keep these lines before any File command!)
;Use ReserveFile for your own Install Options ini files too!
ReserveFile "${NSISDIR}\Plugins\InstallOptions.dll"
ReserveFile "test.ini"

;Texts on the dialogs
DirText "Choose a directory"
LicenseText "A license"
LicenseData "..\..\License.txt"
ComponentText "Choose components"

;Order of pages
Page license
Page custom SetCustom ;Custom page. Install Options gets called in SetCustom.
Page components
Page directory
Page instfiles

Section "Components"

  ;Get Install Options dialog user input

  ReadINIStr ${TEMP1} "$PLUGINSDIR\test.ini" "Field 1" "State"
  MessageBox MB_OK "Install X=$R0"
  ReadINIStr ${TEMP1} "$PLUGINSDIR\test.ini" "Field 2" "State"
  MessageBox MB_OK "Install Y=$R0"
  ReadINIStr ${TEMP1} "$PLUGINSDIR\test.ini" "Field 3" "State"
  MessageBox MB_OK "Install Z=$R0"
  ReadINIStr ${TEMP1} "$PLUGINSDIR\test.ini" "Field 4" "State"
  MessageBox MB_OK "File=$R0"
  ReadINIStr ${TEMP1} "$PLUGINSDIR\test.ini" "Field 5" "State"
  MessageBox MB_OK "Dir=$R0"
  
SectionEnd

Function .onInit

  ;Extract Install Options files
  ;$PLUGINSDIR will automatically be removed when the installer closes
  
  Call Initialize_____Plugins
  SetDetailsPrint both
  
  File /oname=$PLUGINSDIR\test.ini "test.ini"
  
FunctionEnd

Function SetCustom

 ;Display the Install Options dialog

 Push ${TEMP1}

  InstallOptions::dialog "$PLUGINSDIR\test.ini"
  Pop ${TEMP1}

  StrCmp ${TEMP1} "cancel" "" +3
    Pop ${TEMP1}
    Quit

  StrCmp ${TEMP1} "back" "" +3
    Pop ${TEMP1}
    Abort
    
 Pop ${TEMP1}
  
FunctionEnd