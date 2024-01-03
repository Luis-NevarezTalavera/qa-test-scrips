@echo off
set testName=%1
set LogFolderMain=c:\ABS\TestClient\LogFolder\%testName%
set DateHourLast=%2
set testClient=%3
if %testClient% NEQ disco-test-client (
    echo === LoadTest ===
    set LogFolderSub=c:\ABS\TestClient\LogFolder\%testName%\%testClient%
    set TestNameLogs=%testName%_%testClient%
) else ( 
    echo === Regression/Functional testing ===
    set LogFolderSub=c:\ABS\TestClient\LogFolder\%testName%
    set TestNameLogs=%testName%
)
echo +++----- Starting Generating Summary for Test: %TestNameLogs% -----+++

echo +++ Looking for Warning or Error log entries in the TestRun.log, Disco-service.log and Siemens-adapter.log +++
echo Logging TestRun.log Errors into %LogFolderSub%\TestRun_Warnings-Errors.log
grep -E "Warning|Error|BAD_REQUEST|HARD_LIMIT|error|Exception" %LogFolderSub%\TestRun.log  | grep -v  "CleanupTrackedErrors" > %LogFolderSub%\TestRun_Warnings-Errors.log
echo Logging disco-service.log Errors into %LogFolderMain%\disco-service_%DateHourLast%_Warnings-Errors.log
grep -E "Warning|Error|warn|fail|crit"  %LogFolderMain%\disco-service_%TestNameLogs%.log > %LogFolderMain%\disco-service_%DateHourLast%_Warnings-Errors.log
echo Logging siemens-adapter.log Errors into %LogFolderMain%\siemens-adapter_%DateHourLast%_Warnings-Errors.log
grep -E "Warning|Error|warn|fail|crit"  %LogFolderMain%\siemens-adapter_%TestNameLogs%.log > %LogFolderMain%\siemens-adapter_%DateHourLast%_Warnings-Errors.log

echo Counting Requests, Responses and Errors into Summary Report
echo ++--- Summary for Test:	%TestNameLogs%	---++ > %LogFolderSub%\Summary_%TestNameLogs%.log
grep "Start" %LogFolderSub%\start-end_date-time.log | head -1 >> %LogFolderSub%\Summary_%TestNameLogs%.log
echo ----------------------------------------------------------------------- >> %LogFolderSub%\Summary_%TestNameLogs%.log

echo | set /p="Handling files:	" >> %LogFolderSub%\Summary_%TestNameLogs%.log
grep "Handling file" %LogFolderSub%\TestRun.log | wc -l >> %LogFolderSub%\Summary_%TestNameLogs%.log
echo | set /p="    negative TCs:	" >> %LogFolderSub%\Summary_%TestNameLogs%.log
grep "Handling file" %LogFolderSub%\TestRun.log | grep "neg" | wc -l >> %LogFolderSub%\Summary_%TestNameLogs%.log

echo --- Requests --- >> %LogFolderSub%\Summary_%TestNameLogs%.log
echo | set /p="DiscoCreateScheduleRequests:	" >> %LogFolderSub%\Summary_%TestNameLogs%.log
grep "Created DiscoCreateScheduleRequest" %LogFolderSub%\TestRun.log | wc -l >> %LogFolderSub%\Summary_%TestNameLogs%.log
echo | set /p="DiscoGetSchedulesRequests:	" >> %LogFolderSub%\Summary_%TestNameLogs%.log
grep "Created DiscoGetSchedulesRequest" %LogFolderSub%\TestRun.log | wc -l >> %LogFolderSub%\Summary_%TestNameLogs%.log
echo | set /p="DiscoDeleteScheduleRequests:	" >> %LogFolderSub%\Summary_%TestNameLogs%.log
grep "Created DiscoDeleteScheduleRequest" %LogFolderSub%\TestRun.log | wc -l >> %LogFolderSub%\Summary_%TestNameLogs%.log
echo | set /p="DiscoDataRequests:	" >> %LogFolderSub%\Summary_%TestNameLogs%.log
grep "Created DiscoDataRequest" %LogFolderSub%\TestRun.log | wc -l >> %LogFolderSub%\Summary_%TestNameLogs%.log

echo --- Responses --- >> %LogFolderSub%\Summary_%TestNameLogs%.log
echo | set /p="DiscoScheduleResponses with scheduleIds:	" >> %LogFolderSub%\Summary_%TestNameLogs%.log
grep "DiscoScheduleResponse Received" %LogFolderSub%\TestRun.log | grep -v "\"scheduleId\": \"\"" | wc -l >> %LogFolderSub%\Summary_%TestNameLogs%.log
echo | set /p="DiscoGetSchedulesResponses with scheduleIds:	" >> %LogFolderSub%\Summary_%TestNameLogs%.log
grep "DiscoGetSchedulesResponse Received" %LogFolderSub%\TestRun.log | grep -v "\"scheduleIds\": \[ \]" | wc -l >> %LogFolderSub%\Summary_%TestNameLogs%.log
echo | set /p="DiscoDataResponses with values:	" >> %LogFolderSub%\Summary_%TestNameLogs%.log
grep "DiscoDataResponse Received" %LogFolderSub%\TestRun.log | grep "value" | wc -l >> %LogFolderSub%\Summary_%TestNameLogs%.log

echo -- BAD_REQUEST / HARD_LIMIT / Warnings / Errors --- >> %LogFolderSub%\Summary_%TestNameLogs%.log
echo | set /p="TestRun.log BAD_REQUEST|HARD_LIMIT:	" >> %LogFolderSub%\Summary_%TestNameLogs%.log
grep -E -c "BAD_REQUEST|HARD_LIMIT" %LogFolderSub%\TestRun_Warnings-Errors.log >> %LogFolderSub%\Summary_%TestNameLogs%.log
echo | set /p="TestRun.log Warnings, Errors:	" >> %LogFolderSub%\Summary_%TestNameLogs%.log
grep -Ev -c "BAD_REQUEST|HARD_LIMIT" %LogFolderSub%\TestRun_Warnings-Errors.log >> %LogFolderSub%\Summary_%TestNameLogs%.log
echo | set /p="disco-service.log Warnings, Errors:	" >> %LogFolderSub%\Summary_%TestNameLogs%.log
grep -E -c "Warning|Error|warn|fail|crit"  %LogFolderMain%\disco-service_%DateHourLast%_Warnings-Errors.log   >> %LogFolderSub%\Summary_%TestNameLogs%.log
echo | set /p="siemens-adapter.log Warnings, Errors:	" >> %LogFolderSub%\Summary_%TestNameLogs%.log
grep -E -c "Warning|Error|warn|fail|crit"  %LogFolderMain%\siemens-adapter_%DateHourLast%_Warnings-Errors.log >> %LogFolderSub%\Summary_%TestNameLogs%.log

echo ----------------------------------------------------------------------- >> %LogFolderSub%\Summary_%TestNameLogs%.log
grep "End" %LogFolderSub%\start-end_date-time.log | tail -1 >> %LogFolderSub%\Summary_%TestNameLogs%.log
echo Summary for Test: %TestNameLogs% Created Successfully: %LogFolderSub%\Summary_%TestNameLogs%.log