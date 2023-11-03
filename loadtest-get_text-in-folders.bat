@echo off
set searchText=%1
echo ++--- Getting Disco Data Responses for LoadTest: %1 ---++
for /l %%i in (0,1,9) do (
    echo +--- LoadTest-2023-11-03_1%%i_OnDemand ---+
    grep "%searchText%" LoadTest-2023-11-03_1%%i_OnDemand\LoadTest-2023-11-03_1%%i_OnDemand.log | grep -v "Errors: 0"
)