#!/bin/ksh
echo $0
echo ${0##*/}
echo ${1:+unset}
