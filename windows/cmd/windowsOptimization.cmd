@set @jscript=1/*
 @echo off&setlocal

:: Run as administrator
 reg query "hku\S-1-5-19" >nul 2>&1 || (
   @cscript //e:jscript //nologo "%~f0" "%~f0"
   goto :eof
 )


::Turn off Hibernation, Hiberfil.sys
powercfg.exe /h off


::Compact OS
COMPACT.EXE /CompactOS:always

::Clean Up the WinSxS Folder
dism /online /cleanup-image /StartComponentCleanup /ResetBase

::Disk Cleanup


:eof
 */
 var strArg = WScript.Arguments(0);
 var objSH = WScript.CreateObject("Shell.Application");
 objSH.ShellExecute(strArg, "", "", "runas", "5");


