echo == Starting CC DISCO ==
cd c:\ABS\TestClient\
copy CC-DISCO.log CC-DISCO_backup.log
date /t >  CC-DISCO.log
time /t >> CC-DISCO.log
docker run ghcr.io/abs-wavesight/cc-disco:windows-2019 >> CC-DISCO.log 2>&1