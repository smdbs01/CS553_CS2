#!/bin/bash

echo "start check_github.sh"

LAST_COMMIT="last_commit.txt"

if (! [ -d $GITHUB_REPO_NAME ]); then
    echo "Cloning repository"
    clone_repo
fi

LAST_COMMIT_NEW=$(cd $GITHUB_REPO_NAME && git checkout $GITHUB_BRANCH > /dev/null 2>&1 && git rev-parse origin/$GITHUB_BRANCH && cd ..)

# echo $LAST_COMMIT_NEW

if [ ! -f "$LAST_COMMIT" ] || [ "$(cat $LAST_COMMIT)" != "$LAST_COMMIT_NEW" ]; then
    echo "New commit found. Deploying"
    source deploy.sh
else
    echo "No new commit found. Exiting"
fi

echo $LAST_COMMIT_NEW > $LAST_COMMIT

# echo "end check_github.sh"