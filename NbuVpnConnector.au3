#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=iconfinder_stumbleupon-old-hex_278392.ico
#AutoIt3Wrapper_Res_Fileversion=0.8.0.13
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=p
#AutoIt3Wrapper_Res_CompanyName=刘慰
#AutoIt3Wrapper_Res_Language=2052
#AutoIt3Wrapper_Add_Constants=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <MsgBoxConstants.au3>

Opt("TrayAutoPause", 0)
Opt("TrayMenuMode", 2)

Func Login()
	Local $easyConnectWindow = WinWait("EasyConnect", "用户名：", 30)
	If $easyConnectWindow <> 0 Then
		WinSetState($easyConnectWindow, "", @SW_MINIMIZE)
		Local $host = ControlGetText($easyConnectWindow, "", "Edit4")
		Local $account = IniRead("./config.ini", $host, "Account", "NULL")
		ControlSetText($easyConnectWindow, "", "Edit5", $account)
		Local $password = IniRead("./config.ini", $host, "Password", "NULL")
		ControlSetText($easyConnectWindow, "", "Edit6", $password)
		ControlClick($easyConnectWindow, "", "Button15")
		Local $internetExplorerWindow = WinWait("[CLASS:IEFrame]", "", 30)
		If $internetExplorerWindow <> 0 Then
			WinClose($internetExplorerWindow)
		EndIf
	Else
		MsgBox($MB_OK, "错误", "未找到 EasyConnet 程序窗体")
	EndIf
EndFunc   ;==>Login

Local $exePath = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\Classes\sslvpn\DefaultIcon", "")

If ProcessExists("SangforCSClient.exe") <> 0 Then
	Exit
EndIf

Run($exePath)
Login()

While 1
	If ProcessExists("SangforCSClient.exe") = 0 Then
		Exit
	EndIf

	Local $reLoginWindow = WinWait("EasyConnect", "重新登录")

	If $reLoginWindow <> 0 Then
		ControlClick($reLoginWindow, "", "Button1")
		Login()
	EndIf
	Sleep(3000)
WEnd


