#!/bin/ksh
DIR=$1
if [ ! -d $DIR ]
then
	echo "$DIR doesn't seem to exist.  I don't know what to do."
	exit 2
fi
cd $DIR
touch ./index.html
if [ $? -ne 0 ]
then
	echo "Hmm.  Can't write to .  Bailing out."
	exit 3
fi
echo "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 3.2 Final//EN\">
<META HTTP-EQUIV=\"content-type\" CONTENT=\"text/html;charset=iso-8859-1\">
<HTML>
<HEAD>
<TITLE>Image Index</TITLE>
</HEAD>
<BODY
  BGCOLOR=FFFFFF
  TEXT=0000FF
>
<H1 ALIGN=\"CENTER\">Image Index</H1>" > index.html

ls | grep -v index.html|awk '{printf ("<img src=%s> %s <BR>\n", $1,$1)}'>>index.html

echo "</BODY>
</HTML>" >> index.html
