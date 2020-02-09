#!/bin/ksh
#
# This script indexes the cs website.
#
PATH=$PATH:/usr/local/bin
cd /doc/www/switch/new_cs/search/db
#
# The first one creates a new index (gets rid of the old one, if present)
#
Iindex -d CS -t HTML -r /doc/www/switch/new_cs/*.html
#
# The next one appends to the index (apparently, the -r option doesn't work...
#
Iindex -a -d CS -t HTML -r /doc/www/switch/new_cs/*/*.html
#
# ...so we have to resort to this ugliness)
#
Iindex -a -d CS -t HTML -r /doc/www/switch/new_cs/*/*/*.html
Iindex -a -d CS -t HTML -r /doc/www/switch/new_cs/*/*/*/*.html
Iindex -a -d CS -t HTML -r /doc/www/switch/new_cs/*/*/*/*/*.html
#
# Run this out of cron nightly, on the WWW server (order).
#
