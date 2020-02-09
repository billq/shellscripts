#!/bin/bash
#
# mysql_dump_all.sh
#
# dump all databases for backup
#
# Jason Harrington <jason@fnal.gov>
# Start Date: 2007-05-16
#
set -x

# basic path
PATH=/bin:/usr/bin:/sbin:/usr/sbin

# where to write error logs
ERRFILE=/tmp/$$.err
# where to send error logs
MAILTO='bill.quayle@gmail.com'

# where to write dumps
DUMPDIR=/bkup

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

# dump databases, flushing logs
if [ -d $DUMPDIR ]
then
	cd $DUMPDIR
	mysqldump --flush-logs --all-databases 2>>$ERRFILE | gzip -c - >mysql.dump.all.`date -I`.gz 2>>$ERRFILE
else
	echo "$DUMPDIR does not exist!" >> $ERRFILE
fi

# if errors, then send email
if [ -s $ERRFILE ]
then
	send_err_mail
fi

# clean up after ourselves
clean_up

exit 0
