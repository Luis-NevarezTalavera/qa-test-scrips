@echo off
cd c:\ABS\TestClient\
get_date-time.bat | awk -F ':' '{print $1}' > _temp_DateHour.txt
set /p DateHour=<_temp_DateHour.txt
echo ++--- Executing Disco Test client, test cases from folder TestClientRequests\%1 --++
echo saving logs to LogFolder\%1-%2_%DateHour%
set StartDateTime=%DATE% %TIME%
echo Start Date-Time: %StartDateTime%
disco-test-client TestClientRequests\%1 C:\ABS\TestClient\LoadTest\disco-test-client\ConnectionConfig.json c:\ABS\TestClient\LogFolder\%1-%2_%DateHour%
set EndDateTime=%DATE% %TIME%
echo End Date-Time: %EndDateTime%
echo off
echo Copying CC-Disco and Siemens Adapter log files to LogFolder\%1-%2_%DateHour%
cd c:\ABS\TestClient\LogFolder\%1-%2_%DateHour%\
copy /v C:\ABS\cc-platform\logs\site\disco-service-%DateHour%.log   C:\ABS\TestClient\LogFolder\%1-%2_%DateHour%\disco-service_%1-%2_%DateHour%.log
copy /v C:\ABS\cc-platform\logs\site\siemens-adapter-%DateHour%.log C:\ABS\TestClient\LogFolder\%1-%2_%DateHour%\siemens-adapter_%1-%2_%DateHour%.log
copy /v TestRun.log TestRun_%1-%2_%DateHour%.log
call logs-get_summary.bat C:\ABS\TestClient\LogFolder\%1-%2_%DateHour% %1-%2_%DateHour%
echo ++--- Execution of Disco Test client compleeted Successfully, test cases: TestClientRequests\%1, log folder: C:\ABS\TestClient\LogFolder\%1-%2_%DateHour%