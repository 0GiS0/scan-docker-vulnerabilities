# Generate docker image and run the container
docker build -t apache .

# Run the container
docker run -p 8080:80 apache

# Check vulnerabilities
docker scout quickview
docker scout cves apache:latest
docker scout recommendations apache:latest

# Trivy
trivy image apache 

# Snyk
snyk auth
snyk container test apache
snyk container test apache --path=Dockerfile

# Checkov
checkov --framework=dockerfile -f Dockerfile

# Grype
grype apache