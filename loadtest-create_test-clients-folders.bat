@echo off
echo +++--- Creating Test Clients qty: %1 ---+++
cd C:\ABS\TestClient\TestClientRequests\LoadTest\

echo Creating test-client-xx folders, qty: %1\
for /l %%i in (1,1,%1) do mkdir test-client-%%i

echo Populating requests
for /l %%i in (1,1,%1) do loadtest-create_request-folder.bat test-client-%%i