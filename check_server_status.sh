#!/bin/bash

echo "start check_server_status.sh"

FINGERPRINT="fingerprint.txt"
FINGERPRINT_NEW="fingerprint_new.txt"

# Get server fingerprint and save it to fingerprint_new.txt
ssh-keyscan -p $SERVER_PORT $SERVER_HOST 2> /dev/null | ssh-keygen -lf - | sort > $FINGERPRINT_NEW

# If fingerprint file does not exist or new fingerprint is different from old fingerprint, run setup_machine.sh
if [ ! -f $FINGERPRINT ] || ! diff -ab $FINGERPRINT $FINGERPRINT_NEW &> /dev/null; then
    # Remove old fingerprint
    ssh-keygen -R [$SERVER_HOST]:$SERVER_PORT

    # Save new fingerprint to fingerprint.txt
    mv $FINGERPRINT_NEW $FINGERPRINT
    
    echo "Fingerprint changed. Running setup_machine.sh"

    # setup key stuff
    source setup_machine.sh

    # deploy
    source deploy.sh
else 
    rm $FINGERPRINT_NEW
    echo "Fingerprint not changed. Exiting"
fi

# echo "end check_server_status.sh"