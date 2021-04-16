#!/bin/bash

chkconfig --add postgresql
chkconfig --add httpd

service httpd start &&	service postgresql start
