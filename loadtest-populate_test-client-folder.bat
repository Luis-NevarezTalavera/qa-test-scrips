@echo off
echo +++--- Duplicating Requests for Client: %1 ---+++
cd C:\ABS\TestClient\LoadTest\

echo Copying CC-Disco Config Files
xcopy /f /q /v /y disco-test-client\siemens-config.json %1\
xcopy /f /q /v /y disco-test-client\ConnectionConfig.json %1\
echo F|xcopy /f /q /v /y disco-test-client\disco-test-client-config.json %1\%1-config.json
cd %1
sed -i 's/disco-test-client/%1/g' *.json
sed -i 's/Username\": \"%1/Username\": \"disco-test-client/g' ConnectionConfig.json
sed -i 's/Password\": \"%1/Password\": \"disco-test-client/g' ConnectionConfig.json
cd ..
dir /b test-client\*. > test-client\requestfolders.txt
for /f %%i in (disco-test-client\requestfolders.txt) do loadtest-create_request-folder.bat %1 %%i