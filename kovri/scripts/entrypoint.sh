#!/bin/dash

/usr/local/bin/kovri --host 0.0.0.0 --socksproxyaddress 0.0.0.0 -d &&
mkdir /home/kovri/share &&
sleep 3 &&
cp /home/kovri/.kovri/client/keys/bulwarkd.dat.b32.txt /home/kovri/share/ &&
tail -f /home/kovri/.kovri/logs/*.log
fi