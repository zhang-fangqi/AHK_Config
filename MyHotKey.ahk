#Requires AutoHotkey v2.0

;map CapsLock to Control
CapsLock::Ctrl

;map Hyphen-Minus key to Minus Sign key
-::NumpadSub

;Switch windows with the scroll wheel when the mouse is on the taskbar
#HotIf MouseIsOver("ahk_class Shell_TrayWnd")
WheelUp::Send "!+{Esc}"
WheelDown::Send "!{Esc}"
#HotIf
MouseIsOver(WinTitle) {
	MouseGetPos ,, &Win
	return WinExist(WinTitle " ahk_id " Win)
}

SwitchWindow(exeName)
{
	if WinExist("ahk_exe " . exeName)
	{
		if WinActive("ahk_exe " . exeName)
			WinMinimize
		else
			WinActivate("ahk_exe " . exeName)
		Sleep 200
	}
	else
	{
		Run exeName
		Sleep 1000
	}
}

;switch the input method to English
SwitchInputMethodLang(lang)
{
	Local param := 0
	if(lang == "English")
	{
		param := 0
	}
	if(lang == "Chinese")
	{
		param := 1025
	}
	hWnd := winGetID("A")
	SendMessage(
	0x283, ; Message : WM_IME_CONTROL
	0x002, ; wParam : IMC_SETCONVERSIONMODE
	param, ; lParam ：0 - EN, 1025 - CN
		,
	"ahk_id " DllCall("imm32\ImmGetDefaultIMEWnd", "Uint", hWnd, "Uint")
	)
}

;use control + 1 to open explorer
^1::
{
	if(WinActive("AHK_Class CabinetWClass")){
		WinMinimize
	} else if(WinExist("ahk_class CabinetWClass")){
		winActivate
	} else {
		run "C:\Windows\explorer.exe"
	}
}

;use control + 2 to open edge
^2::
{
	SwitchWindow("msedge.exe")
}

;use control + 3 to open vscode
^3::
{
	; SwitchWindow("Code.exe")
	if WinExist("ahk_exe Code.exe")
	{
		if WinActive("ahk_exe Code.exe")
			WinMinimize
		else
			WinActivate("ahk_exe Code.exe")
	}
	else
	{
		code := StrReplace(A_AppData, "Roaming", "Local\Programs\Microsoft VS Code\Code.exe")
		Run code
	}
}

;use control + 4 to open Neovim
^4::
{
	DetectHiddenWindows True
	SwitchWindow("nvim-qt.exe")
	
	if WinActive("ahk_exe nvim-qt.exe")
	{
		Sleep 500
		SwitchInputMethodLang("English")
	}
}

;move the window to the center
IsDCIOTWindowOpen := false
CheckDCIOTWindow()
{
	;access global variables within a function
	;you need to add global within the function
	global
	If WinActive("DCIOT Simulator")
	{
		if(IsDCIOTWindowOpen == false)
		{
			Sleep 2000
			MonitorCount := MonitorGetCount()
			WinGetPos &x, &y, &w, &h, "DCIOT Simulator"
			If (MonitorCount >= 2) ; check if there are multiple displays
			{
				MonitorGet(1, &Left, &Top, &Right, &Bottom)
				x := Left + (Right - Left - w) / 2
				y := Top + (Bottom - Top - h) / 2
				WinMove x, y,,, "DCIOT Simulator"
			}
			IsDCIOTWindowOpen :=true
		}
	}
	else{
		if(IsDCIOTWindowOpen == true)
		{
			IsDCIOTWindowOpen := false
		}
	}
}

;below code doesn't work for powertoys
IsPowerToysWindowOpen := false
CheckPowerToysRunWindow()
{
	; global
	; If WinActive("ahk_exe PowerToys.PowerLauncher.exe")
	; {
	; 	if(IsPowerToysWindowOpen == false)
	; 	{
	; 		IsPowerToysWindowOpen := true
	; 		SwitchInputMethodLang("English")
	
	; 	}
	; }
	; else{
	; 	if(IsPowerToysWindowOpen == true)
	; 	{
	; 		IsPowerToysWindowOpen := false
	; 	}
	; }
}

CheckWindows()
{
	CheckDCIOTWindow()
	CheckPowerToysRunWindow()
}
SetTimer CheckWindows, 500

