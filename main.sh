#!/bin/bash

SERVER_HOST=""
SERVER_PORT=""
SERVER_USER=""

DEFAULT_KEY_PATH=""
NEW_KEY_PATH=""
NEW_PUB_KEY_PATH=""

GITHUB_USER=""
GITHUB_REPO_NAME=""
GITHUB_BRANCH=""
# GITHUB_TOKEN=""

HF_TOKEN=""

# clone repository
clone_repo() {
    echo "Cloning repository"
    rm -rf $GITHUB_REPO_NAME
    git clone https://github.com/$GITHUB_USER/$GITHUB_REPO_NAME.git
    cd $GITHUB_REPO_NAME && git checkout $GITHUB_BRANCH
}

# run one command
# 1st argument: path to key
# 2nd argument: command
run_one_command() {
    ssh -i $1 -p $SERVER_PORT $SERVER_USER@$SERVER_HOST -o StrictHostKeyChecking=accept-new $2
}

cd "$(dirname $0)" || exit 1

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <path_to_set_env.sh>"
    exit 1
fi

source $1

source check_server_status.sh

source check_github.sh
