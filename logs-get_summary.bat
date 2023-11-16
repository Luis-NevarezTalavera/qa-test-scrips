@echo off
set LogFolderLogs=%1
set TestNameLogs=%2
set DateHourLast=%3
echo +++----- Starting Generating Summary for Test: %TestNameLogs% -----+++

echo +++ Looking for Warning or Error log entries in the TestRun.log, CC-DISCO.log and Siemens-Adapter.log files +++
grep -E "Warning|Error|BAD_REQUEST|HARD_LIMIT" %LogFolderLogs%\TestRun_%TestNameLogs%.log         | grep -v  "CleanupTrackedErrors" > %LogFolderLogs%\TestRun_Warnings-Errors.log
grep -E "Warning|Error|warn|fail|crit" C:\ABS\cc-platform\logs\site\disco-service-%DateHourLast%.log   | grep -Ev "CleanupTrackedErrors|is not registered for routing|could not be reached, retrying in" >> %LogFolderLogs%\disco-service_Warnings-Errors.log
grep -E "Warning|Error|warn|fail|crit" C:\ABS\cc-platform\logs\site\siemens-adapter-%DateHourLast%.log | grep -v  "CleanupTrackedErrors" >> %LogFolderLogs%\siemens-adapter_Warnings-Errors.log
echo Errors logged into %LogFolderLogs%\TestRun,disco-service,siemens-adapter _Warnings-Errors.log

echo Counting Requests, Responses and Errors into Summary Report
echo ++--- Summary for Test: %TestNameLogs% ---++ > %LogFolderLogs%\Summary_%TestNameLogs%.log
grep "Start" %LogFolderLogs%\start-end_date-time.log | head -1 >> %LogFolderLogs%\Summary_%TestNameLogs%.log
echo ----------------------------------------------------------------------- >> %LogFolderLogs%\Summary_%TestNameLogs%.log
echo. >> %LogFolderLogs%\Summary_%TestNameLogs%.log

echo | set /p="Handling files: " >> %LogFolderLogs%\Summary_%TestNameLogs%.log
grep -c "Handling file" %LogFolderLogs%\TestRun_%TestNameLogs%.log >> %LogFolderLogs%\Summary_%TestNameLogs%.log
echo | set /p="    negative TCs: " >> %LogFolderLogs%\Summary_%TestNameLogs%.log
grep "Handling file" %LogFolderLogs%\TestRun_%TestNameLogs%.log | grep "neg" | wc -l >> %LogFolderLogs%\Summary_%TestNameLogs%.log
echo. >> %LogFolderLogs%\Summary_%TestNameLogs%.log

echo --- Requests --- >> %LogFolderLogs%\Summary_%TestNameLogs%.log
echo | set /p="DiscoCreateScheduleRequests: " >> %LogFolderLogs%\Summary_%TestNameLogs%.log
grep -c "Created DiscoCreateScheduleRequest" %LogFolderLogs%\TestRun_%TestNameLogs%.log >> %LogFolderLogs%\Summary_%TestNameLogs%.log
echo | set /p="DiscoGetSchedulesRequests: " >> %LogFolderLogs%\Summary_%TestNameLogs%.log
grep -c "Created DiscoGetSchedulesRequest" %LogFolderLogs%\TestRun_%TestNameLogs%.log >> %LogFolderLogs%\Summary_%TestNameLogs%.log
echo | set /p="DiscoDeleteScheduleRequests: " >> %LogFolderLogs%\Summary_%TestNameLogs%.log
grep -c "Created DiscoDeleteScheduleRequest" %LogFolderLogs%\TestRun_%TestNameLogs%.log >> %LogFolderLogs%\Summary_%TestNameLogs%.log
echo | set /p="DiscoDataRequests: " >> %LogFolderLogs%\Summary_%TestNameLogs%.log
grep -c "Created DiscoDataRequest" %LogFolderLogs%\TestRun_%TestNameLogs%.log >> %LogFolderLogs%\Summary_%TestNameLogs%.log
echo. >> %LogFolderLogs%\Summary_%TestNameLogs%.log

echo --- Responses --- >> %LogFolderLogs%\Summary_%TestNameLogs%.log
echo | set /p="DiscoScheduleResponses with scheduleIds: " >> %LogFolderLogs%\Summary_%TestNameLogs%.log
grep "DiscoScheduleResponse Received" %LogFolderLogs%\TestRun_%TestNameLogs%.log | grep -v "\"scheduleId\": \"\"" | wc -l >> %LogFolderLogs%\Summary_%TestNameLogs%.log
echo | set /p="DiscoGetSchedulesResponses with scheduleIds: " >> %LogFolderLogs%\Summary_%TestNameLogs%.log
grep "DiscoGetSchedulesResponse Received" %LogFolderLogs%\TestRun_%TestNameLogs%.log | grep -v "\"scheduleIds\": \[ \]" | wc -l >> %LogFolderLogs%\Summary_%TestNameLogs%.log
echo | set /p="DiscoDataResponses with values: " >> %LogFolderLogs%\Summary_%TestNameLogs%.log
grep "DiscoDataResponse Received" %LogFolderLogs%\TestRun_%TestNameLogs%.log | grep "value" | wc -l >> %LogFolderLogs%\Summary_%TestNameLogs%.log
echo. >> %LogFolderLogs%\Summary_%TestNameLogs%.log

echo -- BAD_REQUEST / HARD_LIMIT / Warnings / Errors --- >> %LogFolderLogs%\Summary_%TestNameLogs%.log
echo | set /p="TestRun.log BAD_REQUEST|HARD_LIMIT: "  >> %LogFolderLogs%\Summary_%TestNameLogs%.log
grep -E -c "BAD_REQUEST|HARD_LIMIT" %LogFolderLogs%\TestRun_Warnings-Errors.log >> %LogFolderLogs%\Summary_%TestNameLogs%.log
echo | set /p="TestRun.log Warnings, Errors: " >> %LogFolderLogs%\Summary_%TestNameLogs%.log
grep -E "Warning|Error" %LogFolderLogs%\TestRun_Warnings-Errors.log | grep -v -E "BAD_REQUEST|HARD_LIMIT" | grep -E -c "Warning|Error" >> %LogFolderLogs%\Summary_%TestNameLogs%.log
echo | set /p="disco-service.log Warnings, Errors: " >> %LogFolderLogs%\Summary_%TestNameLogs%.log
grep -E -c "Warning|Error|warn|fail|crit"  %LogFolderLogs%\disco-service_Warnings-Errors.log   >> %LogFolderLogs%\Summary_%TestNameLogs%.log
echo | set /p="siemens-adapter.log Warnings, Errors: " >> %LogFolderLogs%\Summary_%TestNameLogs%.log
grep -E -c "Warning|Error|warn|fail|crit"  %LogFolderLogs%\siemens-adapter_Warnings-Errors.log >> %LogFolderLogs%\Summary_%TestNameLogs%.log
echo. >> %LogFolderLogs%\Summary_%TestNameLogs%.log
echo ----------------------------------------------------------------------- >> %LogFolderLogs%\Summary_%TestNameLogs%.log
grep "End" %LogFolderLogs%\start-end_date-time.log | tail -1 >> %LogFolderLogs%\Summary_%TestNameLogs%.log
echo Summary for Test: %TestNameLogs% Created Successfully: %LogFolderLogs%\Summary_%TestNameLogs%.log