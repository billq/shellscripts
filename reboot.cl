#!/bin/ksh
################################################################################
#                   @(#)Copyright (c) 1997 William R. Quayle                   #
#                             All Rights Reserved                              #
################################################################################
#                                                                              #
# This is free software.  It comes  with absolutely  NO WARRENTY  expressed or #
# implied.                                                                     #
#                            USE AT YOUR OWN RISK!                             #
#                                                                              #
# Permission is granted to use, modify, and distribute copies of this software #
# software  provided  the following conditions are met:                        #
#                                                                              #
#      1) that that the above copyright notice and this notice                 #
#         are preserved in all copies and that due credit be given             #
#         to the author.                                                       #
#                                                                              #
#      2) that any changes to this code are clearly commented                  #
#         as such so that the author does get blamed for bugs                  #
#         other than his own.                                                  #
#                                                                              #
#      Please send copies of changes and bug-fixes to:                         #
#                                                                              #
#                             billq@technologist.com                           #
#                                                                              #
################################################################################
#
#	reboot.cl: reboot clients, lets you see who's on first!
#
ERR="ERROR:$0:"
HOSTNAME=`/bin/hostname`
OPER=`/usr/ucb/whoami`
if [ "$HOSTNAME" != "chicago" ] || [ "$OPER" != "root" ]
then
	echo $ERR"Not logged in as root to chicago"
	exit 1
fi
TARGET="albany topeka salem omaha eureka taos aspen juneau bangor peoria waco urbana casper malibu reno provo boston"
for i in $TARGET
do
	rsh $i /bin/who
	echo "who done on $i"
	#if [ "$WHOSON" = "" ];then
		#echo "booting $i"
		#rsh $i /etc/shutdown -r now &
	#else
		#echo "checking out WHOSON on $i, give me initials on who to check on: \c"
		#read VIOLATOR
		#rsh $i /bin/ps -aux | grep $VIOLATOR
		#rsh $i /usr/ucb/finger $VIOLATOR
		#echo "Kill him, anyway?"
		#read AXE
		#case $AXE in
		#y*|Y*)	rsh $i /etc/shutdown -r now &
			#;;
		#*)	continue
			#;;
		#esac
	#fi
done
