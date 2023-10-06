@echo off
echo Copying configs for client folder: %1 into container: %2
cd c:\ABS\cc-disco\
echo %TIME%
docker cp %1\siemens-config.json %2:/app/config/vendor-configs
echo %TIME%
timeout /t 3 1>NUL
docker cp %1\test-client-config.json %2:/app/config/client-configs
timeout /t 3 1>NUL
echo %TIME%
cd c:\ABS\TestClient\
echo on