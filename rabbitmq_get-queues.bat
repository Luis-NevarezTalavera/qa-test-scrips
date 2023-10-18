@echo off
echo --- Getting localhost Rabbit-MQ queues with name like "%1" ---
buneary get queues localhost --user guest --password guest | grep -E "NAME|%1"