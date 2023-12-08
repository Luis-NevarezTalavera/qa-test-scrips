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
set waitLastLoop=0
set loops=1

if %testType%==OnDemand (
    set /a "loops=testDurationMns/cycleDurationMns"
    set /a "waitForNextLoop=(cycleDurationMns*60)-(clientsQty*20/10)"
    set /a "waitLastLoop=(cycleDurationMns*2)*60"
    set /a "testClientTimeout=(cycleDurationMns*60)-15"
    ) else (
    set loops=1
    set waitForNextLoop=0
    set /a "testClientTimeout=(testDurationMns+3)*60"
    set /a "waitLastLoop=(testDurationMns+4)*60"
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
echo echo|set /p="-- setting timeout for disco-test-client: "
for /l %%i in (%startClient%,1,%lastClient%) do (
    echo|set /p="%%i "
    call test-client_set-timeout disco-test-client-%%i %testClientTimeout%
)

cd C:\ABS\TestClient\LoadTest\
echo +--- Creating %clientsQty% Test Client instances in independent Command Prompt Windows ---+

if %testType%==OnDemand echo +--- Starting Test Clients %startClient% to %lastClient%, every 5 minutes, wait time: %waitForNextLoop%, loops: %loops% ---+
for /l %%j in (1,1,%loops%) do (

    :: Setting Clients timeout longer for the last Loop, in order to catch the last Responses
    if %testType%==OnDemand (
        if %%j EQU %loops% (
            set /a "testClientTimeout=waitLastLoop-30"
            for /l %%i in (%startClient%,1,%lastClient%) do call test-client_set-timeout disco-test-client-%%i %testClientTimeout%
        )
    )
        
    echo +--- Starting %clientsQty% New Test Clients every %cycleDurationMns% mns, Loop: %%j of Total Loops: %loops% ---+
    call date-time.bat
    set DateHourLastClient=%mydate%_%mytimehh%
    echo echo|set /p="-- starting disco-test-client: "
    for /l %%i in (%startClient%,1,%lastClient%) do (
        timeout /t 1 > NUL
        echo|set /p="%%i "
        start "test-client-%%i %%j" loadtest-execute_test-client %testType% disco-test-client-%%i %%j
    )
    echo --

    echo +--- Waiting %waitForNextLoop% secs for next batch of TestClients, %waitLastLoop% secs after the last batch, Loop: %%j of Total Loops: %loops% ... Ctrl+C to end ---+
    call date-time.bat
    if %%j LSS %loops% (
        timeout /t %waitForNextLoop% /nobreak
    ) else (
        timeout /t %waitLastLoop% 
    )
)

:: Clearing RabbitMQ DREX errors queue
cd C:\ABS\TestClient\LoadTest\
call rabbitmq-read_drex-errors.bat 200 after-LoadTest

set EndDateTime=%DATE% %TIME%
echo End Date-Time: %EndDateTime%
echo About to create Grand Summary for LoadTest: %DateHour% %testType%, press any key when All Individual Summaries are created

cd C:\ABS\TestClient\LogFolder
call loadtest-create_summary.bat LoadTest-%DateHour%_%testType% %clientsQty%

echo ++--- Load Test Completed Successfully ---++
echo on