# FastAPI on Azure Container App with Terraform

This project demonstrates deploying a simple FastAPI application using a Docker image hosted on Docker Hub, provisioned through Azure Container App using Terraform.

---

## Task Requirements

- Deploy to **Azure Container App**
- Create the following resources:
  - Resource Group
  - Container App Environment
  - Container App
- Use a public Docker Hub image:
  - `tiangolo/uvicorn-gunicorn-fastapi:python3.9`
- Container must be **publicly accessible**

---

## What I Did

I created a simple FastAPI application that returns a JSON message:

```json
{ "message": "Hello from Azure via my own FastAPI app!" }
```

The application is located in `app/main.py`.

I wrote a custom `Dockerfile`, built and pushed the image to my Docker Hub repository using the following commands:

```bash
docker login
docker build -t annahurtovenko/hello-azure:v1 .
docker push annahurtovenko/hello-azure:v1
```

Then, I created a Terraform project with the following structure:

```text
.
├── app/                         # FastAPI application
│   └── main.py
├── Dockerfile                   # Docker container for the app
├── terraform/                   # Infrastructure as Code
│   ├── modules/
│   │   └── container-app/
│   │       ├── main.tf
│   │       ├── variables.tf
│   │       └── outputs.tf
│   └── environments/
│       ├── personal/            # Dev test deployment
│       │   ├── main.tf
│       │   ├── variables.tf
│       │   ├── personal.tfvars
│       │   └── outputs.tf
│       └── prod/                # Production-ready config
│           ├── main.tf
│           ├── variables.tf
│           ├── prod.tfvars
│           └── outputs.tf
├── .gitignore
└── README.md
```

After writing the Terraform code, I authenticated with Azure and executed the following commands:

```bash
az login
terraform init
terraform validate
az provider register --namespace Microsoft.App
terraform plan -var-file="prod.tfvars"
terraform apply -var-file="prod.tfvars"
```

This successfully deployed the FastAPI application to Azure Container App. The container is publicly accessible via HTTPS, and the application returns the required JSON response when accessed.

## Live Example
You can open the deployed app directly in the browser using the output URL provided by Terraform, for example:

[https://hello-azure--example-region.azurecontainerapps.io/](https://hello-azure--example-region.azurecontainerapps.io/)
