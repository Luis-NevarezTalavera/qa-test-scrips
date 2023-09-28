echo "Copying configs into container "%1
cd c:\ABS\cc-disco\
time /t
docker cp service\ServiceBusConfigurator.Tests\TestData\ValidConfigs\vendor-configs\siemens-config.json %1:/app/config/vendor-configs
time /t
:: timeout 25 1>NUL
docker cp client\TestClient\DiscoClientConfig\test-client-config.json %1:/app/config/client-configs
time /t
cd c:\ABS\TestClient\