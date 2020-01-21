@set @jscript=1/*
 @echo off&setlocal

:: Run as administrator
 reg query "hku\S-1-5-19" >nul 2>&1 || (
   @cscript //e:jscript //nologo "%~f0" "%~f0"
   goto :eof
 )


::Disable Internet Explorer Feature
dism /online /Disable-Feature /FeatureName:Internet-Explorer-Optional-amd64


:eof
 */
 var strArg = WScript.Arguments(0);
 var objSH = WScript.CreateObject("Shell.Application");
 objSH.ShellExecute(strArg, "", "", "runas", "5");


