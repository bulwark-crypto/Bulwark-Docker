#!/bin/dash

/usr/local/bin/kovri --host 0.0.0.0 --socksproxyaddress 0.0.0.0 -d &&
sleep 3 &&
mkdir -p /home/kovri/share &&
cp /home/kovri/.kovri/client/keys/bulwarkd.dat.b32.txt /home/kovri/share/ &&
tail -f /home/kovri/.kovri/logs/*.log