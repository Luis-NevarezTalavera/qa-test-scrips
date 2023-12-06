@echo off
set TestRunFilePath=%1
set TestRunName=%2
echo --- Getting DiscoCreateScheduleRequests for LoadTest file: %TestRunFilePath% ---
grep -E "DiscoCreateScheduleRequest|    \"requestId\":|^  }" %TestRunFilePath% | awk '{RS="}"; print $1"	"$2"	"$6"	"$12}' >> DiscoCreateScheduleRequests_%TestRunName%.log
