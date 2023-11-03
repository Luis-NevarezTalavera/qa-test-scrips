@echo off
set MaxMessages=%1
echo ++--- Clearing RabbitMQ / CC-DREX Errors from the cc.drex.site.int-log.q queue, timestamp: %TIME% ---++
mv cc.drex.site.int-log.q.log cc.drex.site.int-log.q.bak.log
call rabbitmq-read_queue.bat guest cc.drex.site.int-log.q %MaxMessages% | grep -Ev "rabbitmq.connection\",\"msg\":\"closing|connection\",\"pid\":\"<0|client unexpectedly closed TCP" > cc.drex.site.int-log.q.log
echo ++--- RabbitMQ / CC-DREX Error messages were filtered out and placed into file: cc.drex.site.int-log.q.log, timestamp: %TIME% ---++