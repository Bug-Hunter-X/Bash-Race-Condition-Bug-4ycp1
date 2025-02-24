# Bash Race Condition Bug

This repository demonstrates a common but subtle bug in shell scripting: a race condition. The script attempts to read from a file while another process is writing to it concurrently, leading to potential data corruption or unexpected behavior.

The `bug.sh` script showcases the race condition. The `bugSolution.sh` demonstrates how to solve it using proper synchronization mechanisms.