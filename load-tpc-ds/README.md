# Overview
The load-tpc-ds Benchmark Scripts are intended to be used on a Redshift cluster (Provisioned or Serverless) to load and execute TPC-DS derived scripts using Redshift rsql. This benchmark uses data and SQL generated by the [Cloud Data Warehouse Benchmark Derived from TPC-DS 2.13](https://github.com/awslabs/amazon-redshift-utils/tree/master/src/CloudDataWarehouseBenchmark/Cloud-DWB-Derived-from-TPCDS) benchmark. This benchmark extends the original project with added functionality.


## Automated Setup: CloudFormation
A simple CloudFormation template, `rsql_serverless.json`, is included in this repo to simplify the deployment of resources needed for the demo. The template deploys the following resources in your default VPC:
- Jumpbox (EC2 instance) with the latest version of Amazon Linux 2
- Redshift Serverless Workgroup
- IAM Role with permissions needed to use and load data with Redshift Serverless
- Security Group with inbound port 22 (ssh) and connectivity between the Jumpbox and the Redshift Serverless Workgroup
- This Github repo is downloaded in the Jumpbox
- Amazon Redshift rsql installed and configured

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
- Install [rsql](https://docs.aws.amazon.com/redshift/latest/mgmt/rsql-query-tool-getting-started.html)
- Download this Github repo. `git clone --depth 1 https://github.com/aws-samples/redshift-benchmarks /home/ec2-user/redshift-benchmarks`


### Redshift Setup
- Set the following environment variables for Redshift:
  - Configure the rsql DSN. See the [rsql](https://docs.aws.amazon.com/redshift/latest/mgmt/rsql-query-tool-getting-started.html) documentation for guidance.

## Benchmark Script Setup
- On your Jumpbox, `cd /home/ec2-user/redshift-benchmarks/load-tpc-ds/`
- Configure the variables for the scripts in `tpcds_variables.sh`.

### DSN="dev"
The value for the DSN you are testing with.

### SCHEMA_NAME="tpcds"
The name of the schema that will be used by Redshift.

### EXPLAIN="false"
Queries will generate explain plans rather than actually running. Each query will be logged in the log directory.

### MULTI_USER_COUNT="5"
`N` concurrent users will execute the queries. The order of the queries are set randomly at runtie. Setting to 0 will skip the multi-user test.

### SCALE="3TB"
Scale of the test. Available values are: 10GB, 100GB, 1TB, 3TB, 10TB, 30TB, 100TB.

### SOURCE_BUCKET="redshift-downloads/TPC-DS/2.13"
Source bucket where the generated data resides.

### TEMP_BUCKET="jgrcloud-temp"
Note: You must update this to a bucket in your account!
This is the name of the temporary bucket where files are staged to load into Redshift. This bucket is removes the temporary files at the end of the test.

## Executing the Benchmark Script
- SSH to the Jumpbox as `ec2-user`
- Execute: `cd /home/ec2-user/redshift-benchmarks/load-tpc-ds/`
- Execute the benchmark: `./rollout.sh > rollout.log 2>&1 &`
- You can use `tail -f rollout.log` to monitor progress
- Once complete, the log file will show the results of the benchmark
- Example output:
```
                 total_load                 
--------------------------------------------
 0 hour(s), 2 minute(s), 20.14000 second(s)
(1 row)

               total_queries                
--------------------------------------------
 0 hour(s), 2 minute(s), 37.39300 second(s)
(1 row)

          total_concurrent_queries          
--------------------------------------------
 0 hour(s), 1 minute(s), 28.96200 second(s)
(1 row)

                 total_time                 
--------------------------------------------
 0 hour(s), 6 minute(s), 26.49500 second(s)
(1 row)
```