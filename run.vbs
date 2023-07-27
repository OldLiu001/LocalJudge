' Usage: run <executable_path> [time_limit]
' Return:
' 	0 Success
' 	1 Runtime error
'	2 Time limit exceeded
 
Set oArgs = WSH.Arguments
Set oWS = CreateObject("WScript.Shell")
Set oProg = oWS.Exec(oArgs(0))
sInput = ""
On Error Resume Next
sInput = WSH.StdIn.ReadAll
On Error GoTo 0
oProg.StdIn.Write sInput
oProg.StdIn.Close

If Trim(oArgs(1)) = "" Then	
	While oProg.Status = 0 : Wend
Else
	sngLimit = CSng(oArgs(1))
	sngStart = Timer
	sngEnd = Timer
	While sngEnd - sngStart <= sngLimit And oProg.Status = 0
		sngEnd = Timer
	Wend
	oProg.Terminate
	If sngEnd - sngStart > sngLimit Then
		WSH.Quit 2
	End If
End if
WSH.StdOut.Write oProg.StdOut.ReadAll
WSH.Quit CInt(oProg.ExitCode = 0) + 1