echo off
echo Executing test client, test cases from folder %1
echo saving logs to LogFolder-%1
cd C:\ABS\cc-disco\client\TestClient\
echo on
disco-test-client TestClientRequests\%1 ConnectionConfig.json LogFolder-%2
echo off
echo Copying CC-Disco and Siemens Adapter log files to LogFolder-%2
cd C:\ABS\cc-disco\client\TestClient\LogFolder-%2\
copy C:\ABS\cc-disco\CC-DISCO.log
copy C:\ABS\cc-disco\Siemens-Adapter.log
copy TestRun.log TestRun-%2.log