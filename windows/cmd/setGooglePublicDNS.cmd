@set @jscript=1/*
 @echo off&setlocal

:: Run as administrator
 reg query "hku\S-1-5-19" >nul 2>&1 || (
   @cscript //e:jscript //nologo "%~f0" "%~f0"
   goto :eof
 )


:: Wireless LAN adapter
set INTERFACE=Wi-Fi

:: Google DNS
set DNS1=8.8.8.8
set DNS2=8.8.4.4

netsh int ipv4 set dnsserver "%INTERFACE%" static %DNS1% primary validate=no
netsh int ipv4 add dnsserver "Wi-Fi" %DNS2% index=2 validate=no

ipconfig /flushdns


:eof
 */
 var strArg = WScript.Arguments(0);
 var objSH = WScript.CreateObject("Shell.Application");
 objSH.ShellExecute(strArg, "", "", "runas", "5");


