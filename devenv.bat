@echo off

REM Open the MySQL server
start "MySQL" /WAIT C:\_LOCALdata\MySQL\bin\mysqld.exe

REM Open the Redis server
rem start "Redis" C:\_LOCALdata\Projects\redis\msvs\Release\redis-server.exe

REM Open the web server
rem start "Dayhome Web" C:\_LOCALdata\Projects\dayhomes\start-web.bat

REM Open a git window
rem start C:\Windows\SysWOW64\cmd.exe /c ""C:\_LocalData\Git\bin\sh.exe" --login -i"

REM Open a ruby window
rem start C:\Windows\System32\cmd.exe /E:ON /K C:\_LOCALdata\Ruby193\bin\setrbvars.bat