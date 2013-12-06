#!/bin/bash

#ssh user@10.10.5.111 /home/user/BookSharing/current
BUILD_ID=dontKillMe
sudo kill -9 $(ps aux | grep rails | grep -v grep | awk '{ print $2 }')
rails s &