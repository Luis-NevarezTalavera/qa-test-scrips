echo off
set /a LastClient=%1+%2
echo +++--- Creating Disco Test Clients queues qty: %1 starting at Test Client # %2 ---+++
cd C:\ABS\TestClient\LoadTest\

echo Copying CC-Disco Configs (Creating Exchanges, Queues)
for /l %%i in (%2,1,%LastClient%) do copy_cc-disco-configs.bat disco-test-client-%%i