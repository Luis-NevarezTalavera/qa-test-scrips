@echo off
set TestRunFilePath=%1
set TestRunName=%2
echo --- Getting DiscoDataResponses for LoadTest file: %TestRunFilePath% ---
grep "DiscoDataResponse" %TestRunFilePath% | awk '{print $1"	"$2"	"$5"	"$10"	"$14}' >> DiscoDataResponses_%TestRunName%.log