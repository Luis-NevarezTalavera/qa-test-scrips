echo +++ Diff Comparing %1 vs %2 Log Files +++
echo off
logs_replace-timestamps.bat %1 1
logs_replace-timestamps.bat %2 2
diff -s --suppress-common-lines --minimal _temp_Compare1.log _temp_Compare2.log > 'diff %1 vs %2.log'
"C:\Program Files\Notepad++\notepad++.exe" 'diff %1 vs %2.log'