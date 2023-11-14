@echo off
echo ++--- Updating DISCO Test Client ---++
cd c:\ABS\TestClient\
echo dotnet tool update Abs.CommonCore.Disco.TestClient --global --configfile c:\ABS\TestClient\nuget.config
call set-Variables_ABS-Nuget.bat LNevarezTalavera
call dotnet tool update Abs.CommonCore.Disco.TestClient --global --configfile c:\ABS\TestClient\nuget.config
echo ++--- Disco Test Client was successfully updated %DATE% %TIME%  ---++