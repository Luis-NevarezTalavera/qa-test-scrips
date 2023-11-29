@echo off
set LogFolder=%1
set TestNameLogs=%2
set DateHourLast=%3
echo +++----- Starting Generating Summary for Test: %TestNameLogs% -----+++

echo +++ Looking for Warning or Error log entries in the TestRun.log, CC-DISCO.log and Siemens-Adapter.log files +++
grep -E "Warning|Error|BAD_REQUEST|HARD_LIMIT|error|Exception" %LogFolder%\TestRun_%TestNameLogs%.log  | grep -v  "CleanupTrackedErrors" > %LogFolder%\TestRun_Warnings-Errors.log
grep -E "Warning|Error|warn|fail|crit" C:\ABS\cc-platform\logs\site\disco-service-%DateHourLast%.log   | grep -Ev "CleanupTrackedErrors|Could not establish connection|is not registered for routing|could not be reached, retrying in" >> %LogFolder%\disco-service_Warnings-Errors.log
grep -E "Warning|Error|warn|fail|crit" C:\ABS\cc-platform\logs\site\siemens-adapter-%DateHourLast%.log | grep -Ev "CleanupTrackedErrors|token" >> %LogFolder%\siemens-adapter_Warnings-Errors.log
echo Errors logged into %LogFolder%\TestRun,disco-service,siemens-adapter _Warnings-Errors.log

echo Counting Requests, Responses and Errors into Summary Report
echo ++--- Summary for Test:	%TestNameLogs%	---++ > %LogFolder%\Summary_%TestNameLogs%.log
grep "Start" %LogFolder%\start-end_date-time.log | head -1 >> %LogFolder%\Summary_%TestNameLogs%.log
echo ----------------------------------------------------------------------- >> %LogFolder%\Summary_%TestNameLogs%.log

echo | set /p="Handling files:	" >> %LogFolder%\Summary_%TestNameLogs%.log
grep -c "Handling file" %LogFolder%\TestRun_%TestNameLogs%.log >> %LogFolder%\Summary_%TestNameLogs%.log
echo | set /p="    negative TCs:	" >> %LogFolder%\Summary_%TestNameLogs%.log
grep "Handling file" %LogFolder%\TestRun_%TestNameLogs%.log | grep "neg" | wc -l >> %LogFolder%\Summary_%TestNameLogs%.log

echo --- Requests --- >> %LogFolder%\Summary_%TestNameLogs%.log
echo | set /p="DiscoCreateScheduleRequests:	" >> %LogFolder%\Summary_%TestNameLogs%.log
grep -c "Created DiscoCreateScheduleRequest" %LogFolder%\TestRun_%TestNameLogs%.log >> %LogFolder%\Summary_%TestNameLogs%.log
echo | set /p="DiscoGetSchedulesRequests:	" >> %LogFolder%\Summary_%TestNameLogs%.log
grep -c "Created DiscoGetSchedulesRequest" %LogFolder%\TestRun_%TestNameLogs%.log >> %LogFolder%\Summary_%TestNameLogs%.log
echo | set /p="DiscoDeleteScheduleRequests:	" >> %LogFolder%\Summary_%TestNameLogs%.log
grep -c "Created DiscoDeleteScheduleRequest" %LogFolder%\TestRun_%TestNameLogs%.log >> %LogFolder%\Summary_%TestNameLogs%.log
echo | set /p="DiscoDataRequests:	" >> %LogFolder%\Summary_%TestNameLogs%.log
grep -c "Created DiscoDataRequest" %LogFolder%\TestRun_%TestNameLogs%.log >> %LogFolder%\Summary_%TestNameLogs%.log

echo --- Responses --- >> %LogFolder%\Summary_%TestNameLogs%.log
echo | set /p="DiscoScheduleResponses with scheduleIds:	" >> %LogFolder%\Summary_%TestNameLogs%.log
grep "DiscoScheduleResponse Received" %LogFolder%\TestRun_%TestNameLogs%.log | grep -v "\"scheduleId\": \"\"" | wc -l >> %LogFolder%\Summary_%TestNameLogs%.log
echo | set /p="DiscoGetSchedulesResponses with scheduleIds:	" >> %LogFolder%\Summary_%TestNameLogs%.log
grep "DiscoGetSchedulesResponse Received" %LogFolder%\TestRun_%TestNameLogs%.log | grep -v "\"scheduleIds\": \[ \]" | wc -l >> %LogFolder%\Summary_%TestNameLogs%.log
echo | set /p="DiscoDataResponses with values:	" >> %LogFolder%\Summary_%TestNameLogs%.log
grep "DiscoDataResponse Received" %LogFolder%\TestRun_%TestNameLogs%.log | grep "value" | wc -l >> %LogFolder%\Summary_%TestNameLogs%.log

echo -- BAD_REQUEST / HARD_LIMIT / Warnings / Errors --- >> %LogFolder%\Summary_%TestNameLogs%.log
echo | set /p="TestRun.log BAD_REQUEST|HARD_LIMIT:	" >> %LogFolder%\Summary_%TestNameLogs%.log
grep -E -c "BAD_REQUEST|HARD_LIMIT" %LogFolder%\TestRun_Warnings-Errors.log >> %LogFolder%\Summary_%TestNameLogs%.log
echo | set /p="TestRun.log Warnings, Errors:	" >> %LogFolder%\Summary_%TestNameLogs%.log
grep -Ev -c "BAD_REQUEST|HARD_LIMIT" %LogFolder%\TestRun_Warnings-Errors.log >> %LogFolder%\Summary_%TestNameLogs%.log
echo | set /p="disco-service.log Warnings, Errors:	" >> %LogFolder%\Summary_%TestNameLogs%.log
grep -E -c "Warning|Error|warn|fail|crit"  %LogFolder%\disco-service_Warnings-Errors.log   >> %LogFolder%\Summary_%TestNameLogs%.log
echo | set /p="siemens-adapter.log Warnings, Errors:	" >> %LogFolder%\Summary_%TestNameLogs%.log
grep -E -c "Warning|Error|warn|fail|crit"  %LogFolder%\siemens-adapter_Warnings-Errors.log >> %LogFolder%\Summary_%TestNameLogs%.log
echo. >> %LogFolder%\Summary_%TestNameLogs%.log
echo ----------------------------------------------------------------------- >> %LogFolder%\Summary_%TestNameLogs%.log
grep "End" %LogFolder%\start-end_date-time.log | tail -1 >> %LogFolder%\Summary_%TestNameLogs%.log
echo Summary for Test: %TestNameLogs% Created Successfully: %LogFolder%\Summary_%TestNameLogs%.log