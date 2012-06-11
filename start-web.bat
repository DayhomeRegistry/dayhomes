@echo off

REM Set the environment
call C:\_LOCALdata\Ruby193\bin\setrbvars.bat

REM Run the web server
cd C:\_LOCALdata\Projects\dayhomes
rails server
