echo off
cd C:\ABS\TestClient\LogFolder-%1-%2\
echo Looking for Warning or Error log entries in the CC-DISCO.log and Siemens-Adapter.log files
echo +++ TestRun-%1-%2 +++ 1>  Warnings-Errors.log
grep -E "Warning|Error|BAD_REQUEST" TestRun-%1-%2.log  | grep -v "CleanupTrackedErrors" >> Warnings-Errors.log
echo +++ CC-DISCO +++ 1>>  Warnings-Errors.log
grep -E "Warning|Error|BAD_REQUEST" CC-DISCO.log       | grep -v "CleanupTrackedErrors" >> Warnings-Errors.log
echo +++ Siemens-Adapter +++ 1>>  Warnings-Errors.log
grep -E '"Warning|Error|BAD_REQUEST"' Siemens-Adapter.log  | grep -v "CleanupTrackedErrors" >> Warnings-Errors.log
cd ..