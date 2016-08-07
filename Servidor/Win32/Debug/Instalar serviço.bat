@echo off
echo AVISO! Execute este script como administrador
pushd %~dp0
MJD.Servidor.exe /install
net start "MJDService"