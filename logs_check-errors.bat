echo off
cd C:\ABS\TestClient\LogFolder-%1-%2\
echo Looking for Warning or Error log entries in the CC-DISCO.log and Siemens-Adapter.log files
echo +++ CC-DISCO +++ 1>  WarningError.log
grep -E '"Warning"' CC-DISCO.log >> WarningError.log
grep -E '"Error"'   CC-DISCO.log >> WarningError.log
echo +++ Siemens-Adapter +++ 1>>  WarningError.log
grep -E '"Warning"' Siemens-Adapter.log >> WarningError.log
grep -E '"Error"'   Siemens-Adapter.log >> WarningError.log
cd ..