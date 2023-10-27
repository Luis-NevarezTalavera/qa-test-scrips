@echo off
set TestClient=%1
set /a TimeOutSecs=%2*60
echo +++--- Setting Automatic Timeout for Client: %1 to %TimeOutSecs% secs ( %2 minutes ) ---+++
cd C:\ABS\TestClient\LoadTest\

sed -i 's/"CloseAppTimeOutSeconds": 180/"CloseAppTimeOutSeconds": %TimeOutSecs%/g' %TestClient%\ConnectionConfig.json
