#!/bin/bash

# This script demonstrates a race condition bug.

# Create a file if it does not exist.
if [ ! -f myfile.txt ]; then
  touch myfile.txt
fi

# This is the buggy part: start a background process to write to the file,
# and then immediately try to read from the file in the main process.
# Race condition happens here.
(while true; do echo "Process 1 is writing" >> myfile.txt; sleep 1; done) &

# Read from the file. We might get partial data or an error if the background process
# is currently writing.
fileContent=$(cat myfile.txt)
echo "Content of myfile.txt: $fileContent"

# wait for the background processes
wait

# Cleanup
rm myfile.txt