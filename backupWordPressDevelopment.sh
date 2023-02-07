#!/bin/bash

rsync -a --exclude 'wp-content/' --exclude 'plugins/' --exclude 'plugins_backup' root@gamma.pymnts.com:/var/www/gamma.pymnts.com $1 