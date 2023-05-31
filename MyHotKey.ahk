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
	return
}

;use control+1 to open edge
^1::
{
	SwitchWindow("msedge.exe")
	return
}

;use control+2 to open Neovim
^2::
{
	DetectHiddenWindows True
	SwitchWindow("nvim-qt.exe")
	if WinActive("ahk_exe nvim-qt.exe")
	{
		hWnd := winGetID("A")
		SendMessage(
			0x283, ; Message : WM_IME_CONTROL
			0x002, ; wParam : IMC_SETCONVERSIONMODE
			0,  ; lParam ：0 - EN
			,
			"ahk_id " DllCall("imm32\ImmGetDefaultIMEWnd", "Uint", hWnd, "Uint")
		)
	}
	return
}



