Sleep=1
[ "$1" ] && Sleep=$(($1/5))
[ "$2" = "-e" ] && Terminate=1
#echo "Spin delay: $Sleep"
#read go
while true
do
echo -e "\b|\c"
sleep $Sleep
echo -e "\b/\c"
sleep $Sleep
echo -e "\b-\c"
sleep $Sleep
echo -e "\b\\\\\c"
sleep $Sleep
echo -e "\b\c"
echo -e ";-)\c"
sleep $Sleep
echo -e "\b\b\b\c"
echo -e "   \c"
echo -e "\b\b\b\c"
if [ "$Terminate" = "1" ]
then
  exit
fi
done
