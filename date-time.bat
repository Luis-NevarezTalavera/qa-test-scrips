@echo off
set space=" "
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mydate=%%c-%%a-%%b)
For /f "tokens=1-2 delims=/:" %%a in ("%TIME%") do (set mytime=%%a:%%b)
For /f "tokens=1-2 delims=/:" %%a in ("%TIME%") do (set mytimehh=%%a)
If "%mytime:~0,1%"   EQU %space% (set mytime=0%mytime:~1,4%)
If "%mytimehh:~0,1%" EQU %space% (set mytimehh=0%mytimehh:~1,1%)
echo current date-time: %DATE% %TIME%