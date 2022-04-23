#!/bin/bash

#Need to install sshpass utility first

source_user=$1
source_pass=$2
source_ip=$3
source_port=$4

destination_user=$5
destination_pass=$6
destination_ip=$7
destination_path=$8
destination_port=$9

sshpass -p "$source_pass" ssh -o StrictHostKeyChecking=no $source_user@$source_ip -p $source_port << EOF

        cd /var/www/html
        wp db export
        cd ..
        tar -zcf backup.tar.gz /var/www/html/*
        sshpass -p "$destination_pass" rsync -a /var/www/backup3.tar.gz $destination_user@$destination_ip:$destination_path -e "ssh -o StrictHostKeyChecking=no -p $destination_port"

EOF
