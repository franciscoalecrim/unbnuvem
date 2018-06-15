
#!/bin/bash
WORKLOAD=$1
while [ true ]; do
    echo `date +"%s"` `sudo iftop -t -p -s 1 | grep "send rate"`  `sudo iftop -t -p -s 1 | grep "receive rate"` >> ${WORKLOAD}/monitoramento/network.txt
  sleep 1
done
