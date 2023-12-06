@echo off
set TestRunFilePath=%1
set TestRunName=%2
echo --- Getting DiscoScheduleResponses for LoadTest file: %TestRunFilePath% ---
grep "DiscoScheduleResponse" %TestRunFilePath% | awk '{print $1"	"$2"	"$5"	"$10"	"$14}' >> DiscoScheduleResponses_%TestRunName%.log