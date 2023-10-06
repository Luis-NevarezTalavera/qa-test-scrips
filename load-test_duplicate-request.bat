@echo off
echo +++--- Duplicating Requests for Client: %1 Folder: %2 ---+++
cd C:\ABS\TestClient\TestClientRequests\LoadTest\
echo Creating folder %1\%2
mkdir %1
mkdir %1\%2
cd test-client\%2\
xcopy /q /v /y *.json C:\ABS\TestClient\TestClientRequests\LoadTest\%1\%2\
cd C:\ABS\TestClient\TestClientRequests\LoadTest\%1\%2\
echo replacing "test-client" for "%1" in Json Requests
for %%i in (%2*.json) do ren %%i %1-%%i
sed -i 's/test-client/%1/g' *.json
cd C:\ABS\TestClient\TestClientRequests\LoadTest\