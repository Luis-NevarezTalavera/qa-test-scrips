@echo off
set LogFolder=%1
cd %LogFolder%
echo ++--- Creating Summary Report for LoadTest: %1 with Clients qty: %2 ---++
for /l %%i in (1,1,%3) do (
    echo +++--- disco-test-client-%%i ---+++ >> %LogFolder%\%1.log
    timeout /t 1
    type  %LogFolder%\disco-test-client-%%i\%1_disco-test-client-%%i.log >> %1.log 
    timeout /t 2
)