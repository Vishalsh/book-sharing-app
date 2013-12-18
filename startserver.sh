#!/bin/bash

ssh user@10.10.5.111 "cd /home/user/BookSharing/current;
sudo kill -9 $(ps aux | grep rails | grep -v grep | awk '{ print $2 }');
BUILD_ID=dontKillMe
rails s &"
