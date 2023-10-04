@echo off
set ABS_NUGET_USERNAME=%1
set /p ABS_NUGET_PASSWORD=<c:\Users\%1\myGitHubToken.txt
echo on
:: echo %ABS_NUGET_USERNAME%
:: echo %ABS_NUGET_PASSWORD%