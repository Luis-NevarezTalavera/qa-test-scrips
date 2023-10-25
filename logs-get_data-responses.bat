@echo off
set TestRun=%1
echo ++--- Getting Disco Data Responses for LoadTest: %1 ---++
grep "DiscoDataResponse" %TestRun% | awk -F '+00:00' '{print $1 $2}' |  awk -F '"dataPointCollections"' '{print $1}' > DiscoDataResponses.log