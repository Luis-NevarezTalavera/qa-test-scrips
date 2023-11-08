echo off
echo +++--- Creating Test Clients qty: %1, Starting from: %2 ---+++
cd C:\ABS\TestClient\LoadTest\
set startClient=%2
set clientsQty=%1
set /a endClient=startClient+clientsQty

echo Creating test-client-xx folders, qty: %1\
for /l %%i in (%startClient%,1,%endClient%) do ( mkdir disco-test-client-%%i )

echo Populating requests
for /l %%i in (%startClient%,1,%endClient%) do ( loadtest-populate_test-client-folder.bat disco-test-client-%%i )

echo Copying CC-Disco Configs (Creating Exchanges, Queues)
for /l %%i in (%startClient%,1,%endClient%) do ( copy_cc-disco-configs.bat disco-test-client-%%i )