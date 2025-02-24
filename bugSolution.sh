#!/bin/bash

# Create a file if it does not exist.
if [ ! -f myfile.txt ]; then
  touch myfile.txt
fi

# Use a lock file to avoid race condition. This ensures that only one process can
# access the file at a time.
lockfile="myfile.txt.lock"

# This function acquires an exclusive lock on the file.
function acquire_lock() {
  while ! flock -x "$lockfile"; do
    sleep 0.1
  done
}

# This function releases the lock.
function release_lock() {
  flock -u "$lockfile"
}

# Acquire the lock.
acquire_lock

# The writing part of the program.
(while true; do echo "Process 1 is writing" >> myfile.txt; sleep 1; done) &
PID=$!

# Wait for background process to write some lines to avoid potential empty file
sleep 2

# Read from the file.
fileContent=$(cat myfile.txt)
echo "Content of myfile.txt: $fileContent"

# Kill background process
kill $PID

# Release the lock.
release_lock

# Cleanup
rm myfile.txt
rm $lockfile