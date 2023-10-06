@echo off
echo "Copying configs into container "%1
cd c:\ABS\cc-disco\
echo %TIME%
docker cp service\ServiceBusConfigurator.Tests\TestData\ValidConfigs\vendor-configs\siemens-config.json %1:/app/config/vendor-configs
echo %TIME%
timeout /t 3 1>NUL
docker cp client\TestClient\DiscoClientConfig\test-client-config.json %1:/app/config/client-configs
timeout /t 3 1>NUL
echo %TIME%
cd c:\ABS\TestClient\
echo on