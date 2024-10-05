#!/bin/bash

echo "start deploy.sh"

run_one_command $NEW_KEY_PATH "sudo fuser -k 7860/tcp" # kill the process running on port 7860
run_one_command $NEW_KEY_PATH "sudo rm -rf $GITHUB_REPO_NAME" 
run_one_command $NEW_KEY_PATH "git clone https://github.com/$GITHUB_USER/$GITHUB_REPO_NAME.git && cd $GITHUB_REPO_NAME && git checkout $GITHUB_BRANCH && python3 -m venv .venv"
run_one_command $NEW_KEY_PATH "cd $GITHUB_REPO_NAME && source .venv/bin/activate && python3 -m pip install -r requirements.txt --no-cache-dir && pip cache purge"
run_one_command $NEW_KEY_PATH "HF_TOKEN=$HF_TOKEN nohup $GITHUB_REPO_NAME/.venv/bin/python3 -u $GITHUB_REPO_NAME/app.py > $GITHUB_REPO_NAME/app.log 2>&1 &"

# echo "end deploy.sh"