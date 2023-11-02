@echo off
set RegressionType=%1
set TestClient=%2
cd C:\ABS\TestClient\LoadTest\
echo ++--- Executing LoadTest: %RegressionType% for test client: %TestClient% with test cases from folder TestClientRequests\%RegressionType%\%TestClient% --++
get_date-time.bat | awk -F ':' '{print $1}' > _temp_DateHour.txt
timeout /t 1
set /p DateHour=<_temp_DateHour.txt
echo saving logs to LogFolder\LoadTest-%DateHour%_%RegressionType%\%TestClient%
mkdir c:\ABS\TestClient\LogFolder\LoadTest-%DateHour%_%RegressionType%\%TestClient%
set StartDateTime=%DATE% %TIME%
echo Start Date-Time: %StartDateTime%
echo Start Date-Time: %StartDateTime% > c:\ABS\TestClient\LogFolder\LoadTest-%DateHour%_%RegressionType%\%TestClient%\start-end_date-time.log
echo on
disco-test-client C:\ABS\TestClient\LoadTest\%TestClient%\%RegressionType% C:\ABS\TestClient\LoadTest\%TestClient%\ConnectionConfig.json C:\ABS\TestClient\LogFolder\LoadTest-%DateHour%_%RegressionType%\%TestClient%
@echo off
set EndDateTime=%DATE% %TIME%
echo End Date-Time: %EndDateTime%
echo Copying CC-Disco and Siemens Adapter log files to LogFolder\LoadTest-%DateHour%_%RegressionType%\%TestClient%
echo F|xcopy /f /q /v /y c:\ABS\TestClient\LogFolder\LoadTest-%DateHour%_%RegressionType%\%TestClient%\TestRun.log c:\ABS\TestClient\LogFolder\LoadTest-%DateHour%_%RegressionType%\%TestClient%\TestRun_LoadTest-%DateHour%_%RegressionType%_%TestClient%.log
echo F|xcopy /f /q /v /y C:\ABS\cc-platform\logs\site\disco-service-%DateHour%.log   c:\ABS\TestClient\LogFolder\LoadTest-%DateHour%_%RegressionType%\%TestClient%\disco-service_LoadTest-%DateHour%_%RegressionType%_%TestClient%.log
echo F|xcopy /f /q /v /y C:\ABS\cc-platform\logs\site\siemens-adapter-%DateHour%.log c:\ABS\TestClient\LogFolder\LoadTest-%DateHour%_%RegressionType%\%TestClient%\siemens-adapter_LoadTest-%DateHour%_%RegressionType%_%TestClient%.log
:: deprecated logs_check-errors.bat c:\ABS\TestClient\LogFolder\LoadTest-%DateHour%_%RegressionType%\%TestClient% LoadTest-%DateHour%_%RegressionType%_%TestClient%
call logs-get_summary.bat c:\ABS\TestClient\LogFolder\LoadTest-%DateHour%_%RegressionType%\%TestClient% LoadTest-%DateHour%_%RegressionType%_%TestClient%
exit