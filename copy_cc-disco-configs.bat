echo "Copying configs into container "%1
cd c:\ABS\cc-disco\
docker cp service\ServiceBusConfigurator.Tests\TestData\ValidConfigs\vendor-configs\siemens-config.json %1:/app/config/vendor-configs
timeout 25 > NUL
docker cp client\TestClient\DiscoClientConfig\test-client-config.json %1:/app/config/client-configs
timeout 25 > NUL