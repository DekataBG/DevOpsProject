### Start the container: 
1. Make sure to be in the directory where `Dockerfile` is
2. `docker build . -t project:1.0`
3. `docker run -d -p 80:8000 --name project project:1.0`
4. `curl localhost:80` and `curl localhost:80/hostname`

### To access the website created with terraform:
`http://ec2-18-192-38-105.eu-central-1.compute.amazonaws.com/`