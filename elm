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
#!/bin/sh
if [ -f $HOME/.elmupdated ]
then
	/usr/local/bin/elm.x $*
else
	echo "Running elm alias update..."
	/usr/local/bin/newalias
	/usr/local/bin/elm.x $*
fi
