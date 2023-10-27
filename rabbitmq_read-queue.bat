@echo off
echo --- Getting localhost Rabbit-MQ messages from queue: %2, Logged as user: %1, Date: %Date% Time: %Time%, Max qty of messages: %3 ---
buneary get messages localhost %2 --user %1 --password %1 --max %3 --force