#!/bin/bash
#
# mysql_flush_logs.sh
#
# flush binary logs for incremental backup
#
# Jason Harrington <jason@fnal.gov>
# Start Date: 2007-05-16
#

# basic path
PATH=/bin:/usr/bin:/sbin:/usr/sbin

# where to write error logs
ERRFILE=/tmp/$$.err
# where to send error logs
MAILTO='jason@fnal.gov'

# where to write dumps
DUMPDIR=/cdf/work/backups/mysql

# functions
setup_err_log () {
	touch $ERRFILE
}

clean_up () {
	rm -f $ERRFILE
}

send_err_mail () {
	mail -s "`hostname`:$0 error" $MAILTO <$ERRFILE
}

# setup log files
setup_err_log

# flush logs
mysqladmin flush-logs >/dev/null 2>>$ERRFILE

# if errors, then send email
if [ -s $ERRFILE ]
then
	send_err_mail
fi

# clean up after ourselves
clean_up

exit 0
