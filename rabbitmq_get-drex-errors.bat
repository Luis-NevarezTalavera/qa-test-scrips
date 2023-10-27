@echo off
echo --- Reading and Filtering out errors from the cc.drex.site.int-log.q queue ---
mv cc.drex.site.int-log.q.log cc.drex.site.int-log.q.bak.log
rabbitmq_read-queue.bat guest cc.drex.site.int-log.q 200 > cc.drex.site.int-log.q.log
grep -Ev "disco-test-client|rabbitmq-local|ROUTING KEY|                        |-----" cc.drex.site.int-log.q.log