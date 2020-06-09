#!/bin/bash

# use "man rsync" to learn more about certain parameters used below in this partucular case
# note: do not use --compress parameter in case of local backup scheme, as it doesn't add any effectivness and just uses your server's CPU resources to compress and decompress data on a fly. This parameter has nothing to do with archiving direcotry to a single compressed file. This parameter can be handy only for remote backup schemes when a network connection is a bottle-neck.

# creating a directory for rsync to backup to (in case it doesn't exist).
mkdir -p /media/myBackuper_data

# creating a directory for rsync to store log files in (in case it doesn't exist).
mkdir -p /var/log/myBackuper

sudo rsync -av --progress --delete-excluded --log-file=/var/log/myBackuper/$(date +"%d-%m-%Y_%H-%M")_myBackuper.log --exclude "/home/*/not_important_files" /home /media/myBackuper_data

# creating a directory for storing the final archive (.tar.gz) file in case it doesn't exist.
mkdir -p /media/myBackuper_archives

# compressing the already backed up data to a single archive file (using gzip as a compression method).
tar -zcvf /media/myBackuper_archives/$(date +"%d-%m-%Y_%H-%M")_myBackuper.tar.gz /media/myBackuper_data
