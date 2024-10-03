#!/bin/bash

echo "start set_cron_job.sh"

# Remove existing cron job
crontab -r

dir=$(realpath $0 | xargs dirname)
# Set new cron job
job="bash $dir/main.sh 2>&1 | $dir/predate.sh >> $dir/log.txt"
# echo $job
(crontab -l 2>/dev/null; echo "*/10 * * * * $job") | crontab -

# echo "end set_cron_job.sh"