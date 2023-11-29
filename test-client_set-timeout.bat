@echo off
set TestClient=%1
set TimeOutSecs=%2
cd C:\ABS\TestClient\LoadTest\%TestClient%
grep "CloseAppTimeOutSeconds" ConnectionConfig.json | awk -F '  '  '{print $2}' > CloseAppTimeOutSeconds.txt
set /p CloseAppTimeOutSeconds=<CloseAppTimeOutSeconds.txt
sed -i 's/%CloseAppTimeOutSeconds%/"CloseAppTimeOutSeconds": %TimeOutSecs%,/g' ConnectionConfig.json
echo Replaced %CloseAppTimeOutSeconds% for "CloseAppTimeOutSeconds": %TimeOutSecs%, in ConnectionConfig.json for %TestClient%