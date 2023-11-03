@echo off
set LogFolder=C:\ABS\TestClient\LogFolder\%1
cd %LogFolder%
echo ++--- Creating Summary Report: %1 with Clients qty: %2 ---++
echo ++---------------------------------------------------------------------------------------------++
echo ++--- Grand Summary Report for LoadTest: %1 with Clients qty: %2 ---++ > %1.log
for /l %%i in (1,1,%2) do (
    echo +++--- disco-test-client-%%i ---+++ >> %LogFolder%\%1.log
    echo +++--- disco-test-client-%%i ---+++
    type  %LogFolder%\disco-test-client-%%i\Summary_%1_disco-test-client-%%i.log >> %1.log 
)
cd C:\ABS\TestClient\LogFolder