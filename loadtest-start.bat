@echo off
:: 4 Arguments
set testType=%1
set clientsQty=%2
set startClient=%3
set testDurationMns=%4
:: Variables
set /a lastClient=startClient+clientsQty-1
set cycleDurationMns=5
set testClientTimeout=0
set waitForNextLoop=0
set loops=1

if %testType%==OnDemand (
    set /a "loops=testDurationMns/cycleDurationMns"
    set /a "waitForNextLoop=(cycleDurationMns*60)-(clientsQty*2)"
    set /a "testClientTimeout=(cycleDurationMns*60)-30"
    ) else (
    set loops=1
    set waitForNextLoop=0
    set /a "testClientTimeout=(testDurationMns+3)*60"
    )

cd C:\ABS\TestClient\LoadTest\
echo +++--- Starting CC-DISCO / Siemens Adapter Load Test ---+++
echo --- This script requires 3 arguments: Request type OnDemand/Schedule: %testType%, TestClients qty: %clientsQty%, Starting at Client #: %startClient%, Loops: %loops%
call date-time.bat
set DateHour=%mydate%_%mytimehh%
set StartDateTime=%DATE% %TIME%

:: Clearing the Error Messages from the DRex queue in RabbitMQ
call rabbitmq-read_drex-errors.bat 2000 before-LoadTest

echo +-- Setting Test Client Timeout in the ConnectionConfig.json file to %testClientTimeout% --+
for /l %%i in (%startClient%,1,%lastClient%) do call test-client_set-timeout disco-test-client-%%i %testClientTimeout%

cd C:\ABS\TestClient\LoadTest\
echo +--- Creating %clientsQty% Test Client instances in independent Command Prompt Windows ---+

if %testType%==OnDemand echo +--- Starting Test Clients %startClient% to %lastClient%, every 5 minutes, wait time: %waitForNextLoop%, loops: %loops% ---+
for /l %%j in (1,1,%loops%) do (

    echo +--- Starting %clientsQty% New Test Clients every %cycleDurationMns% mns, Loop: %%j of Total Loops: %loops% ---+
    call date-time.bat
    set DateHourLastClient=%mydate%_%mytimehh%
    
    for /l %%i in (%startClient%,1,%lastClient%) do (
        timeout /t 1 > NUL
        echo -- starting disco-test-client-%%i --
        start "test-client-%%i %%j" loadtest-execute_test-client %testType% disco-test-client-%%i %%j
    )
    
    echo +--- Waiting %waitForNextLoop% secs for next batch of TestClients, 330 secs after the last batch, Loop: %%j of Total Loops: %loops% ... Ctrl+C to end ---+
    if %%j LSS %loops% ( timeout /t %waitForNextLoop% ) else ( timeout /t 330 )

)

:: Clearing RabbitMQ DREX errors queue
cd C:\ABS\TestClient\LoadTest\
call rabbitmq-read_drex-errors.bat 200 after-LoadTest

set EndDateTime=%DATE% %TIME%
echo End Date-Time: %EndDateTime%
echo About to create Grand Summary for LoadTest: %DateHour% %testType%, press any key when All Individual Summaries are created

cd C:\ABS\TestClient\LogFolder
call loadtest-create_summary.bat LoadTest-%DateHour%_%testType% %clientsQty%

echo +-- Clearing up original TestRun.log from each test client subfolder --+
for /l %%i in (%startClient%,1,%lastClient%) do del /q C:\ABS\TestClient\Logfolder\LoadTest-%DateHour%_%testType%\disco-test-client-%%i\TestRun.log

echo ++--- Load Test Completed Successfully ---++
echo on