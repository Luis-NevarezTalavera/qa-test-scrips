echo off
cd C:\ABS\TestClient\LogFolder-%1-%2\
echo Starting Summary for Test: %1-%2
echo ++--- Summary for Test: %1-%2 ---++ >   Summary_%1-%2.log
grep "Start Date-Time:" TestRun-%1-%2.log >> Summary_%1-%2.log
echo ----------------------------------------------------------------------- >> Summary_%1-%2.log
echo. >> Summary_%1-%2.log

echo | set /p="Handling files: " >> Summary_%1-%2.log
grep -c "Handling file" TestRun-%1-%2.log >> Summary_%1-%2.log
echo. >> Summary_%1-%2.log

echo --- Requests --- >> Summary_%1-%2.log
echo | set /p="DiscoCreateScheduleRequests: " >> Summary_%1-%2.log
grep -c "Created DiscoCreateScheduleRequest" TestRun-%1-%2.log >> Summary_%1-%2.log
echo | set /p="DiscoGetSchedulesRequests: " >> Summary_%1-%2.log
grep -c "Created DiscoGetSchedulesRequest" TestRun-%1-%2.log >> Summary_%1-%2.log
echo | set /p="DiscoDataRequests: " >> Summary_%1-%2.log
grep -c "Created DiscoDataRequest" TestRun-%1-%2.log >> Summary_%1-%2.log
echo. >> Summary_%1-%2.log

echo --- Responses --- >> Summary_%1-%2.log
echo | set /p="DiscoScheduleResponses: " >> Summary_%1-%2.log
grep -c "DiscoScheduleResponse Received" TestRun-%1-%2.log >> Summary_%1-%2.log
echo | set /p="DiscoGetSchedulesResponses: " >> Summary_%1-%2.log
grep -c "DiscoGetSchedulesResponse Received" TestRun-%1-%2.log >> Summary_%1-%2.log
echo | set /p="DiscoDataResponses: " >> Summary_%1-%2.log
grep -c "DiscoDataResponse Received" TestRun-%1-%2.log >> Summary_%1-%2.log
echo. >> Summary_%1-%2.log

echo -- BAD_REQUESTs / Warnings / Errors --- >> Summary_%1-%2.log
echo | set /p="TestRun.log BAD_REQUEST: "  >> Summary_%1-%2.log
grep -E -c "BAD_REQUEST" TestRun-%1-%2.log >> Summary_%1-%2.log
echo | set /p="TestRun.log Warnings, Errors: " >> Summary_%1-%2.log
grep -E "Warning|Error" TestRun-%1-%2.log     | grep -v -E "BAD_REQUEST|CleanupTrackedErrors" | grep -E -c "Warning|Error" >> Summary_%1-%2.log
echo | set /p="disco-service.log Warnings, Errors: " >> Summary_%1-%2.log
grep -E    "Warning|Error"  disco-service*.log   | grep -v "CleanupTrackedErrors" | grep -E -c "Warning|Error" >> Summary_%1-%2.log
echo | set /p="siemens-adapter.log Warnings, Errors: " >> Summary_%1-%2.log
grep -E    "Warning|Error"  siemens-adapter*.log | grep -v "CleanupTrackedErrors" | grep -E -c "Warning|Error" >> Summary_%1-%2.log
echo. >> Summary_%1-%2.log
echo ----------------------------------------------------------------------- >> Summary_%1-%2.log
echo End Date-Time: %EndDateTime% >> Summary_%1-%2.log
cd ..
