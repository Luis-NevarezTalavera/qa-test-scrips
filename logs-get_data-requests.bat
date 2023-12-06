@echo off
set TestRunFilePath=%1
set TestRunName=%2
echo --- Getting DiscoDataRequests for LoadTest file: %TestRunFilePath% ---
grep "DiscoDataRequest|    \"requestId\":|^  }" %TestRunFilePath% | awk '{RS="}"; print $1"	"$2"	"$5}' >> DiscoDataRequests_%TestRunName%.log