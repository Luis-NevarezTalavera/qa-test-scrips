@echo off
set TestName=%1
set clientsQty=%2
set LogFolder=C:\ABS\TestClient\LogFolder\%TestName%
cd %LogFolder%

goto FinalReport
::for /l %%j in (22,1,%Hours%) do (
    
    set Hours=22

    set /p LatestDateHour=<C:\ABS\TestClient\LoadTest\_temp_latest_DateHour.txt
    echo Re-creating Error logs, Summaries for %clientsQty% Test Clients, Loop: %%j of Total Loops: %Hours%
    for /l %%i in (%startClient%,1,%lastClient%) do (
        echo re-creating error logs, summaries for disco-test-client-%%i
        call logs-get_summary.bat %LogFolder%\disco-test-client-%%i %TestName%_disco-test-client-%%i 2023-11-07_22
    )

::)

:FinalReport

echo ++--- Creating Summary Report:	%TestName% with Clients qty: %clientsQty% ---++
echo ++---------------------------------------------------------------------------------------------++
echo '++--- Grand Summary Report for LoadTest:	%TestName% with Clients qty: %clientsQty%	---++ > %TestName%.log

for /l %%i in (1,1,%ClientsQty%) do (
    echo +++--- disco-test-client-%%i ---+++
    echo copying %LogFolder%\disco-test-client-%%i\Summary_%TestName%_disco-test-client-%%i.log into %TestName%.log
    type %LogFolder%\disco-test-client-%%i\Summary_%TestName%_disco-test-client-%%i.log >> %TestName%.log 
)

cd C:\ABS\TestClient\LogFolder