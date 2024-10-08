# Overview
The adx-tpc-h Benchmark Scripts are intended to be used on a Redshift cluster (Provisioned or Serverless). The SQL scripts are executed with psql and include single and multi-user tests. 

## Pre-requisite
You need to first choose the TPC-H data set from https://github.com/awslabs/amazon-redshift-utils/tree/master/src/CloudDataWarehouseBenchmark/Cloud-DWB-Derived-from-TPCH and load 100GB, 10GB, 3TB, or 30TB. You can load each one in a separate schema also. Then choose the schema for execution as shown below.

## Automated Setup: CloudFormation
A simple CloudFormation template, `rs_serverless.json`, is included in this repo to simplify the deployment of resources needed for the demo. The template deploys the following resources in your default VPC:
- Jumpbox (EC2 instance) with the latest version of Amazon Linux
- Redshift Serverless Workgroup
- IAM Role with redshift-serverless:GetWorkgroup action granted
- Security Group with inbound port 22 (ssh) and connectivity between the Jumpbox and the Redshift Serverless Workgroup
- This Github repo is downloaded in the Jumpbox

Note: Using the CloudFormation template is optional. You can execute the demo by manually provisioning the Jumpbox and Redshift Serverless resources.

### Template Parameters
- `Stack`: CloudFormation term used to define all of the resources created by the template.
- `KeyName`: This is the name of an existing Key Pair. If you don't have one already, create a Key Pair which is used to SSH to the Jumpbox.
- `SSHLocation`: The CIDR mask for incoming connections to the Jumpbox. The default is 0.0.0.0/0 which means any IP address is allowed to SSH to the Jumpbox provided the client has the Key Pair private key. You may choose to limit this to a smaller range of IP addresses if you like.
- `RedshiftCapacity`: This is the number of RPUs for the Redshift Serverless Workgroup. The default is 128 and recommended for analyzing the larger TPC-DS datasets.

## Manual Setup
If you choose not to use the CloudFormation template, deploy the Jumpbox and Redshift Workgroup with the following instructions.

### Linux Jumpbox Setup
- Deploy a VM in the same AWS Region as your Redshift database using the Amazon Linux 2 AMI 
- The Amazon Linux 2 AMI (64-bit x86) with the t2.micro instance type is an inexpensive and tested configuration
- Add the Security Group configured for your Redshift database to your Jumpbox instance
- Install psql with `sudo yum install postgresql.x86_64 -y`
- Download this Github repo. `git clone --depth 1 https://github.com/aws-samples/redshift-benchmarks /home/ec2-user/redshift-benchmarks`

### Redshift Setup
- Set the following environment variables for Redshift:
  - `PGHOST`: This is the endpoint for the Redshift database
  - `PGPORT`: This is the port the database listens on. Redshift default is 5439.
  - `PGUSER`: This is your Redshift database user.
  - `PGDATABASE`: This is database name where your external schemas are created in. This is NOT the database created for the data share. I suggest using the default "dev" database.

Example:
```
export PGUSER="awsuser"
export PGHOST="redshift-cluster-1.xxxxxxxxxxxx.us-east-1.redshift.amazonaws.com"
export PGPORT="5439"
export PGDATABASE="dev"
```
- Configure the .pgpass file to store your database credentials.

Example:
```
redshift-cluster-1.xxxxxxxxxxxx.us-east-1.redshift.amazonaws.com:5439:*:user1:user1P@ss
```

## Benchmark Script Setup
- On your Jumpbox, `cd /home/ec2-user/redshift-benchmarks/adx-tpc-h/`
- Configure the variables for the scripts in `tpch_variables.sh`.

Here are the variables you can set:
- `EXT_SCHEMA="tpch"`: This is the name of the schema created that has the TPC-H dataset.
- `EXPLAIN="false"`: If set to false, queries will execute. If set to true, queries will generate explain plans rather than actually running. Each query will be logged in the log directory. Default is false.
- `MULTI_USER_COUNT="5"`: 0 to 20 concurrent users will execute the queries. The order of the queries were set with dsqgen. Setting to 0 will skip the multi-user test. Default is 5.

## Executing the Benchmark Script
- SSH to the Jumpbox as `ec2-user`
- If your ec2 ssh session is interrupted then your script can encounter `Broken pipe` error and get killed
- Execute: `screen` to start a new screen session
- Execute: `cd /home/ec2-user/redshift-benchmarks/adx-tpc-h/`
- Execute the benchmark: `./rollout.sh > rollout.log 2>&1 &`
- Execute: `CTRL+a` then `d` to disconnect from screen session while it runs in background
- Execute: `ps aux | grep screen` to check existing screen sessions
- Execute: `screen -r` to resume screen session
- You can use `tail -f /home/ec2-user/redshift-benchmarks/adx-tpc-h/rollout.log` to monitor progress
- Once complete, the log file will show the results of the benchmark

## Example output
```
               total_queries                
--------------------------------------------
 0 hour(s), 5 minute(s), 26.08500 second(s)
(1 row)

          total_concurrent_queries          
--------------------------------------------
 0 hour(s), 6 minute(s), 53.05400 second(s)
(1 row)

                 total_time                  
---------------------------------------------
 0 hour(s), 12 minute(s), 19.13900 second(s)
(1 row)

INFO: Done!
```

### Notes
- enable_result_cache_for_session is set to false so that query results are not cached. This gives a better representation of query performance.
- The search_path user attribute is set to the EXT_SCHEMA value provided in the tpcds_variables.sh file.

## Cleanup
When you are finished with the evaulation of Redshift Serverless with TPC-H, you can delete the resources. If you used the CloudFormation template, you can simply delete the Stack to remove all of the resources. If you provisioned the resources manaually, you will need to also manually delete the Jumpbox, the Redshift Serverless Workgroup, and the Redshift Serverless Namespace.
