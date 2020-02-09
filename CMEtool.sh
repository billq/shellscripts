#!/bin/ksh
# Little monitor thing.
#
if [ -z $DISPLAY ]
then
	echo "DISPLAY not set, exiting"
	exit 1
fi
case $DISPLAY in
:0.0)	DISPLAY=`hostname`:0	;;
*)	:			;;
esac
xhost + >/dev/null 2>&1
EXIT=no
while [ "$EXIT" != "yes" ]
do
xmessage -geometry -0+0 -fn 8x13 -bg blue -fg yellow -n CMEtool -buttons "Handheld:0,Cubs:1,Web:2,Globex Interface:3,Bypass:4,ORAPI:5,Exit:6" Pick an environment to monitor.
case $? in
0)
	ENV=LHH
	LOGDIR=${HOME}/log/${ENV}
	if [ ! -d "$HOME/log/${ENV}" ]
	then
		mkdir -p ${HOME}/log/${ENV}
	fi
	for HOST in hhprap3 hhprap4 hhprdb3
	do
		VM_LOGFILE=${LOGDIR}/${HOST}_VM.log
		PM_LOGFILE=${LOGDIR}/${HOST}_PM.log
		xterm -l -lf $VM_LOGFILE -display $DISPLAY -bg darkmagenta -fg yellow -ms yellow -g 80x13+0+260 -l -lf -sb -sl 50000 -ls -T $HOST -n $HOST -e rsh $HOST -l root vmstat 14400 &
		perfmeter -bg darkmagenta -fg yellow -geometry 1142x96 -g -s 5 -h 60 -m 10 -n $PM_LOGFILE -t cpu -t load -C cpu 50 -C load 5 -H -S -Wn $HOST &
	done
;;
1)
	ENV=CUBS2
	LOGDIR=${HOME}/log/${ENV}
	if [ ! -d "$HOME/log/${ENV}" ]
	then
		mkdir -p ${HOME}/log/${ENV}
	fi
	for HOST in c2prap1 c2prcl1-db1 c2prcl1-db2
	do
		VM_LOGFILE=${LOGDIR}/${HOST}_VM.log
		PM_LOGFILE=${LOGDIR}/${HOST}_PM.log
		xterm -l -lf $VM_LOGFILE -bg blue -fg yellow -ms yellow -g 80x13+0+260 -sb -sl 50000 -ls -T $HOST -n $HOST -e rsh $HOST -l root vmstat 14400 &
		perfmeter -bg blue -fg yellow -geometry 1142x96 -g -s 5 -h 60 -m 10 -n $PM_LOGFILE -t cpu -t load -C cpu 50 -C load 5 -H -S -Wn $HOST &
	done
;;
2)
	ENV=WEB
	LOGDIR=${HOME}/log/${ENV}
	if [ ! -d "$HOME/log/${ENV}" ]
	then
		mkdir -p ${HOME}/log/${ENV}
	fi
	for HOST in c2prweb gfxprweb opsprweb
	do
		VM_LOGFILE=${LOGDIR}/${HOST}_VM.log
		PM_LOGFILE=${LOGDIR}/${HOST}_PM.log
		xterm -l -lf $VM_LOGFILE -bg brown -fg yellow -ms yellow -g 80x13+0+260 -sb -sl 50000 -ls -T $HOST -n $HOST -e rsh $HOST -l root vmstat 14400 &
		perfmeter -bg brown -fg yellow -geometry 1142x96 -g -s 5 -h 60 -m 10 -n $PM_LOGFILE -t cpu -t load -C cpu 50 -C load 5 -H -S -Wn $HOST &
	done
;;
3)
	ENV=GI
	LOGDIR=${HOME}/log/${ENV}
	if [ ! -d "$HOME/log/${ENV}" ]
	then
		mkdir -p ${HOME}/log/${ENV}
	fi
	for HOST in giprap1 giprdb3
	do
		VM_LOGFILE=${LOGDIR}/${HOST}_VM.log
		PM_LOGFILE=${LOGDIR}/${HOST}_PM.log
		xterm -l -lf $VM_LOGFILE -bg green -fg black -ms black -g 80x13+0+260 -sb -sl 50000 -ls -T $HOST -n $HOST -e rsh $HOST -l root vmstat 14400 &
		perfmeter -bg green -fg black -geometry 1142x96 -g -s 5 -h 60 -m 10 -n $PM_LOGFILE -t cpu -t load -C cpu 50 -C load 5 -H -S -Wn $HOST &
	done
;;
4)
	ENV=FIX
	LOGDIR=${HOME}/log/${ENV}
	if [ ! -d "$HOME/log/${ENV}" ]
	then
		mkdir -p ${HOME}/log/${ENV}
	fi
	for HOST in byprap1 byprap2 #fxprnfs1
	do
		VM_LOGFILE=${LOGDIR}/${HOST}_VM.log
		PM_LOGFILE=${LOGDIR}/${HOST}_PM.log
		xterm -l -lf $VM_LOGFILE -bg orange -fg black -ms black -g 80x13+0+260 -sb -sl 50000 -ls -T $HOST -n $HOST -e rsh $HOST -l root vmstat 14400 &
		perfmeter -bg orange -fg black -geometry 1142x96 -g -s 5 -h 60 -m 10 -n $PM_LOGFILE -t cpu -t load -C cpu 50 -C load 5 -H -S -Wn $HOST &
	done
;;
5)
	ENV=ORAPI
	LOGDIR=${HOME}/log/${ENV}
	if [ ! -d "$HOME/log/${ENV}" ]
	then
		mkdir -p ${HOME}/log/${ENV}
	fi
	for HOST in moby orca falcon
	do
		VM_LOGFILE=${LOGDIR}/${HOST}_VM.log
		PM_LOGFILE=${LOGDIR}/${HOST}_PM.log
		xterm -l -lf $VM_LOGFILE -bg grey -fg yellow -ms yellow -g 80x13+0+260 -sb -sl 50000 -ls -T $HOST -n $HOST -e rsh $HOST -l root vmstat 14400 &
		perfmeter -bg grey -fg yellow -geometry 1142x96 -g -s 5 -h 60 -m 10 -n $PM_LOGFILE -t cpu -t load -C cpu 50 -C load 5 -H -S -Wn $HOST &
	done
;;
6)
	xmessage -geometry -0+0 -fn 8x13 -bg blue -fg yellow -n Goodbye -buttons Exit:0 Thanks for using CMEtool. Bye.
	EXIT=yes
;;
*)
	xmessage -geometry -0+0 -fn 8x13 -bg red -fg yellow -n ERROR -buttons Exit:0,Continue:1 Sorry, that environment is not yet configured.
	case $? in
	0)	EXIT=yes	;;
	1)	:		;;
	esac
;;
esac
done &
