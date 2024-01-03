@echo off
set TestName=%1
set clientsQty=%2
set testDate=%3
set startHour=%4
set endHour=%5
set LogFolder=C:\ABS\TestClient\LogFolder\%TestName%
cd %LogFolder%

for /l %%j in (%startHour%,1,%endHour%) do (

    for /l %%i in (1,1,%clientsQty%) do (
        echo re-creating error logs, summaries for disco-test-client-%%i %testDate%_%%j
        call logs-get_summary.bat %TestName% %testDate%_%%j disco-test-client-%%i
    )

)

echo ++--- Creating Summary Report:	%TestName% with Clients qty: %clientsQty% ---++
echo ++---------------------------------------------------------------------------------------------++
echo +++--- Grand Summary Report for LoadTest:	%TestName% with Clients qty: %clientsQty%	---++ > Grand-Summary_%TestName%.log

for /l %%i in (1,1,%ClientsQty%) do (
    echo +++--- disco-test-client-%%i ---+++
    echo copying %LogFolder%\disco-test-client-%%i\Summary_%TestName%_disco-test-client-%%i.log into Grand-Summary_%TestName%.log
::    rename %LogFolder%\disco-test-client-%%i\TestRun.log TestRun_%TestName%_disco-test-client-%%i.log
    type %LogFolder%\disco-test-client-%%i\Summary_%TestName%_disco-test-client-%%i.log >> Grand-Summary_%TestName%.log
)

cd C:\ABS\TestClient\LogFolder