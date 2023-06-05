#Requires AutoHotkey v2.0

;map CapsLock to Control
CapsLock::Ctrl

;Switch windows with the scroll wheel when the mouse is on the taskbar
#HotIf MouseIsOver("ahk_class Shell_TrayWnd")
WheelUp::Send "!+{Esc}"
WheelDown::Send "!{Esc}"
#HotIf
MouseIsOver(WinTitle) {
	MouseGetPos ,, &Win
	return WinExist(WinTitle " ahk_id " Win)
}

SwitchWindow(windowName)
{
	if WinExist(windowName)
	{
		if WinActive(windowName)
			WinMinimize
		else
			WinActivate(windowName)
		Sleep 200
	}
	else
	{
		Run windowName
		Sleep 1000
	}
	return
}

;use control + alt + e to open explorer
^!e::
{
	if(WinActive("AHK_Class CabinetWClass")){
		WinMinimize
	} else if(WinExist("ahk_class CabinetWClass")){
		winActivate
	} else {
		run "C:\Windows\explorer.exe"
	}
	return
}

;use control+1 to open edge
^1::
{
	SwitchWindow("ahk_exe msedge.exe")
	return
}
;use control+2 to open Neovim
^2::
{
	DetectHiddenWindows True
	SwitchWindow("ahk_exe nvim-qt.exe")
	if WinActive("ahk_exe nvim-qt.exe")
	{
		hWnd := winGetID("A")
		SendMessage(
		0x283, ; Message : WM_IME_CONTROL
		0x002, ; wParam : IMC_SETCONVERSIONMODE
		0, ; lParam ：0 - EN
			,
		"ahk_id " DllCall("imm32\ImmGetDefaultIMEWnd", "Uint", hWnd, "Uint")
		)
	}
	return
}

;move the window to the center
IsDCIOTWindowOpen := false
CheckDCIOTWindow()
{
	;access global variables within a function
	;you need to add global within the function
	global
	If WinExist("DCIOT Simulator")
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
	Return
}
SetTimer CheckDCIOTWindow, 500

