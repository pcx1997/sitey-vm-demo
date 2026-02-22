Set WshShell = CreateObject("WScript.Shell")
strPath = CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName)
WshShell.CurrentDirectory = strPath
WshShell.Environment("Process").Item("PYTHONPATH") = strPath & "\app\backend;" & strPath & "\app"
WshShell.Environment("Process").Item("PYTHONIOENCODING") = "utf-8"
WshShell.Run """" & strPath & "\SiteyVM.bat""", 0, False
