@echo off
set testName=%1
set LogFolderMain=c:\ABS\TestClient\LogFolder\%testName%
set DateHourLast=%2

echo +++ Looking for Warning or Error log entries in CC-DISCO.log and Siemens-Adapter.log files +++
grep -E "Warning|Error|warn|fail|crit" C:\ABS\cc-platform\logs\site\disco-service-%DateHourLast%.log   | grep -Ev "CleanupTrackedErrors|Could not establish connection|is not registered for routing|could not be reached, retrying in" > %LogFolderMain%\disco-service_%DateHourLast%_Warnings-Errors.log
grep -E "Warning|Error|warn|fail|crit" C:\ABS\cc-platform\logs\site\siemens-adapter-%DateHourLast%.log | grep -Ev "CleanupTrackedErrors|token" > %LogFolderMain%\siemens-adapter_%DateHourLast%_Warnings-Errors.log
echo Errors logged into %LogFolderMain%\TestRun,disco-service,siemens-adapter _Warnings-Errors.log
