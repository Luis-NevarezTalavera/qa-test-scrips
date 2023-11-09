echo off
set clientsQty=%1
set startClient=%2
set /a "LastClient=clientsQty+startClient-1"
echo +++--- Creating Disco Test Clients queues qty: %clientsQty% starting at Test Client # %startClient% ---+++
cd C:\ABS\TestClient\LoadTest\

echo Copying CC-Disco Configs (Creating Exchanges, Queues)
for /l %%i in (%startClient%,1,%LastClient%) do copy_cc-disco-configs.bat disco-test-client-%%i