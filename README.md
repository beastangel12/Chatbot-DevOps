# Chatbot-DevOps — Project Skeleton

This archive contains a complete DevOps assignment skeleton (Vagrant, Terraform, Docker, Jenkinsfile, Kubernetes, monitoring, backup script).
**No AWS credentials are included**. You must configure your AWS CLI locally before running Terraform.

## Important Security Notice (READ NOW)
You must **delete** any AWS Access Keys that were accidentally exposed. Do **not** paste secrets into files or chat. See next section for steps.

---

## 1) Immediate steps if you exposed AWS keys
1. Open AWS Console → IAM → Users → *select your user* → *Security credentials* → **Access keys**.  
   - Locate the exposed key and **Delete** it immediately.
2. Create a **new** Access Key (or better: create a new IAM user with limited permissions for this project).
3. Run `aws configure` locally and paste the new Access Key ID and Secret Access Key.
4. Test: `aws sts get-caller-identity`

---

## 2) How this project uses AWS
Terraform will use the AWS credentials configured in your local environment (via `aws configure`) or `~/.aws/credentials`. The Terraform provider in this project is configured to use the **default profile** and region `us-east-1`. Edit `terraform/main.tf` if you prefer another region or profile.

---

## 3) Quick start (local testing with Vagrant)
Requirements:
- Vagrant
- VirtualBox
- Docker (for local testing)
- git

Commands:
```bash
# unzip and enter folder
cd Chatbot-DevOps

# inspect files and edit variables if needed
# for Vagrant:
cd vagrant
vagrant up

# for Terraform (after configuring AWS CLI)
cd terraform
terraform init
terraform apply -auto-approve
```

---

## 4) GitHub & Docker Hub placeholders
- GitHub username used in README examples: **beastangel12**
- Docker Hub username used in pipeline examples: **angelbista**

Replace these with your own values in files if necessary.

---

## 5) Next steps after you secure keys
- Tell me when you have revoked the exposed key and configured new keys.
- I will then help you run Terraform, set up Jenkins, and deploy the app.

