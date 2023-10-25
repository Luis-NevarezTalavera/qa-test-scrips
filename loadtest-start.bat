echo off
set RegressionType=%1
set ClientsQty=%2
set ClientStart=%3
set /a ClientEnd=ClientStart+ClientsQty-1
echo +++--- Starting CC-DISCO / Siemens Adapter Load Test ---+++
echo --- This script requires 3 arguments: Request type OnDemand/Schedule: %RegressionType% and TestClients qty: %ClientsQty%  Start Client: %ClientStart%  Last Client: %ClieClientEndntStart%
set StartDateTime=%DATE% %TIME%
echo Start Date-Time: %StartDateTime%
cd C:\ABS\TestClient\LoadTest\
echo --- Creating %ClientsQty% Test Client instances in independent Command Prompt Windows ---
for /l %%i in (%ClientStart%,1,%ClientEnd%) do timeout /t 1 | start "test-client-%%i" loadtest-execute_test-client %RegressionType% disco-test-client-%%i
set /p DateHour=<C:\ABS\TestClient\LoadTest\_temp_DateHour.txt
echo Pausing for TestClients to Complete ...
pause
set EndDateTime=%DATE% %TIME%
echo End Date-Time: %EndDateTime%
echo about to Get Summaries for LoadTest: %DateHour% %RegressionType%
for /l %%i in (%ClientStart%,1,%ClientEnd%) do logs_check-errors.bat c:\ABS\TestClient\LogFolder\LoadTest-%DateHour%_%RegressionType%\disco-test-client-%%i LoadTest-%DateHour%_%RegressionType%_disco-test-client-%%i
for /l %%i in (%ClientStart%,1,%ClientEnd%) do logs_get-summary.bat  c:\ABS\TestClient\LogFolder\LoadTest-%DateHour%_%RegressionType%\disco-test-client-%%i LoadTest-%DateHour%_%RegressionType%_disco-test-client-%%i
loadtest-create-summary.bat LoadTest-%DateHour%_%1 %2
