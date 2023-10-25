@echo off
set TestRun=%1
echo ++--- Getting Disco Create Schedule Requests for LoadTest: %1 ---++
grep -E "DiscoCreateScheduleRequest|    \"requestId\"" %TestRun% | awk -F '+00:00' '{print $1 $2}' > DiscoCreateScheduleRequests.log