while [ true ]; do
  echo `date +'%s'` `sudo iotop -b -a -k -t -o -n 1 -d 1 | grep "Actual DISK"` `sudo iotop -b -a -k -t -o -n 1 -d 1 | grep "Total DISK"` >> monitoramento/io.txt
  sleep 1
done
