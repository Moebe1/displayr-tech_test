# Displayr Tech Test Submission
The tech test has the following requirements:

**The Goal**
Using infrastructure as code, set up a hello world web server in AWS/Azure, and write a script for the server health check.

**Must achieve:**
- You will need an AWS/Azure account for this task. You are expected to use free-tier only.
- You can use any infrastructure as code tool you like.
- The code must be able to run anywhere.
- Provide a script to run health checks periodically and externally.
- Provide documents of the code.
- Automate as much as possible. 
- The code must be stored in a source control tool of your choice and a link must be provided

# Documentation
The repository contains IaC using Terraform to provision and deploy an EC2 instance to your AWS account and create a hello world web page.



# Instructions:

1. Download the repository to your computer

2. Ensure that you have the following installed and configured on your machine:
  
  a. Terraform
  
3. Open **aws_variables.tfvars** using a text editor

    a. Enter value for **aws_access_key**
    
    b. Enter value for **aws_secret_key**
    
    c. Enter value for the desired AWS region (default= ap-southeast-2, Sydney)
    
    d. Enter a value for the instance type (default = t3.micro)
  
4. **Variables.tf** contains other variables that may be edited if you wish to change certain defaults e.g. VPC CIDR, Default Region, AZs etc

5. The associated Security Groups may be editied by changing the **sg.tf** file

6. **main.tf** contians the resource definitions, the AMI ID is currently hardcoded for Ubuntu 20.04 LTS on line 43
   
   Uncomment line 58 to trigger a destroy and replace for the EC2 instance
   
# Running the Code (Manual)

1. Initialize Terraform backend
```
terraform init
```
2. Make the following scripts executable
```
chmod +x ready_check.sh periodic_hc.py
```
3. Terraform Plan using aws_variables.tfvars
```
terraform plan -var-file aws_variables.tfvars
```
4. Terraform Apply using aws_variables.tfvars
```
terrafrom apply -var-file aws_variables.tfvars
```
5. Start the readiness checking script, it will let you know when the site is reachable and print the URL
```
./ready_check.sh
```
6. Once site is ready, start the Health Check Python script (Note: PythonPing requires root)
```
sudo ./periodic_hc.py
or
sudo python3 periodic_hc.oy
```
 * **Note**: Sever IP, Public URL, Instance ID etc will be printed when the script completes.

5. Destory the Infrastructure
```
terraform destory -var-file aws_variables.tfvars
```

# Alternate method: Using the deploy.sh and destroy.sh shell scripts (Fully Automated):

This script automates the deployment process and will run terraform appy -var-file aws_variables.tfvars --auto-approve
* **NOTE**: Please run Terraform init and Terraform Plan manually before using this script to ensure that correct resources are being deployed.
* **Important*: Please mark the following files as executable prior to running
```
chmod +x deploy.sh destroy.sh ready_check.sh periodic_hc.py
```
To start the deployment, run the following script as admin
```
./deploy.sh
```
This script will run Terraform Apply with Auto Approve. When Terraform has finished executing the shell script will then run healthcheck.sh which is a site/webserver readiness check and will inform the user when the site is available and display a link. Ctrl + Click to open the hello world webpage.

The script will then wait for the user to press enter and start the periodic health check script.

The resourcces can be destroyed using the destroy.sh shell sciript.
```
./destroy.sh
```
# Periodic Health Check Script

The repository contains a python script called periodic_hc.py
This script uses the output from Terraform to get the EC2 instance URL and IP address and does the following checks:

  a. Ensures that the terraform output is available. If not, reminds user to deploy first.
  
  b. Pings the server and displays the result, single ping
  
  c. Computes the hash of the page and alrts the user if the Hash has changed. E.g. Error page, defacement etc.

* **Note**: This script must be run as Administrator since the pyping library requires access to the network interface.
**Run Instructions**

1. Ensure that you have Python3, PIP3 installed and mark the script as executable by using chmod +x:
```
chmod +x periodic_hc.py
```
2. Install the required libraries
```
pip3 install -r requirements.txt
```
3. Run the script as administrator
```
sudo python3 periodic_hc.py
or
sudo ./periodic_hc.py
```

When the script executes, it will first get the Server URL and Server IP address from terraform output as raw.

The script will then attempt to open the the URL using a get request from Urllib3

The script will then Ping the server to ensure it is reachable and display the results on screen.

Next, the script will compute the hash, wait a pre-determined period and re-compute the hash and compare that with the previous value. If the hash is the same or if it has changed will be displayed on screen.

The periodicity of the script can be altered by changing the values for time.sleep() in the script.

Exit the script by pressing 
```
Ctrl+C
```

Developed using WSL2 for Windows and tested using MacOS

