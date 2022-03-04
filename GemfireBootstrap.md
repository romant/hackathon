
### Gemfire
VMware Tanzu GemFire is a distributed, in-memory, key-value store that performs read and write operations at blazingly fast speeds basedon Apache Geode. It offers highly available parallel message queues, continuous availability, and an event-driven architecture you can scale dynamically, with no downtime. As your data size requirements increase to support high-performance, real-time apps, Tanzu GemFire can scale linearly with ease.

We can do  simple bootstrap on Gemfire by following below instructions. This script developed for AWS environment.
Pre-requisites:
- AWC EC2 Instance with either Amazon Linux 2 AM or RHEL 8
- Gemfire binary in tar.gz format, version changes can be adapted on the script with minor changes
- Necessary firewall config open in AWS for accesing the service and Web UI

Copy below script to your AWS home directory:
  - [Gemfire Bootstrap Script](gemfireBootstrap.sh)

Run it as normal script:
 ** bash gemfireBootstrap.sh **

The bootstrap script will run below events:
1. Cleanup previous installation
2. Install JDK
3. Setup Gemfire path
4. Setup JAVA_HOME
5. Start Gemfire locator service
6. Start Gemfire cache service
7. Show configuration


Expected output:

```
 [INFO]: Showing Gemfire configuration, 1 locator and 2 cach servers:

(1) Executing - connect --locator=ip-172-31-28-204.ec2.internal[41111]

Connecting to Locator at [host=ip-172-31-28-204.ec2.internal, port=41111] ..
Connecting to Manager at [host=ip-172-31-28-204.ec2.internal, port=1099] ..
Successfully connected to: [host=ip-172-31-28-204.ec2.internal, port=1099]

You are connected to a cluster of version: 9.10.14


(2) Executing - list members

Member Count : 3

               Name                  | Id
------------------------------------- | ----------------------------------------------------------------------------------------------
locator_ip-172-31-28-204.ec2.internal | 172.31.28.204(locator_ip-172-31-28-204.ec2.internal:15603:locator)<ec><v0>:41000 [Coordinator]
server1                               | 172.31.28.204(server1:15902)<v1>:41001
server2                               | 172.31.28.204(server2:16251)<v2>:41002
```

  
We can check the cluster configuration through Web UI as well:
Default User/ Pass is admin/admin

![Gemfire - Pulse UI](https://github.com/romant/hackathon/blob/main/Pulse.png)

  
