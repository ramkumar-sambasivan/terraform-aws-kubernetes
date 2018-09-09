# terraform-aws-kubernetes

#### Pre-Requisite:
Install the below tools in the client machine 

[Terraform](https://www.terraform.io/intro/getting-started/install.html)

[Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)


#### Publish Docker Image
Build the pre created WAR file into a docker image and publish the image to ECS registry to be consumed by Kubernetes while deployment.

~~~
docker build -t ecs_repo_name/image_name:v1.0 .
docker push
~~~

#### Kubenretes cluster creation

Create a EKS cluster using the terraform scripts provided. All the files are located inside deployment/terraform directory.

***Note***: To change the state backend location, modify the tf-backend.tf file accordingly.

~~~
# Initilize the directory to download all the required plugins and set up the backend state store
terraform init

# Deploy the EKS infrastructure
terraform plan
terraform apply
~~~

Now the worker nodes needs the configurations to connect to master. So, run ``` terraform output config-map-aws-auth ``` and save the configuration into a file, e.g. config-map-aws-auth.yaml.

Run ``` kubectl apply -f config-map-aws-auth.yaml ```

Finally validate if the worker nodes are joining the cluster via: ``` kubectl get nodes --watch ```

#### Deploy application

Once the cluster is up and running, deploy the Nginx controller to act as Ingress application with a default backend. For reference about Ingress, refer to kubenretes [docs](https://kubernetes.io/docs/concepts/services-networking/ingress/#ingress-controllers)

~~~
kubectl apply -f deployment/kubernetes/nginx-ingress-backend.yml
kubectl apply -f deployment/kubernetes/nginx-ingress-controller.yml
~~~

Once the Ingress controller has been deployed, the helloworld application can now be deployed. Modify the Image details in helloworld-app.yml before deployment. 

~~~
kubectl apply -f deployment/kubernetes/helloworld-app.yml
kubectl apply -f deployment/kubernetes/helloworld-ingress.yml
~~~

#### Destroying the cluster

To destroy the whole cluster just run ```terraform destroy ```. It will destroy all the components being created.