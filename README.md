# Scalable Cloudapplications
# Assignment 2
# AWS CICD Pipeline with an Nginx webpage

This is an assignment partially done as scripts and infrastructure as code for a scalable cloudapplications course.


Run the run.sh file in git bash and press a key to continue the scripts.
Press any key to continue after verifying the steps have been done.

# Finalize with AWS GUI
Now we’ve reached the part where we can finalize the project utilizing the amazon AWS GUI. Unless mentioned otherwise, keep default.

# ECS Cluster Task Definition:
1. Create new task definition
2. Task Definition Family name: DockerDemoTask
3. Launch type: AWS Fargate
4. Task Execution Role: Create new role
5. Container details name: DockerDemoContainer
6. Container Image URI: can be found at ECR. Should be something like this:
   47XXXXXXXX12.dkr.ecr.eu-west-1.amazonaws.com/dockerdemo

Click Create.


# ECS Cluster
Create cluster
Name: DockerDemoCluster

Within the Cluster you should see the option to create a service:

1. ECS Cluster service
2. Family: DockerDemoTask
3. Service Name: DockerDemoServiceLB
4. Desired tasks: 3
5. Under Networking tab: Create a new security group that allows HTTP port 80 - see image:
6. Load balancing: Application Load Balancer
7. Load balancer name: DockerDemoALB
8. Target group name: DockerDemoTG

When it’s created and done you should now be able to reach your simple webpage by going to the http://DNS_URL  
You can find the DNS url under EC2 load balancers page. **Make sure that you go to the http and not https.**

# AWS CodePipeline
1. PipelineName: DockerDemoPipeline
2. Source provider: AWS CodeCommit
3. Repository name: dockerdemo
4. branch: main
5. Build Provider: AWS CodeBuild
6. Project Name: BuildDockerDemo
7. Deploy Provider: Amazon ECS
8. Cluster Name: DockerDemoCluster
9. Service Name: DockerDemoServiceLB

# Utilizing the CodePipeline
We can now update the index.html file - Either directly in our code editor of choice and push locally to Codecommit repo, or directly from the AWS Codecommit repo.  
After pushing and updating the index file the CodePipeline will build a new image that we will be able to view on the same DNS. 

## Be patient! It can take some minutes.
