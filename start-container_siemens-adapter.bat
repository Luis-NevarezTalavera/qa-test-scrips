echo == Starting Siemens Adapter ==
cd c:\ABS\cc-disco\
copy Siemens-Adapter.log Siemens-Adapter_backup.log
date /t >  Siemens-Adapter.log
time /t >> Siemens-Adapter.log
docker run ghcr.io/abs-wavesight/cc-adapters-siemens:windows-2019 >> Siemens-Adapter.log 2>&1