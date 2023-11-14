@echo off
set MaxMessages=%1
set TestClient=%2
echo ++--- Clearing RabbitMQ / CC-DREX Errors from the cc.drex.site.int-log.q queue, timestamp: %TIME% ---++
call rabbitmq-read_queue.bat guest cc.drex.site.int-log.q %MaxMessages% >> cc.drex.site.int-log.q_%TestClient%.log
echo ++--- RabbitMQ / CC-DREX Error messages were filtered out and placed into file: cc.drex.site.int-log.q.log, timestamp: %TIME% ---++