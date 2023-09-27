echo Updating DISCO Test Client
cd c:\ABS\TestClient\
setVariables_ABS-Nuget.bat LNevarezTalavera
dotnet tool update Abs.CommonCore.Disco.TestClient --global --configfile c:\ABS\TestClient\nuget.config