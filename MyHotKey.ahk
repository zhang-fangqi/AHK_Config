#Requires AutoHotkey v2.0

;map CapsLock to Control
CapsLock::Ctrl

;use control+1 to open edge
^1::
{
	SetTitleMatchMode 2
	if WinExist("Microsoft​ Edge")
	{
		WinActivate
	}
	else
	{
		Run "msedge"
	}
	return
}

;use control+2 to open Neovim
^2::
{
	DetectHiddenWindows True
	SetTitleMatchMode 2
	if WinExist("Neovim")
	{
		WinActivate
	}
	else
	{
		Run "nvim-qt.exe"
	}
	Sleep 1000
	hWnd := winGetID("A")
    SendMessage(
        0x283, ; Message : WM_IME_CONTROL
        0x002, ; wParam : IMC_SETCONVERSIONMODE
        0,  ; lParam ：0 - EN
        ,
        "ahk_id " DllCall("imm32\ImmGetDefaultIMEWnd", "Uint", hWnd, "Uint")
    )
	return
}



