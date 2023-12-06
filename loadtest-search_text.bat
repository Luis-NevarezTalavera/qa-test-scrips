@echo off
set loadTestName=%1
set testClientsQty=%2
set logFile=%3
set searchText=%4
cd c:\ABS\TestClient\Logfolder\
echo ++--- Searching for %searchText% in Test Client subfolders of Load Test: %1 ---++

for /l %%i in (1,1,%testClientsQty%) do (
    echo +--- %loadTestName%\disco-test-client-%%i\%logFile%_%loadTestName%_disco-test-client-%%i.log ---+
    grep "%searchText%" %loadTestName%\disco-test-client-%%i\%logFile%_%loadTestName%_disco-test-client-%%i.log | grep -v ": 0"
)