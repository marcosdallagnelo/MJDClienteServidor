@echo off
echo AVISO! Execute este script como administrador
pushd %~dp0
net stop "MJDService"
MJD.Servidor.exe /uninstall