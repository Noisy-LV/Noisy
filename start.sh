#!/bin/sh
trap "killall ii; killall bot.sh; killall start.sh; break" INT
chanlist="#fo2 #rawhide"
password=""
icd="/home/terry/viper/ic/pine.forestnet.org"
ii -i /home/terry/viper/ic -s pine.forestnet.org -e ssl -n Noisy &
sleep 3 
echo "identify $password" > "$icd"/nickserv/in 
sleep 2 
for i in $chanlist; do
echo "/join $i" > "$icd"/in 
xterm -e tail -f "$icd"/"$i"/out &
cd "$icd"/"$i" 
./bot.sh & 
done
echo "running.."
while true; do
sleep 5
done
