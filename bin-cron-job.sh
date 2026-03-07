!#/dev/usr/bin/bash

# bin-corn-job.sh
# adds a sh file into the bin utils and makes it into a cron job 
# Recives a path and time interval in minutes for the cron job

# Command inputs
BIN_UTIL=$1
MINS=$2

# Make it into bin util

mkdir ~/bin
mv $BIN_UTIL ~/bin
chmod +x ~/bin/$(basename $BIN_UTIL)
export PATH="$HOME/bin:$PATH"
source ~/.bashrc


# Make it into a cron job
if [[ $MINS -lt 0 || $MINS -gt 59 ]]; then  echo "Use a value between 0 - 59" >&2
  exit 1
fi

# Add cron job
SCRIPT_NAME=$(basename "$BIN_UTIL")
(crontab -l 2>/dev/null; echo "*/$MINS * * * * $HOME/bin/$SCRIPT_NAME") | crontab -
echo "Cron job set: $SCRIPT_NAME will run every $MINS minutes."
