@echo off
set RegressionType=%1
set TestClient=%2
set loop=%3

echo ++--- Executing LoadTest: %RegressionType% for test client: %TestClient% with test cases from folder TestClientRequests\%RegressionType%\%TestClient% --++
echo saving logs to LogFolder\LoadTest-%DateHour%_%RegressionType%\%TestClient%
mkdir c:\ABS\TestClient\LogFolder\LoadTest-%DateHour%_%RegressionType%\%TestClient%
set StartDateTime=%DATE% %TIME%
echo Start Date-Time %loop%:	%StartDateTime% >> c:\ABS\TestClient\LogFolder\LoadTest-%DateHour%_%RegressionType%\%TestClient%\start-end_date-time.log
echo Start Date-Time %loop%:	%StartDateTime%

echo on
disco-test-client C:\ABS\TestClient\LoadTest\%TestClient%\%RegressionType% C:\ABS\TestClient\LoadTest\%TestClient%\ConnectionConfig.json C:\ABS\TestClient\LogFolder\LoadTest-%DateHour%_%RegressionType%\%TestClient%
@echo off

set EndDateTime=%DATE% %TIME%
echo End Date-Time %loop%:	%EndDateTime% >> c:\ABS\TestClient\LogFolder\LoadTest-%DateHour%_%RegressionType%\%TestClient%\start-end_date-time.log
echo End Date-Time %loop%:	%EndDateTime%

echo Getting Warnings and Errors from CC-Disco, Siemens Adapter log files and Creating Summary for LogFolder\LoadTest-%DateHour%_%RegressionType%\%TestClient%
if %TestClient%==disco-test-client-1 call logs-get_services-errors.bat LoadTest-%DateHour%_%RegressionType% %DateHourLastClient%
call logs-get_summary.bat LoadTest-%DateHour%_%RegressionType% %TestClient% %DateHourLastClient%

echo +--- Clearing RabbitMQ DREX errors queue from previous batch ---+
call rabbitmq-read_drex-errors.bat 10 %TestClient%

echo +--- Copying disco-service and siemens-adapter logs to loadtest folder ---+
echo F|xcopy /d /y /q C:\ABS\cc-platform\logs\site\disco-service-%DateHour%.log   c:\ABS\TestClient\LogFolder\LoadTest-%DateHour%_%RegressionType%\disco-service_%DateHour%.log
echo F|xcopy /d /y /q C:\ABS\cc-platform\logs\site\siemens-adapter-%DateHour%.log c:\ABS\TestClient\LogFolder\LoadTest-%DateHour%_%RegressionType%\siemens-adapter_%DateHour%.log

exit