@echo off
echo +++--- Duplicating Requests for Client: %1 ---+++
cd C:\ABS\TestClient\TestClientRequests\LoadTest\

echo Copying CC-Disco Config Files
xcopy /f /q /v /y test-client\*.json %1\
cd %1
sed -i 's/test-client/%1/g' *.json

echo Creating OnDemand Request folder for %1
mkdir %1\OnDemand
xcopy /q /v /y test-client\OnDemand\*.json C:\ABS\TestClient\TestClientRequests\LoadTest\%1\OnDemand\
echo replacing "test-client" for "%1" in Json Requests
cd %1\OnDemand\
for %%i in (OnDemand*.json) do ren %%i %1_%%i
sed -i 's/test-client/%1/g' *.json
cd C:\ABS\TestClient\TestClientRequests\LoadTest\

echo Creating Schedule Request folder for %1
mkdir %1\Schedule
xcopy /q /v /y test-client\Schedule\*.json C:\ABS\TestClient\TestClientRequests\LoadTest\%1\Schedule\
cd %1\Schedule\
for %%i in (Schedule*.json) do ren %%i %1_%%i
sed -i 's/test-client/%1/g' *.json
cd C:\ABS\TestClient\TestClientRequests\LoadTest\