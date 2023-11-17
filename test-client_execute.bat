@echo off
echo ++--- Executing Disco Test client, test cases from folder TestClientRequests\%1 --++
cd c:\ABS\TestClient\
call date-time.bat
set DateHour=%mydate%_%mytimehh%
echo saving logs to LogFolder\%1-%2_%DateHour%
set StartDateTime=%DATE% %TIME%
:: echo Start Date-Time: %StartDateTime%
disco-test-client TestClientRequests\%1 C:\ABS\TestClient\LoadTest\disco-test-client\ConnectionConfig.json c:\ABS\TestClient\LogFolder\%1-%2_%DateHour%
set EndDateTime=%DATE% %TIME%
echo End Date-Time: %EndDateTime%
echo Start Date-Time:	%StartDateTime% > c:\ABS\TestClient\LogFolder\%1-%2_%DateHour%\start-end_date-time.log
echo End Date-Time:	%EndDateTime%    >> c:\ABS\TestClient\LogFolder\%1-%2_%DateHour%\start-end_date-time.log
echo off
echo Copying CC-Disco and Siemens Adapter log files to LogFolder\%1-%2_%DateHour%
cd c:\ABS\TestClient\LogFolder\%1-%2_%DateHour%\
copy /v C:\ABS\cc-platform\logs\site\disco-service-%DateHour%.log   C:\ABS\TestClient\LogFolder\%1-%2_%DateHour%\disco-service_%1-%2_%DateHour%.log
copy /v C:\ABS\cc-platform\logs\site\siemens-adapter-%DateHour%.log C:\ABS\TestClient\LogFolder\%1-%2_%DateHour%\siemens-adapter_%1-%2_%DateHour%.log
copy /v TestRun.log TestRun_%1-%2_%DateHour%.log
call logs-get_summary.bat C:\ABS\TestClient\LogFolder\%1-%2_%DateHour% %1-%2_%DateHour% %DateHour%
echo +--- Clearing RabbitMQ DREX errors queue ---+
call rabbitmq-read_drex-errors.bat 100 disco-test-client
echo ++--- Execution of Disco Test client completed Successfully, test cases: TestClientRequests\%1, log folder: C:\ABS\TestClient\LogFolder\%1-%2_%DateHour%