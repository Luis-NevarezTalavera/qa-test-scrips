@echo off
get_date-time.bat | awk -F ':' '{print $1}' > _temp_DateHour.txt
set /p DateHour=<_temp_DateHour.txt
echo Executing test client, test cases from folder TestClientRequests\%1
echo saving logs to LogFolder-%1-%2_%DateHour%
cd c:\ABS\TestClient\
time /t
echo on
disco-test-client TestClientRequests\%1 C:\ABS\TestClient\ConnectionConfig.json c:\ABS\TestClient\LogFolder-%1-%2_%DateHour%
echo off
echo Copying CC-Disco and Siemens Adapter log files to LogFolder-%1-%2_%DateHour%
cd LogFolder-%1-%2_%DateHour%\
copy C:\ABS\cc-platform\logs\site\disco-service-%DateHour%.log
copy C:\ABS\cc-platform\logs\site\siemens-adapter-%DateHour%.log
copy TestRun.log TestRun-%1-%2_%DateHour%.log
cd ..
logs_check-errors.bat %1 %2_%DateHour%