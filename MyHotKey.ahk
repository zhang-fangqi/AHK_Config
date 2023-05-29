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
	SetTitleMatchMode 2
	if WinExist("Neovim")
	{
		WinActivate
	}
	else
	{
		Run "nvim-qt.exe"
		PostMessage 0x0050, 0, 00000409,, "A"  ; 0x0050 is WM_INPUTLANGCHANGEREQUEST.
	}
	return
}

