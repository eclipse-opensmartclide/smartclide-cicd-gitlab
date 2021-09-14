# SmartCLIDE-CI/CD Gitlab
[![N|Solid](https://i2.wp.com/smartclide.eu/wp-content/uploads/2020/02/cropped-SmartClideRGBColor-1.png?w=120&ssl=1)](https://smartclide.eu/)
<img width="70" alt="gitlab" src="https://about.gitlab.com/images/press/logo/png/gitlab-logo-gray-stacked-rgb.png">

SmartCLIDE Gitlab initialization and containerization.<br>

This is a <b>Work In Progress</b> research that focuses on different ways to automate the deployment, initialization and containerization of gitlab instance.<br>
This gitlab instance will be part of the internal SmartCLIDE framework.

<b>Below is a showcase of different ways of setting up and running a gitlab instance.</b>
## Docker Compose
This is a recommended way to get up and running quickly in a localhost environment that domain name resolution is not possible.<br>
A simple example would be the localhost host. For other custom host names dont forget to include them in /etc/hosts file.<br>
Self-sign certificates will be generated for the hostname by gitlab's let's encrypt, so keep in mind we cannot use an IP address as hostname.

#### Install
Update the environment variables in .env file and run the following command.<br>
```sh
docker-compose up
```
This will start a gitlab container with registry enabled and a gitlab-runner container.<br>
Below is the initial root password
```sh
cat /srv/gitlab/config/initial_root_password
```
#### Register Gitlab-runner
To register a gitlab runner in the gitlab instance fill the runner registration token and the gitlab host variables in <b>.env</b> file and run the following command.<br>
The variables can be found at mygitlab.com/admin/runners
```sh
# Must cd to scripts first and not run the script from outside the folder.
user@local:~$ cd scripts
user@local:~/scripts$ ./gitlab-runner-register.sh
```
## Helm
Helm is the official recommended way of installing gitlab in the Kubernetes.<br>
Helm will install gitlab packages(charts) in the Kubernetes cluster.<br>
Helm is also very configurable. Take a look here(https://docs.gitlab.com/charts/charts/) for configuration options and here(https://docs.gitlab.com/charts/charts/globals.html) for globals.<br>

The downside of helm is that requires a valid DNS record.<br>
Based on the info taken from https://docs.gitlab.com/charts/quickstart/ <br> 
```You can not use example.com.
You’ll need to have access to a internet accessible domain to which you can add a DNS record.
This can be a sub-domain such as poc.domain.com,
but the Let’s Encrypt servers have to be able to resolve the addresses to be able to issue certificates.
```

#### Install
To Helm install gitlab update the values.yaml in script folder and run the following command.
```sh
user@local:~$ cd scripts
user@local:~/scripts$ ./helm.sh
```

## Kubernetes yaml
This is an experimental way to install Gitlab in a Kubernetes cluster by defining k8s custom yaml files.<br>
This is a WIP so it needs a lot of tinkering of YAML files before applying them to kubectl.
#### Install
```sh
user@local:~$ kubectl apply -f gitlab-deployment.yaml
user@local:~$ kubectl apply -f gitlab-service.yaml
```

## Gitlab initialization
gitlab SmartCLIDE initialization scripts such as initial SmartCLIDE groups, users, projects and other.

#### Gitlab Groups init
To initialize the gitlab instance with a group structure similar to section 4.1.1 from D3.1 Early SmartCLIDE Cloud IDE Design,
update the .env variables(TOKEN and GITLAB_HOST) and execute the following script.
```sh
user@local:~$ cd scripts
user@local:~/scripts$ ./init-gitlab-groups.sh
```

