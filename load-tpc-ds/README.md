# Overview
The load-tpc-ds Benchmark Scripts are intended to be used on a Redshift cluster (Provisioned or Serverless) to load and execute TPC-DS derived scripts using Redshift rsql. This benchmark uses data and SQL generated by the [Cloud Data Warehouse Benchmark Derived from TPC-DS 2.13](https://github.com/awslabs/amazon-redshift-utils/tree/master/src/CloudDataWarehouseBenchmark/Cloud-DWB-Derived-from-TPCDS) benchmark. This benchmark extends the original project with added functionality.

## Automated setup: CloudFormation
A simple CloudFormation template, `rsql_serverless.json`, is included in this repo to simplify the deployment of resources needed for the demo. The template deploys the following resources in your default VPC:
- EC2 instance with Amazon Linux 2
- Redshift Serverless Workgroup
- IAM Role with permissions needed to use and load data with Redshift Serverless
- Security Group with inbound port 22 (ssh) and connectivity between the EC2 instance and the Redshift Serverless Workgroup
- This Github repo is downloaded in the EC2 instance
- Amazon Redshift rsql installed and configured

Note: Using the CloudFormation template is optional. You can execute the demo by manually provisioning the EC2 instance and Redshift Serverless resources.

### Template parameters
- `Stack` : CloudFormation term used to define all of the resources created by the template.
- `KeyName` : This is the name of an existing Key Pair. If you don't have one already, create a Key Pair which is used to SSH to the EC2 instance.
- `SSHLocation` : The CIDR mask for incoming connections to the EC2 instance. The default is 0.0.0.0/0 which means any IP address is allowed to SSH to the EC2 instance provided the client has the Key Pair private key. You may choose to limit this to a smaller range of IP addresses if you like.
- `RedshiftCapacity` : This is the number of RPUs for the Redshift Serverless Workgroup. The default is 128 and recommended for analyzing the larger TPC-DS datasets.

## Manual setup
If you choose not to use the CloudFormation template, deploy the EC2 instance and Redshift Workgroup with the following instructions.

### Redshift 
- Deploy Redshift Serverless workgroup 
- Take note of the Region 

### Linux EC2 instance setup
- Deploy a VM in the same AWS Region as your Redshift database using the Amazon Linux 2 AMI 
- The Amazon Linux 2 AMI (64-bit x86) with the t2.medium instance type is an inexpensive and tested configuration
- Add the Security Group configured for your Redshift database to your EC2 instance
- Install [rsql](https://docs.aws.amazon.com/redshift/latest/mgmt/rsql-query-tool-getting-started.html)
- Download this Github repo. `git clone --depth 1 https://github.com/aws-samples/redshift-benchmarks /home/ec2-user/redshift-benchmarks`

### Redshift rsql 
- Configure the rsql DSN on your EC2 instance. See the [rsql](https://docs.aws.amazon.com/redshift/latest/mgmt/rsql-query-tool-getting-started.html) documentation for guidance.
- Be sure that the DSN value you provide matches the DSN variable in the `tpcds_variables.sh` file which is covered below.

## Benchmark configuration
- On your EC2 instance, `cd /home/ec2-user/redshift-benchmarks/load-tpc-ds/`
- Configure the variables for the scripts in `tpcds_variables.sh`.

- `DSN="dev"` : The value for the DSN you are testing with. For manual configurations, be sure this matches the DSN you created.

- `SCHEMA_NAME="tpcds"` : The name of the schema that will be used by Redshift. Note: This schema will be dropped if it already exists.

- `EXPLAIN="false"` : Queries will generate explain plans rather than actually running. Each query will be logged in the log directory.

- `MULTI_USER_COUNT="5"` : `n` concurrent users will execute the queries. The order of the queries are set randomly at runtie. Setting to 0 will skip the multi-user test.

- `SCALE="3TB"` : Scale of the test. Available values are: 10GB, 100GB, 1TB, 3TB, 10TB, 30TB, 100TB.

- `SOURCE_BUCKET="redshift-downloads/TPC-DS/2.13"` : Source bucket where the generated data resides. This should not be changed.

- `TEMP_BUCKET="jgrcloud-temp"` : You must update this to a bucket in your account! This is the name of the temporary bucket where files are staged to load into Redshift. This bucket is removes the temporary files at the end of the test.

## Executing the Benchmark Script
- SSH to the EC2 instance as `ec2-user`
- Execute: 

```
cd /home/ec2-user/redshift-benchmarks/load-tpc-ds/
./rollout.sh > rollout.log 2>&1 &
```

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

## Connecting with rsql
Amazon Redshift rsql requires providing a DSN to connect to the database which is configured in the `.odbc.ini` file in the `ec2-user` home directory. The CloudFormation template configures this for you and the DSN is `dev`. Connecting is a simple process that looks like this:
```
rsql -D dev
```
Amazon Redshift rsql is a fork of [PostgreSQL psql](https://www.postgresql.org/docs/current/app-psql.html) so most of the commands remain the same. 
