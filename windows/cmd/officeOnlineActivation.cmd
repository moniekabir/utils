@set @jscript=1/*
 @echo off&setlocal

:: Run as administrator
 reg query "hku\S-1-5-19" >nul 2>&1 || (
   @cscript //e:jscript //nologo "%~f0" "%~f0"
   goto :eof
 )


:: Online Activation
set OfficeDir=C:\Program Files\Microsoft Office\Office16
cscript \\B "%OfficeDir%\ospp.vbs" /sethst:kms.digiboy.ir
cscript \\B "%OfficeDir%\ospp.vbs" /act


:eof
 */
 var strArg = WScript.Arguments(0);
 var objSH = WScript.CreateObject("Shell.Application");
 objSH.ShellExecute(strArg, "", "", "runas", "5");