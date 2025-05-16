# A Simple TODO APP with Full DevOps Integration

![image](/assets/1.png)
![image](/assets/0.png)
![image](/assets/2.png)

---

## Project Overview

This repository was originally cloned from [bytebane/TodoApp](https://github.com/bytebane/TodoApp.git) to serve as a foundation for applying full DevOps tools and practices while enhancing the application's user interface and functionality.


## Application Features

- User authentication: ability to sign up and sign in.
- Create, edit, and delete tasks dynamically.
- Simple, clean, and intuitive UI built with EJS templates.
- Persistent task storage using MongoDB.
  
**Enhancements:**
- Mark tasks as "Done" with automatic strikethrough.
- Display creation dates for each task.
- Responsive design with smooth hover animations.
- Improved overall layout and alignments.

---

## Technologies

- Database
  - MongoDB
- Backend
  - Node.js
- Server
  - Express.js
- Frontend
  - EJS
  - JS
  - CSS

---

## DevOps Integration
![image](/assets/Pipeline.png)
---
# Running the Complete DevOps Stack

```bash
# Clone the project repository
git clone https://github.com/kyrilloswahid/ITC_ONL2_SWD1_S2_group1.git
cd ITC_ONL2_SWD1_S2_group1

# 1. Running Docker Containers
sudo systemctl start docker
docker-compose up -d

# 2. Running Kubernetes (K8s)
kubectl version --client
kubectl apply -f .
kubectl get deployments
kubectl get services

# 3. Running Terraform
cd terraform
terraform init
terraform plan
terraform apply -auto-approve

# 4. Running Ansible
cd ansible
ansible --version
ansible-playbook -i inventory playbook.yml

# 5. Running Ngrok and Auto-Updating Webhook
tmux
ngrok http 8080
cd ..
chmod +x autoupdate_webhook.sh
./autoupdate_webhook.sh

# 6. Triggering GitHub Push (Webhook Trigger)
git add .
git commit -m "Updated changes"
git push
# Jenkins Triggered
```
---
