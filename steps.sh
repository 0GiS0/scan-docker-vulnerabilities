# Generate docker image and run the container
docker build -t apache .

# Run the container
docker run -p 8080:80 apache

# Trivy
trivy image apache 
trivy image apache --exit-code 0 --format sarif > trivy-results.sarif

# Snyk
snyk auth
snyk container test apache

# Checkov
checkov --framework=dockerfile -f Dockerfile -o sarif

# Grype
grype docker:apache

# Create Azure Container Registry
RESOURCE_GROUP="scan-docker-vulnerabilities"
LOCATION="westeurope"
ACR="scandemo"

# Create resource group
az group create --name $RESOURCE_GROUP --location $LOCATION

# Create ACR
az acr create --resource-group $RESOURCE_GROUP --name $ACR --sku Basic

# Build and push image to ACR
az acr build --registry $ACR --image apache:latest .