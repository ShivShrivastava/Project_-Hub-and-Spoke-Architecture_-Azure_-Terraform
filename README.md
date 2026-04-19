Bhai sahi direction me ja raha hai 🔥 — bas maine tera README clean, professional aur image-integrated version me update kar diya hai.
Ye **final recruiter-ready version** hai 👇 (direct copy-paste kar de)

---

# 🚀 **README.md – Azure Hub & Spoke Architecture using Terraform**

```markdown
# 🌐 Azure Hub and Spoke Architecture using Terraform

This project demonstrates the implementation of a **Hub and Spoke network topology in Microsoft Azure** using **Terraform (Infrastructure as Code)**.

The architecture is designed to provide **centralized security, scalable networking, and workload isolation**, following Azure best practices.

---

## 📌 📖 Overview

The **Hub-Spoke model** is a widely adopted Azure networking pattern where:

- The **Hub VNet** acts as a central point for:
  - Security (Firewall)
  - Connectivity (VPN Gateway, Bastion)
  - Shared Services
- The **Spoke VNets** host application workloads

All traffic between spokes and external networks flows through the Hub, enabling **centralized control and monitoring**.

---

## 🏗️ Architecture Diagram

<p align="center">
  <img src="./hs.gif" alt="Hub Spoke Architecture" width="800"/>
</p>

<p align="center">
  <em>Figure: Azure Hub & Spoke Architecture with centralized security</em>
</p>

---

## ⚙️ Technologies Used

- ☁️ Microsoft Azure
- 🏗️ Terraform (IaC)
- 🌐 Azure Virtual Network (VNet)
- 🔥 Azure Firewall
- 🔐 Azure Bastion
- 🔁 VNet Peering
- 🛣️ Route Tables (UDR)
- 🛡️ Network Security Groups (NSG)

---

## 📂 Project Structure

```

.
├── main.tf
├── variables.tf
├── outputs.tf
├── provider.tf
├── modules/
│   ├── hub/
│   ├── spoke/
│   └── networking/
├── terraform.tfvars
└── README.md

````

---

## 🧠 Key Features

✅ Centralized Hub Network  
✅ Multiple Spoke Networks  
✅ Secure VNet Peering  
✅ Controlled Traffic Flow via Firewall  
✅ Infrastructure as Code (Terraform)  
✅ Modular & Reusable Code Design  
✅ Scalable Architecture  

---

## 🌐 Network Design

| Component | CIDR |
|----------|------|
| Hub VNet | 10.50.0.0/16 |
| Spoke VNet | 10.51.0.0/16 |

> CIDR ranges are non-overlapping to ensure proper routing and scalability.

---

## 🔐 Security Design

- All outbound traffic routed via **Azure Firewall**
- **NSGs** applied at subnet level
- No direct internet exposure for spoke workloads
- Bastion used for secure VM access

---

## 🚀 Deployment Steps

### 1️⃣ Clone Repository

```bash
git clone https://github.com/ShivShrivastava/Project_-Hub-and-Spoke-Architecture_-Azure_-Terraform.git
cd Project_-Hub-and-Spoke-Architecture_-Azure_-Terraform
````

---

### 2️⃣ Initialize Terraform

```bash
terraform init
```

---

### 3️⃣ Validate Configuration

```bash
terraform validate
```

---

### 4️⃣ Plan Deployment

```bash
terraform plan
```

---

### 5️⃣ Apply Infrastructure

```bash
terraform apply -auto-approve
```

---

## 📊 Terraform Plan Output

<p align="center">
  <img src="./hub_spoke_47.png" alt="Terraform Plan Output" width="900"/>
</p>

<p align="center">
  <em>Figure: Terraform execution plan showing resources to be created</em>
</p>

---

## 🧪 Verification

* Check VNet peering in Azure Portal
* Verify traffic routing via Firewall
* Test connectivity between spokes

---

## 📈 Use Cases

* Enterprise Landing Zone
* Multi-tier application deployment
* Secure hybrid cloud connectivity
* Dev/Test/Prod environment isolation

---

## 🧩 Future Enhancements

* Azure VPN Gateway / ExpressRoute
* Private Endpoints
* Azure Kubernetes Service (AKS)
* CI/CD pipeline integration (Azure DevOps / GitHub Actions)
* Monitoring with Log Analytics

---

## 🤝 Contributing

Feel free to fork the repository and submit pull requests.

---

## 📜 License

This project is for learning and demonstration purposes.

---

## 👨‍💻 Author

**Shiv Shrivastava**
DevOps Engineer | Azure | Terraform | Kubernetes

---

## ⭐ Support

If you found this project helpful, please ⭐ the repository!

```

---

## 🔥 Final Touch (Important)

Before pushing:
- ✅ `hs.gif` and `hub_spoke_47.png` repo root me hone chahiye  
- ❌ `:contentReference` wali line hata di (wo galat thi)  
- ✅ Structure clean + recruiter friendly  

---

Agar tu next level jaana chahta hai:
- 🔥 Terraform badge + Azure badge add kar dete hain  
- 🔥 GIF animation bana dete hain architecture ka  
- 🔥 Repo ko “Featured Project” level polish kar dete hain  

bol bhai 😎
```
