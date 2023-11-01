@echo off
set LogFolder=%1
echo Starting Summary for Test: %2
echo ++--- Summary for Test: %2 ---++ >   %LogFolder%\Summary_%2.log
echo Start Date-Time: %StartDateTime% >> %LogFolder%\Summary_%2.log
echo ----------------------------------------------------------------------- >> %LogFolder%\Summary_%2.log
echo. >> %LogFolder%\Summary_%2.log

echo | set /p="Handling files: " >> %LogFolder%\Summary_%2.log
grep -c "Handling file" %LogFolder%\TestRun_%2.log >> %LogFolder%\Summary_%2.log
echo | set /p="    negative TCs: " >> %LogFolder%\Summary_%2.log
grep "Handling file" %LogFolder%\TestRun_%2.log | grep "neg" | wc -l >> %LogFolder%\Summary_%2.log
echo. >> %LogFolder%\Summary_%2.log

echo --- Requests --- >> %LogFolder%\Summary_%2.log
echo | set /p="DiscoCreateScheduleRequests: " >> %LogFolder%\Summary_%2.log
grep -c "Created DiscoCreateScheduleRequest" %LogFolder%\TestRun_%2.log >> %LogFolder%\Summary_%2.log
echo | set /p="DiscoGetSchedulesRequests: " >> %LogFolder%\Summary_%2.log
grep -c "Created DiscoGetSchedulesRequest" %LogFolder%\TestRun_%2.log >> %LogFolder%\Summary_%2.log
echo | set /p="DiscoDeleteScheduleRequests: " >> %LogFolder%\Summary_%2.log
grep -c "Created DiscoDeleteScheduleRequest" %LogFolder%\TestRun_%2.log >> %LogFolder%\Summary_%2.log
echo | set /p="DiscoDataRequests: " >> %LogFolder%\Summary_%2.log
grep -c "Created DiscoDataRequest" %LogFolder%\TestRun_%2.log >> %LogFolder%\Summary_%2.log
echo. >> %LogFolder%\Summary_%2.log

echo --- Responses --- >> %LogFolder%\Summary_%2.log
echo | set /p="DiscoScheduleResponses with scheduleIds: " >> %LogFolder%\Summary_%2.log
grep "DiscoScheduleResponse Received" %LogFolder%\TestRun_%2.log | grep -v "\"scheduleId\": \"\"" | wc -l >> %LogFolder%\Summary_%2.log
echo | set /p="DiscoGetSchedulesResponses with scheduleIds: " >> %LogFolder%\Summary_%2.log
grep "DiscoGetSchedulesResponse Received" %LogFolder%\TestRun_%2.log | grep -v "\"scheduleIds\": \[ \]" | wc -l >> %LogFolder%\Summary_%2.log
echo | set /p="DiscoDataResponses with values: " >> %LogFolder%\Summary_%2.log
grep "DiscoDataResponse Received" %LogFolder%\TestRun_%2.log | grep "value" | wc -l >> %LogFolder%\Summary_%2.log
echo. >> %LogFolder%\Summary_%2.log

echo -- BAD_REQUEST / HARD_LIMIT / Warnings / Errors --- >> %LogFolder%\Summary_%2.log
echo | set /p="TestRun.log BAD_REQUEST|HARD_LIMIT: "  >> %LogFolder%\Summary_%2.log
grep -E -c "BAD_REQUEST|HARD_LIMIT" %LogFolder%\TestRun_%2.log >> %LogFolder%\Summary_%2.log
echo | set /p="TestRun.log Warnings, Errors: " >> %LogFolder%\Summary_%2.log
grep -E "Warning|Error" %LogFolder%\TestRun_%2.log | grep -v -E "BAD_REQUEST|HARD_LIMIT|CleanupTrackedErrors" | grep -E -c "Warning|Error" >> %LogFolder%\Summary_%2.log
echo | set /p="disco-service.log Warnings, Errors: " >> %LogFolder%\Summary_%2.log
grep -E    "Warning|Error|fail:"  %LogFolder%\disco-service_%2.log   | grep -v "CleanupTrackedErrors" | grep -E -c "Warning|Error|fail:" >> %LogFolder%\Summary_%2.log
echo | set /p="siemens-adapter.log Warnings, Errors: " >> %LogFolder%\Summary_%2.log
grep -E    "Warning|Error|fail:"  %LogFolder%\siemens-adapter_%2.log | grep -v "CleanupTrackedErrors" | grep -E -c "Warning|Error|fail:" >> %LogFolder%\Summary_%2.log
echo. >> %LogFolder%\Summary_%2.log
echo ----------------------------------------------------------------------- >> %LogFolder%\Summary_%2.log
echo End Date-Time: %EndDateTime% >> %LogFolder%\Summary_%2.log
