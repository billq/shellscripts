#!/bin/ksh
ID=`/usr/ucb/whoami`
BATCHDIR=/cdburn/pm1/${ID}
# BATCHDIR=/cdburn/pm1/audio
TRKLST=${BATCHDIR}/audio_tracklist.log
GETTRKLST=${BATCHDIR}/getaudio_info
BURNAUDIO=${BATCHDIR}/burnaudio
# BURNAUDIO=/cdburn/pm1/rvgarcia/burnaudio
rm -f $TRKLST $BURNAUDIO

mkdir /cdburn/pm1/${ID} >/dev/null 2>&1
cd /cdburn/pm1/${ID}

typeset -i N TRACKS
N=1
echo "
-----------------------------------------
You need to type 'exit' at the CD> prompt
when this piece of the script finishes...

Put your music CD into the CD Writer now.
-----------------------------------------

Hit 'Return' to continue -> \c"

read GO
echo "
newvol MUSIC 74 DA
" >> $BURNAUDIO

gear $GETTRKLST

TRACKS=`cat $TRKLST|grep track|awk '{print $4}'|sed 's/://'|tail -1`

while [ $N -le $TRACKS ]
do
	echo "
newtrk DA $N
readtrack $N file$N
cp file$N
" >> $BURNAUDIO
	N=$(($N+1))
done
echo "
eject
writecd
delvol MUSIC
" >> $BURNAUDIO


echo "
-----------------------------------------
When the CD ejects, put in your blank cd.
When it's done burning, type exit to exit
the script.
-----------------------------------------

Hit 'Return' to continue -> \c"
read GO

gear $BURNAUDIO
