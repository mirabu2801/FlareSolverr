#!/bin/bash

PIDFILE="pids.txt"

# If PID file exists, kill processes listed in it
function stop_scripts() {
    # If PID file exists, kill processes listed in it
    if [[ -f $PIDFILE ]]; then
        while read pid; do
            if ps -p $pid > /dev/null; then
                echo "Killing process $pid"
                kill $pid
            fi
        done < $PIDFILE

        # Clear the PID file
        > $PIDFILE
    fi
}
stop_scripts
# If the argument "stop" is provided, stop the scripts and exit
if [[ $1 == "stop" ]]; then
    rm $PIDFILE
    exit 0
fi

export PYTHONPATH=$PYTHONPATH:$(pwd)

# Run the Python scripts, save the PIDs, and redirect logs
python3 src/flaresolverr.py > run_log.txt 2>&1 & echo $! >> $PIDFILE

echo "All scripts are now running in the background."
