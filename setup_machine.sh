#!/bin/bash

echo "start setup_machine.sh"

NEW_PUB_KEY_CONTENT=$(<$NEW_PUB_KEY_PATH)

run_one_command $DEFAULT_KEY_PATH "echo $NEW_PUB_KEY_CONTENT > ~/.ssh/authorized_keys"
run_one_command $NEW_KEY_PATH "sudo apt upgrade -y"
run_one_command $NEW_KEY_PATH "sudo apt install python3-venv -y"

# echo "end setup_machine.sh"