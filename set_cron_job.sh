#!/bin/bash

echo "start set_cron_job.sh"

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <path_to_set_env.sh>"
    exit 1
fi

# Remove existing cron job
crontab -r

dir=$(realpath $0 | xargs dirname)
# Set new cron job
job="bash $dir/main.sh $1  2>&1 | $dir/predate.sh >> $dir/log.txt"
# echo $job
(crontab -l 2>/dev/null; echo "*/10 * * * * $job") | crontab -

# echo "end set_cron_job.sh"