@echo off
set loadTestName=%1
set logFile=%2
set searchText=%3
cd c:\ABS\TestClient\Logfolder\
echo ++--- Searching for %searchText% in Test Client subfolders of Load Test: %1 ---++

for /l %%i in (1,1,15) do (
    echo +--- %loadTestName%\disco-test-client-%%i\%logFile%_%loadTestName%_disco-test-client-%%i.log ---+
    grep "%searchText%" %loadTestName%\disco-test-client-%%i\%logFile%_%loadTestName%_disco-test-client-%%i.log | grep -v ": 0"
)