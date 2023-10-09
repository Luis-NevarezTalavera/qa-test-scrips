@echo off
echo +++--- Duplicating Requests for Client: %1 ---+++
cd C:\ABS\TestClient\LoadTest\

echo Copying CC-Disco Config Files
xcopy /f /q /v /y test-client\siemens-config.json %1\
xcopy /f /q /v /y test-client\ConnectionConfig.json %1\
echo F|xcopy /f /q /v /y test-client\test-client-config.json %1\%1-config.json
cd %1
sed -i 's/test-client/%1/g' *.json
cd ..

echo Creating OnDemand Request folder for %1
mkdir %1\OnDemand
xcopy /q /v /y test-client\OnDemand\*.json C:\ABS\TestClient\LoadTest\%1\OnDemand\
echo replacing "test-client" for "%1" in OnDemand Json Requests
cd %1\OnDemand\
for %%i in (OnDemand*.json) do ren %%i %1_%%i
sed -i 's/test-client/%1/g' *.json
cd C:\ABS\TestClient\LoadTest\

echo Creating Schedule Request folder for %1
mkdir %1\Schedule
xcopy /q /v /y test-client\Schedule\*.json C:\ABS\TestClient\LoadTest\%1\Schedule\
echo replacing "test-client" for "%1" in OnDemand Json Requests
cd %1\Schedule\
for %%i in (Schedule*.json) do ren %%i %1_%%i
sed -i 's/test-client/%1/g' *.json
cd C:\ABS\TestClient\LoadTest\