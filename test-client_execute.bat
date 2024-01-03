@echo off
set TestType=%1
set TestName=%2
echo ++--- Executing Disco Test client, test cases from folder TestClientRequests\%TestType% --++
cd c:\ABS\TestClient\
call date-time.bat
set DateHour=%mydate%_%mytimehh%
echo saving logs to LogFolder\%TestType%-%TestName%_%DateHour%
set StartDateTime=%DATE% %TIME%
:: echo Start Date-Time: %StartDateTime%
disco-test-client TestClientRequests\%TestType% C:\ABS\TestClient\LoadTest\disco-test-client\ConnectionConfig.json c:\ABS\TestClient\LogFolder\%TestType%-%TestName%_%DateHour%
set EndDateTime=%DATE% %TIME%
echo End Date-Time: %EndDateTime%
echo Start Date-Time:	%StartDateTime% > c:\ABS\TestClient\LogFolder\%TestType%-%TestName%_%DateHour%\start-end_date-time.log
echo End Date-Time:	%EndDateTime%    >> c:\ABS\TestClient\LogFolder\%TestType%-%TestName%_%DateHour%\start-end_date-time.log
echo off
echo Copying CC-Disco and Siemens Adapter log files to LogFolder\%TestType%-%TestName%_%DateHour%
cd c:\ABS\TestClient\LogFolder\%TestType%-%TestName%_%DateHour%\
echo F|xcopy /d /y /q C:\ABS\cc-platform\logs\site\disco-service-%DateHour%.log   C:\ABS\TestClient\LogFolder\%TestType%-%TestName%_%DateHour%\disco-service_%TestType%-%TestName%_%DateHour%.log
echo F|xcopy /d /y /q C:\ABS\cc-platform\logs\site\siemens-adapter-%DateHour%.log C:\ABS\TestClient\LogFolder\%TestType%-%TestName%_%DateHour%\siemens-adapter_%TestType%-%TestName%_%DateHour%.log
del /q TestRun_%TestType%-%TestName%_%DateHour%.log
call logs-get_summary.bat %TestType%-%TestName%_%DateHour% %DateHour% disco-test-client
rename TestRun.log TestRun_%TestType%-%TestName%_%DateHour%.log
timeout /t 12 /nobreak
:: echo +--- Clearing RabbitMQ DREX errors queue ---+
call rabbitmq-read_drex-errors.bat 300 disco-test-client
echo ++--- Execution of Disco Test client completed Successfully, test cases: TestClientRequests\%TestType%, log folder: C:\ABS\TestClient\LogFolder\%TestType%-%TestName%_%DateHour%