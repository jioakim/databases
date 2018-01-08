#!/bin/bash

# Runs an SQL file called chat.sql that creates and updates an AWS RDS MySql
# database.  chat.sql must be present in the same directory as this script.
# Tue Aug  8 07:33:45 EDT 2017
# Kevin Coyner

if [ -f "./chat.sql" ]; then
  mysql  -u kevinroot -p -h  hr-rpt01.cybvxu5jsrlj.us-east-1.rds.amazonaws.com < ./chat.sql
fi


