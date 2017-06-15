#!/bin/bash

USER=$1
PASSWORD=$2
SERVER=$3
APP=$4
COPIES=$5
COUNT=1

# login
printf "\n>> Logging on to $SERVER as $USER ...\n"
apic login -u $USER -p $PASSWORD -s $SERVER

# get orgs
ORG=$(apic orgs -s $SERVER)

# create copies of lb app
while [ "$COPIES" -gt 0 ]
    do
        printf "\n>> Publish # $COUNT\n"
        # publish an app
        apic apps:publish -a $APP -o $ORG -s $SERVER

        COUNT=$((COUNT + 1))
        COPIES=$((COPIES - 1))
    done

# logout
printf "\n>> Logging out of $SERVER ...\n"
apic logout -s $SERVER
