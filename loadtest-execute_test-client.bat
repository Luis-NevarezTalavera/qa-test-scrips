@echo off
cd C:\ABS\TestClient\TestClientRequests\LoadTest\
::copy_cc-disco-configs.bat %1
::timeout 15 1>NUL
echo ++--- Executing LoadTest for test client: %1 test cases from folder TestClientRequests\%1\%2 --++
get_date-time.bat | awk -F ':' '{print $1}' > _temp_DateHour.txt
set /p DateHour=<_temp_DateHour.txt
echo saving logs to LogFolder\LoadTest-%DateHour%\%1\%1-%DateHour%_%2
mkdir c:\ABS\TestClient\LogFolder\LoadTest-%DateHour%\%1\%1-%DateHour%_%2\
set StartDateTime=%DATE% %TIME%
echo Start Date-Time: %StartDateTime%
echo Start Date-Time: %DateTime% > c:\ABS\TestClient\LogFolder\LoadTest-%DateHour%\%1\%1-%DateHour%_%2\start-end_date-time.log
echo on
disco-test-client C:\ABS\TestClient\LoadTest\%1\%2 C:\ABS\TestClient\LoadTest\%1\ConnectionConfig.json C:\ABS\TestClient\LogFolder\LoadTest-%DateHour%\%1\%1-%DateHour%_%2
echo off
set EndDateTime=%DATE% %TIME%

echo Copying CC-Disco and Siemens Adapter log files to LogFolder\LoadTest-%DateHour%\%1\%1-%DateHour%_%2
cd c:\ABS\TestClient\LogFolder\LoadTest-%DateHour%\%1\%1-%DateHour%_%2\
copy C:\ABS\cc-platform\logs\site\disco-service-%DateHour%.log
copy C:\ABS\cc-platform\logs\site\siemens-adapter-%DateHour%.log
copy TestRun.log TestRun-%1-%DateHour%_%2.log
logs_check-errors.bat %1 %DateHour%_%2
logs_get-summary.bat %1 %DateHour%_%2