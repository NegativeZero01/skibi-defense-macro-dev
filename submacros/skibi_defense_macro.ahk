#Requires AutoHotkey v2.0
#SingleInstance Force
#MaxThreads 255
#Warn All, Off
Persistent(true)
SetWorkingDir A_InitialWorkingDir
CoordMode("Pixel", "Client")
SendMode("Event")
OnError (e, mode) => (mode = "Return") ? -1 : 0

;@Ahk2Exe-SetCopyright Copyright © NegativeZero01 on Github (https://github.com/NegativeZero01)
;@Ahk2Exe-SetDescription Skibi Defense Macro [ALPHA]

global A_MacroWorkingDir := A_InitialWorkingDir "\"
global A_SettingsWorkingDir := A_MacroWorkingDir "settings\"
global A_ThemesWorkingDir := A_MacroWorkingDir "lib\Themes\"
global exe_path32 := A_AhkPath
global exe_path64 := (A_Is64bitOS && FileExist("AutoHotkey64.exe")) ? (A_MacroWorkingDir "submacros\AutoHotkey64.exe") : A_AhkPath

global UTVID := "v0.0.0.0"
global Month := FormatTime("MMMM")
global releases := QueryGitHubRepo("NegativeZero01/skibi-defense-macro", "releases")
global RRN := releases[1]["tag_name"]
global ReleaseName := "skibi-defense-macro-" RRN
global CurrentVersion := ReplaceChar(UTVID)
global CRRN := ReplaceChar(RRN)

RunWith32()
CreateFolder(A_MacroWorkingDir "settings")
CreateFolder(A_MacroWorkingDir "img\bitmap-debugging")
WriteConfig('[Settings]`nGUI_X=0`nGUI_Y=0`nAlwaysOnTop=`nGUITransparency=0`nGUITheme=None`nKeyDelay=25`nMainGUILoadPercent=0`nHotkeyGUILoadPercent=0`nStartHotkey=F1`nPauseHotkey=F2`nStopHotkey=F3`nCloseHotkey=F4`nPrivServer=`nVID=v0.2.0.0-beta.2', A_SettingsWorkingDir "main-config.ini")
if !FileExist(A_Desktop "\Start SD-Macro.lnk") {
    FileCreateShortcut(A_MacroWorkingDir "Start.bat", A_Desktop "\Start SD-Macro.lnk")
}
sd_ImportMainConfig()
CheckDisplaySpecs()
QueryUpdateValidity()

W := "sc011"
A := "sc01e"
S := "sc01f"
D := "sc020"
I := "sc017"
O := "sc018"
E := "sc012" 
R := "sc013"
L := "sc026"
Escape := "sc001"
Enter := "sc01c"
Space := "sc039"
Slash := "sc035"
LShift := "sc02a"
RShift := "sc036"
Zero := "sc00B"
One := "sc002"
Two := "sc003"
Three := "sc004"
Four := "sc005"
Five := "sc006"
Six := "sc007"
Seven := "sc008"
Eight := "sc009"
Nine := "sc00A"
LMB := "LButton"
RMB := "RButton"
ScrollUp := "WheelUp"
ScrollDown := "WheelDown"
F11 := "F11"

#Include "%A_InitialWorkingDir%\lib\"
#Include "FormData.ahk"
#Include "cJSON.ahk"
#Include "Gdip_All.ahk"
#Include "Gdip_ImageSearch.ahk"

#Include "mainFiles\update_checker.ahk"
#Include "mainFiles\GUI.ahk"
#Include "mainfiles\ROBLOX.ahk"
#Include "mainFiles\functions.ahk"


if !(pToken := Gdip_Startup())
    Throw OSError("Gdip_Startup failed")
(bitmaps:=Map()).CaseSense := 0

#Include "%A_InitialWorkingDir%\img\bitmaps.ahk"


LanguageText := []
LanguageFileContent := FileRead(A_ScriptDir "english.txt")
loop Parse LanguageFileContent, "`r`n", "`r`n" {
    LanguageText.Push(A_LoopField)
}
Hotkey(StartHotkey, sd_Start)
sd_Start(*) {
    MsgBox(LanguageText[2])
}

/*Close Macro?
Closing Macro
Yes
No
Couldn't find the 32-bit version of Autohotkey in:`n
Error
Your display scale is not 100%!`nThis means the Macro will not be able to detect images in-game correctly, resulting in failure!`nTo fix this, follow these steps:`n - Open Settings (Win+I)`n - Navigate to System >> Display`n - Then set the scale to 100% (even if it isn't recommended for your device)`n - Restart the Macro and ROBLOX`n - Sign out if prompted to
Warning
Could not create the " folder " directory!`nThis means the Macro will not be able to use the functions of the files usually in this folder!`nTry moving the Macro to a different folder (e.g. Downloads or Documents).
Failed to Create folder*/