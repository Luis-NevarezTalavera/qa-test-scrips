@echo off
set LogFolder=C:\ABS\TestClient\LogFolder\%1
cd %LogFolder%
echo ++--- Creating Summary Report for LoadTest: %1 with Clients qty: %2 ---++
echo ++--- Grand Summary Report for LoadTest: %1 with Clients qty: %2 ---++ > %1.log
for /l %%i in (1,1,%2) do (
    echo +++--- disco-test-client-%%i ---+++ >> %LogFolder%\%1.log
    type  %LogFolder%\disco-test-client-%%i\Summary_%1_disco-test-client-%%i.log >> %1.log 
    timeout /t 1
)