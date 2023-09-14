echo +++ Masking out DateTime stamps in LogFile: LogFolder-%1\TestRun-%1.log +++
echo off
echo %1 > _temp_Compare%2.log
awk -F '+00:00' '{print "YYYY-MM-DD hh:mm:ss.sss +00:00" $2}' LogFolder-%1\TestRun-%1.log >> _temp_Compare%2.log
sed -i 's/\b[0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}T[0-9]\{2\}:[0-9]\{2\}:[0-9]\{2\}.[0-9]\{9\}Z/YYYY-MM-DDThh:mm:ss.sssssssss/g'  _temp_Compare%2.log
sed -i 's/\b[0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}T[0-9]\{2\}:[0-9]\{2\}:[0-9]\{2\}.[0-9]\{6\}Z/YYYY-MM-DDThh:mm:ss.sssssssss/g'  _temp_Compare%2.log