echo Updating DISCO Test Client
cd c:\ABS\TestClient\
set ABS_NUGET_USERNAME=Luis-NevarezTalavera
set /p ABS_NUGET_PASSWORD=<c:\Users\LNevarezTalavera\myGitHubToken.txt
dotnet tool update Abs.CommonCore.Disco.TestClient --global --configfile c:\ABS\TestClient\nuget.config