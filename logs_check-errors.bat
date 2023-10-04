@echo off
cd C:\ABS\TestClient\LogFolder-%1-%2\
echo Looking for Warning or Error log entries in the CC-DISCO.log and Siemens-Adapter.log files
echo +++ TestRun-%1-%2 +++ 1>  Warnings-Errors.log
echo Start Date-Time: %StartDateTime%  >> Warnings-Errors.log
echo ----------------------------------------------------------------------- >> Warnings-Errors.log 
echo. >> Warnings-Errors.log
grep -E "Warning|Error|BAD_REQUEST" TestRun-%1-%2.log    | grep -v "CleanupTrackedErrors" >> Warnings-Errors.log
echo +++ disco-service +++ 1>>  Warnings-Errors.log
grep -E "Warning|Error|BAD_REQUEST" disco-service*.log   | grep -v "CleanupTrackedErrors" >> Warnings-Errors.log
echo +++ siemens-adapter +++ 1>>  Warnings-Errors.log
grep -E "Warning|Error|BAD_REQUEST" siemens-adapter*.log | grep -v "CleanupTrackedErrors" >> Warnings-Errors.log
echo. >> Warnings-Errors.log
echo ----------------------------------------------------------------------- >> Warnings-Errors.log
echo End Date Time: %DATE% %TIME% >> Warnings-Errors.log
echo Errors logged into Warnings-Errors.log
cd ..