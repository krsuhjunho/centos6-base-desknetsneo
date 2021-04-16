#!/bin/bash

mkdir -p /var/cache/yum/x86_64/6/base/
echo 'https://vault.centos.org/6.10/os/x86_64/' > /var/cache/yum/x86_64/6/base/mirrorlist.txt

mkdir -p /var/cache/yum/x86_64/6/extras/
echo "http://vault.centos.org/6.10/extras/x86_64/" > /var/cache/yum/x86_64/6/extras/mirrorlist.txt

mkdir -p /var/cache/yum/x86_64/6/updates/
echo "http://vault.centos.org/6.10/updates/x86_64/" > /var/cache/yum/x86_64/6/updates/mirrorlist.txt
