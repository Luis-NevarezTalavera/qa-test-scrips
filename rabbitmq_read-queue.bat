@echo off
echo --- Getting localhost Rabbit-MQ messages from queue: %2 logged as user: %1 max qty of messages to read: %3 ---
buneary get messages localhost %2 --user %1 --password %1 --max %3