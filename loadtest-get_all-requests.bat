@echo off
set loadTestName=%1
set testClientsQty=%2
set NL=␊
cd c:\ABS\TestClient\Logfolder\%loadTestName%
echo +++--- Searching for All Responses in Test Client subfolders of Load Test: %loadTestName% ---+++

echo +++--- DiscoCreateScheduleRequests ---+++
echo +++--- %loadTestName% ---+++ > DiscoCreateScheduleRequests_%loadTestName%.log
for /l %%i in (1,1,%testClientsQty%) do (
    call logs-get_schedule-requests.bat c:\ABS\TestClient\Logfolder\%loadTestName%\disco-test-client-%%i\TestRun_%loadTestName%_disco-test-client-%%i.log %loadTestName%
)
echo +++--- Formating DiscoCreateScheduleRequests_%loadTestName%.log for Analysis in Excel ---+++
sed -i "s/		//g" DiscoCreateScheduleRequests_%loadTestName%.log
sed -i "/^	/d" DiscoCreateScheduleRequests_%loadTestName%.log

echo +++--- DiscoScheduleResponses ---+++
echo +++--- %loadTestName% ---+++ > DiscoScheduleResponses_%loadTestName%.log
for /l %%i in (1,1,%testClientsQty%) do (
    call logs-get_schedule-responses.bat c:\ABS\TestClient\Logfolder\%loadTestName%\disco-test-client-%%i\TestRun_%loadTestName%_disco-test-client-%%i.log %loadTestName%
)
echo +++--- Formating DiscoScheduleResponses_%loadTestName%.log for Analysis in Excel ---+++
sed -i "s/T/	/g" DiscoScheduleResponses_%loadTestName%.log
sed -i 's/Z"//g' DiscoScheduleResponses_%loadTestName%.log
sed -i 's/"202/202/g' DiscoScheduleResponses_%loadTestName%.log

echo +++--- DiscoDataRequests ---+++
echo +++--- %loadTestName% ---+++ > DiscoDataRequests_%loadTestName%.log
for /l %%i in (1,1,%testClientsQty%) do (
    call logs-get_data-requests.bat c:\ABS\TestClient\Logfolder\%loadTestName%\disco-test-client-%%i\TestRun_%loadTestName%_disco-test-client-%%i.log %loadTestName%
)

echo +++--- DiscoDataResponses ---+++
echo +++--- %loadTestName% ---+++ > DiscoDataResponses_%loadTestName%.log
for /l %%i in (1,1,%testClientsQty%) do (
    call logs-get_data-responses.bat c:\ABS\TestClient\Logfolder\%loadTestName%\disco-test-client-%%i\TestRun_%loadTestName%_disco-test-client-%%i.log %loadTestName%
)
echo +++--- Formating DiscoDataResponses_%loadTestName%.log for Analysis in Excel ---+++
sed -i "s/T/	/g" DiscoDataResponses_%loadTestName%.log
sed -i 's/Z",//g' DiscoDataResponses_%loadTestName%.log
sed -i 's/"202/202/g' DiscoDataResponses_%loadTestName%.log
