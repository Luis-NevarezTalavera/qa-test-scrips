@echo off
set RegressionType=%1
set ClientsQty=%2
set ClientStart=%3
set /a ClientEnd=ClientStart+ClientsQty-1

if %RegressionType%==OnDemand ( set /a timeoutDuration=5*60-ClientsQty ) else set /a timeoutDuration=0
if %RegressionType%==OnDemand ( set /a loops=%4 ) else set /a loops=1

echo  --%RegressionType%--  --OnDemand--
echo +++--- Starting CC-DISCO / Siemens Adapter Load Test ---+++
echo --- This script requires 3 arguments: Request type OnDemand/Schedule: %RegressionType%, TestClients qty: %ClientsQty%, Starting at Client #: %ClientStart%
set StartDateTime=%DATE% %TIME%
echo Start Date-Time: %StartDateTime%
cd C:\ABS\TestClient\LoadTest\
echo --- Creating %ClientsQty% Test Client instances in independent Command Prompt Windows ---

if %RegressionType%==OnDemand ( echo +--- Starting Test Clients %ClientStart% to %ClientEnd%, every 5 minutes, wait time: %timeoutDuration%, loops: %loops% ---+ )
for /l %%i in (1,1,%loops%) do (
    echo Starting %ClientsQty% New Test Clients
    time /t
    for /l %%i in (%ClientStart%,1,%ClientEnd%) do (
        timeout /t 1
        start "test-client-%%i" loadtest-execute_test-client %RegressionType% disco-test-client-%%i
    )
    echo +--- Ctrl + C to end ---+
    timeout /t %timeoutDuration%
)
set /p DateHour=<C:\ABS\TestClient\LoadTest\_temp_DateHour.txt
set EndDateTime=%DATE% %TIME%
echo End Date-Time: %EndDateTime%
echo about to create Grand Summary for LoadTest: %DateHour% %RegressionType%
call loadtest-create_summary.bat LoadTest-%DateHour%_%RegressionType% %ClientsQty%
echo ++--- Load Test Completed Successfully ---++