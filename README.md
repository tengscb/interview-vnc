# interview-vnc

## Setup Instruction

From GCP, create a new instance with the following spec
 - Machine Type: `n1-standard-4 (4 vCPUs, 15 GB memory)` 
   For Mumbai region, it seems the spec is not available. The following should work as well  
   - `e2-standard-2 (2 vCPUs, 8 GB memory)`
   - `n1-standard-2 (2 vCPUs, 7.5 GB memory)`
 - Disk Image: ubuntu-1804-bionic
 - Disk Size: 20GB
 - Allow Port: ssh (22), http (80)
 - Region: asia-south1 (Mumbai)

It's recommended to create above as an instance template so that it can be reused.

Once instance up & running, launch the SSH console (web based) from GCP, and run:

```
curl -O https://raw.githubusercontent.com/tengscb/interview-vnc/master/launch_interview_box.sh
chmod +x launch_interview_box.sh
sudo ./launch_interview_box.sh <intellij|intellij-dark|eclipse> <vnc_password>
```

Specify the IDE type as first arg, and VNC session password as the second arg

Once Script execution finishes, access the test machine via VNC with the `?view_only=false` option.

From within the test machine, open terminal and run

```
cd coding-test
./start-interview.sh
```