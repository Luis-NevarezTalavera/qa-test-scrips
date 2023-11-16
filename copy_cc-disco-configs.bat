@echo off
set clientId=%1
echo == Copying CC-Disco Config files for client: %clientId% at %TIME% ==
docker ps | grep 'cc-disco' | awk -F ' '  '{print $1}' 1>cc-disco-containerId.txt
timeout /t 1 > NUL
set /p containerId=<cc-disco-containerId.txt

echo Copying configs for client folder: %clientId% into container: %containerId%
echo %clientId%\%clientId%-config.json
docker cp C:\ABS\TestClient\LoadTest\%clientId%\%clientId%-config.json %containerId%:/app/config/client-configs
timeout /t 1 > NUL
echo %clientId%\siemens-config.json
docker cp C:\ABS\TestClient\LoadTest\%clientId%\siemens-config.json %containerId%:/app/config/vendor-configs

echo %TIME%
echo on