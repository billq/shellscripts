#!/bin/ksh
#
# checkpatches.sh
#
# Simple script to check for netscape 6 packages.
#
# (c) Copyright 2001 Sun Microsystems, Inc.
#
#

# 
# Check for required patches
#
MISSINGPATCHES=0
S7_SPARC="107544-03 106980-10 106950-09 108376-07 106300-09 106327-08 109104-01 106541-11 107081-20 107636-07"
S7_INTEL="107545-03 106981-10 106951-07 108377-06 106328-08 109105-01 106542-11 107082-20 107637-07"
S8_SPARC="108940-07 108773-07"
S8_INTEL="108941-07 108774-07"
S7_SPARC_FONTPATCH="107153-01"
S7_INTEL_FONTPATCH="107152-01"

if [ `uname -p` = "sparc" ]
then
	if [ `uname -r` = "5.7" ]
	then
		PATCH_LIST=$S7_SPARC
		#
		# See if we need the patch for chinese fonts
		#
		/bin/pkginfo -q SUNWgttf
		FOUNDPKG=$?
		if [ $FOUNDPKG -eq 0 ]
		then
			PATCH_LIST="$S7_SPARC $S7_SPARC_FONTPATCH"
		fi

	elif [ `uname -r` = "5.8" ]
	then
		PATCH_LIST=$S8_SPARC
	fi
elif [ `uname -p` = "i386" ]
then
	if [ `uname -r` = "5.7" ]
	then 
		PATCH_LIST=$S7_INTEL
		#
		# See if we need the patch for chinese fonts
		#
		/bin/pkginfo -q SUNWgttf
		FOUNDPKG=$?
		if [ $FOUNDPKG -eq 0 ]
		then
			PATCH_LIST="$S7_INTEL $S7_INTEL_FONTPATCH"
		fi

	elif [ `uname -r` = "5.8" ]
	then
		PATCH_LIST=$S8_INTEL
	fi
fi

echo ""
echo "Checking for required patches "$PATCH_LIST"..."
echo ""

for patch in $PATCH_LIST
do 
	prefix=`echo $patch | awk -F- '{ print $1 }'`
	version=`echo $patch | awk -F- '{ print $2 }'`

	installed_patch_list=`showrev -p | awk '{ print $2 }' | grep $prefix`
	FOUNDPATCH=0	
	for tmp in $installed_patch_list
	do
		tmp_prefix=`echo $tmp | awk -F- '{ print $1 }'`
		if [ $tmp_prefix = $prefix ]
		then
			tmp_version=`echo $tmp | awk -F- '{ print $2 }'`
			if [ $tmp_version -ge $version ]
			then
				FOUNDPATCH=1
			fi
		fi
	done

	if [ $FOUNDPATCH = 0 ]
	then
	 	MISSINGPATCHLIST="$patch or higher \n $MISSINGPATCHLIST"
		MISSINGPATCHES=1
	fi
done

if [ $MISSINGPATCHES = 1 ]
then
	echo "The following patches are not installed on this system:"
	echo " $MISSINGPATCHLIST"
	echo "You may need to install the missing patch(es) on this system."
	echo "Please refer to the Netscape 6 installation documentation for"
	echo "more information. The document can be located at"
	echo "http://www.sun.com/software/solaris/netscape/getnetscape6.html."
	echo ""
        exit 1
fi
