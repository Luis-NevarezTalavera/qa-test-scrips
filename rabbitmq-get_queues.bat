@echo off
echo --- Getting localhost Rabbit-MQ logged as user: %1 with queue names like "%2" ---
buneary get queues localhost --user %1 --password %1 | grep -E "NAME|%2"