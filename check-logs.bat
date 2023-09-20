echo off
cd C:\ABS\cc-disco\client\TestClient\LogFolder-%1-%2\
echo Looking for Warning or Error log entries in the CC-DISCO.log and Siemens-Adapter.log files
grep -E 'arning' CC-DISCO.log >  WarningError.log
grep -E 'rror'   CC-DISCO.log >> WarningError.log
grep -E 'arning' Siemens-Adapter.log >> WarningError.log
grep -E 'rror'   Siemens-Adapter.log >> WarningError.log