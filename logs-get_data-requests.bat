@echo off
set TestRun=%1
echo ++--- Getting Disco Data Requests for LoadTest: %1 ---++
grep -E "DiscoDataRequest|    \"requestId\"" %TestRun% | awk -F '+00:00' '{print $1 $2}' > DiscoDataRequests.log