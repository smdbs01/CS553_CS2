#!/bin/bash

echo "start deploy.sh"

run_one_command $NEW_KEY_PATH "sudo fuser -k 7860/tcp" # kill the process running on port 7860
run_one_command $NEW_KEY_PATH "sudo rm -rf $GITHUB_REPO_NAME" 
run_one_command $NEW_KEY_PATH "git clone https://github.com/$GITHUB_USER/$GITHUB_REPO_NAME.git && cd $GITHUB_REPO_NAME && git checkout $GITHUB_BRANCH && python3 -m venv .venv"
run_one_command $NEW_KEY_PATH "cd $GITHUB_REPO_NAME && source .venv/bin/activate && python3 -m pip install -r requirements.txt --no-cache-dir && pip cache purge"
run_one_command $NEW_KEY_PATH "HF_TOKEN=$HF_TOKEN nohup $GITHUB_REPO_NAME/.venv/bin/python3 -u $GITHUB_REPO_NAME/app.py > $GITHUB_REPO_NAME/app.log 2>&1 &"

# ssh -i $NEW_KEY_PATH -p $SERVER_PORT $SERVER_USER@$SERVER_HOST -o StrictHostKeyChecking=accept-new /bin/bash << EOF
#     sudo fuser -k 7860/tcp
#     sudo rm -rf $GITHUB_REPO_NAME
#     git clone https://github.com/$GITHUB_USER/$GITHUB_REPO_NAME.git
#     cd $GITHUB_REPO_NAME
#     git checkout $GITHUB_BRANCH

#     python3 -m venv .venv
#     source .venv/bin/activate

#     python3 -m pip install pip==24.0

#     python3 -m pip install -r requirements.txt
#     HF_TOKEN=$HF_TOKEN nohup .venv/bin/python3 -u app.py > ~/$GITHUB_REPO_NAME/app.log 2>&1 &

#     exit
# EOF

# echo "end deploy.sh"