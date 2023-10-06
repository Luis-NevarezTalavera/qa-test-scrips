@echo off

cd C:\ABS\TestClient\TestClientRequests\LoadTest\

echo == Copying CC-Disco Config files ==
docker ps | grep 'cc-disco' | awk -F ' '  '{print $1}' 1>cc-disco-containerId.txt
timeout 3 1>NUL
set /p containerId=<cc-disco-containerId.txt
copy_cc-disco-configs.bat %1 %containerId%
timeout 20 1>NUL

get_date-time.bat | awk -F ':' '{print $1}' > _temp_DateHour.txt
set /p DateHour=<_temp_DateHour.txt
echo ++--- Executing LoadTest for test client: %1 test cases from folder TestClientRequests\%1\%2 --++
echo saving logs to LogFolder\LoadTest-%DateHour%\%1\%1-%DateHour%_%2
set StartDateTime=%DATE% %TIME%
echo Start Date-Time: %StartDateTime%
echo Start Date-Time: %DateTime% > c:\ABS\TestClient\LogFolder\LoadTest-%DateHour%\%1\%1-%DateHour%_%2\start-end_date-time.log
disco-test-client %1\%2 %1\ConnectionConfig.json c:\ABS\TestClient\LogFolder\LoadTest-%DateHour%\%1\%1-%DateHour%_%2
set EndDateTime=%DATE% %TIME%
echo off
echo Copying CC-Disco and Siemens Adapter log files to LogFolder\LoadTest-%DateHour%\%1\%1-%DateHour%_%2
cd c:\ABS\TestClient\LogFolder\LoadTest-%DateHour%\%1\%1-%DateHour%_%2\
copy C:\ABS\cc-platform\logs\site\disco-service-%DateHour%.log
copy C:\ABS\cc-platform\logs\site\siemens-adapter-%DateHour%.log
copy TestRun.log TestRun-%1-%DateHour%_%2.log
logs_check-errors.bat %1 %DateHour%_%2
logs_get-summary.bat %1 %DateHour%_%2