echo off
echo Executing test client, test cases from folder TestClientRequests\%1
echo saving logs to LogFolder-%1-%2
cd c:\ABS\TestClient\
time /t
echo on
disco-test-client TestClientRequests\%1 C:\ABS\cc-disco\client\TestClient\ConnectionConfig.json c:\ABS\TestClient\LogFolder-%1-%2
echo off
echo Copying CC-Disco and Siemens Adapter log files to LogFolder-%1-%2
cd LogFolder-%1-%2\
copy c:\ABS\TestClient\CC-DISCO.log
copy c:\ABS\TestClient\Siemens-Adapter.log
copy TestRun.log TestRun-%1-%2.log
cd ..
