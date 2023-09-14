echo ++++ Starting Processes for Siemens Adapter Testing: RabbitMQ, CC-Disco, CC-Adapters-Siemens ++++
cd c:\ABS\cc-disco\
echo == Starting RabbitMQ ==
start "RabbitMQ" start-container_rabbit-mq.bat
timeout 20 > NUL
echo == Starting CC-Disco ==
start "CC-Disco" start-container_cc-disco.bat
timeout 30 > NUL
echo == Copying CC-Disco Config files ==
docker ps | grep 'cc-disco' | awk -F ' '  '{print $1}' 1>cc-disco-containerId.txt
timeout 3 1>NUL
set /p containerId=<cc-disco-containerId.txt
copy_cc-disco-configs.bat %containerId%
timeout 20 > NUL
echo == Starting CC-Adapters-Siemens ==
start "CC-Adapters-Siemens" start-container_siemens-adapter.bat