@echo off
set TestRun=%1
echo ++--- Getting Disco Schedule Responses for LoadTest: %1 ---++
grep "DiscoScheduleResponse" %TestRun% | awk -F '+00:00' '{print $1 $2}' > DiscoScheduleResponses.log