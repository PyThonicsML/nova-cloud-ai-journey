# 🚀 Nova Cloud AI Journey: AWS VPC, EC2, Docker & ECS Project

Welcome to one of the cornerstone projects in my **Nova Cloud AI Journey** — a hands-on, real-world series designed to *prove* that I don’t just study… I build. Over the past 3 days (9+ hours per day), I went step-by-step through foundational cloud concepts, containerization, and AWS deployment.

This project includes:
1. Creating a custom AWS VPC with subnets and security groups
2. Launching and SSH-ing into a Linux EC2 instance and installing a web server
3. Building a Docker container, pushing it to Docker Hub, and deploying it to AWS ECS

---

## 🔧 PART 1: AWS VPC SETUP

### Goal:
Build a clean, isolated network in AWS to control traffic flow and security for your infrastructure.

### Steps:
1. **Log into AWS Console**  
   Navigate to **VPC** service.

2. **Create a VPC**
   - CIDR block: `10.0.0.0/16`
   - Name tag: `nova-vpc`

3. **Create Subnets**
   - **Public Subnet**: `10.0.1.0/24` (for public access)
   - **Private Subnet**: `10.0.2.0/24` (for backend/secured instances)

4. **Create Internet Gateway**
   - Attach to `nova-vpc` so your public subnet has outbound access.

5. **Create Route Table**
   - Associate public subnet with a route to the Internet Gateway.
   - Associate private subnet with NAT (optional later).

6. **Add Security Groups**
   - Allow SSH (port 22) and HTTP (port 80) to the EC2 instance.

---

## 🖥 PART 2: EC2 INSTANCE SETUP

### Goal:
Spin up a Linux machine on AWS and interact with it via the command line.

### Steps:
1. **Launch EC2 Instance**
   - Amazon Linux 2 AMI
   - t2.micro (Free tier)
   - Place in public subnet
   - Assign public IP
   - Attach the security group (SSH & HTTP)

2. **Download Key Pair**
   - Use `.pem` file and run:
     ```bash
     chmod 400 my-key.pem
     ssh -i "my-key.pem" ec2-user@<your-ec2-ip>
     ```

3. **Install Web Server**
   ```bash
   sudo yum update -y
   sudo yum install -y httpd
   sudo systemctl start httpd
   sudo systemctl enable httpd


🐳 PART 3: Docker Container + ECS Deployment
Goal:
Build a containerized app locally, push it to Docker Hub, and deploy it on AWS ECS.

Local Setup:
Install Docker Desktop

Make sure Docker is running locally

Create app.py

python
Copy
Edit
from http.server import SimpleHTTPRequestHandler, HTTPServer

PORT = 8000
Handler = SimpleHTTPRequestHandler
httpd = HTTPServer(("0.0.0.0", PORT), Handler)
httpd.serve_forever()
Create Dockerfile

dockerfile
Copy
Edit
FROM python:3.12-slim
WORKDIR /app
COPY . .
CMD ["python", "app.py"]
Build & Push to Docker Hub

bash
Copy
Edit
docker build -t your-dockerhub-username/your-image-name .
docker login
docker push your-dockerhub-username/your-image-name
🔒 Replace your-dockerhusername/your-image-name with your own Docker Hub details.

Deploy on ECS:
Go to AWS ECS → Create Cluster

Choose EC2 or Fargate (Fargate recommended for beginners)

Define Task Definition:

Use Docker image from your Docker Hub

Set container port to 8000

Deploy the service and test the public endpoint.