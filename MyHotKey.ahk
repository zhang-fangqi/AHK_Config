#Requires AutoHotkey v2.0

;map CapsLock to Control
CapsLock::Ctrl

SwitchWindow(exeName)
{
	if WinExist("ahk_exe " . exeName)
	{
		if WinActive("ahk_exe " . exeName)
			WinMinimize
		else
			WinActivate("ahk_exe " . exeName)
	}
	else
	{
		Run exeName
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
		Sleep 1000
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



