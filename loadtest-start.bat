echo off
echo +++--- Starting CC-DISCO / Siemens Adapter Load Test ---+++
echo --- This script requires 2 arguments: 1: TestClients qty: %1 and Request type OnDemand or Schedule: %2
cd C:\ABS\TestClient\LoadTest\
echo --- Creating %1 Test Client instances in independent Command Prompt Windows ---
for /l %%i in (1,1,%1) do start "test-client-%%i" loadtest-execute_test-client test-client-%%i %2