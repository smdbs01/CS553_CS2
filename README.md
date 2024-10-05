# CS553 Case Study 2

This repo contains scripts used to deploy our app from Case Study 1 to the server.

To run:

1. Create a `set_env.sh` file that overrides the variables listed at the top of `main.sh`.

1. Run `bash set_cron_job.sh /absolute/path/to/set_env.sh`. This will create a cron job that runs `main.sh` every 10 minutes.
