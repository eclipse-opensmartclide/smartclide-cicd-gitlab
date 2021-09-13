#!/bin/bash
# This script initilizes gitlab with the required SmartCLIDE groups.
# This is done by using gitlab API with curl command.
# The token and gitlab host is loaded from .env file.
# Requirements for this script is the availability of curl command and to fill .env variables

#Load .env 
. ../.env

#Check if required vars are set
if [ -z $TOKEN ]
then
    printf '%s\n' "var TOKEN is empty" 1>&2
    exit 1;
fi

if [ -z $GITLAB_HOST ]
then
    printf '%s\n' "var GITLAB_HOST is empty" 1>&2
    exit 1;
fi

#Gitlab api
GITLAB_API=https://$GITLAB_HOST/api/v4

#Create SmartClide group
echo creating SmartCLIDE group ...;
RESPONSE=$(curl --insecure \
-H 'Content-Type: application/json' \
-H 'Accept: application/json' \
-H "Authorization: Bearer $TOKEN" \
--request POST --data '{"name":"SmartCLIDE","description":"Top-Level SmartCLIDE group that contains SUB-GROUPS “Services” and “Workflows”. Each of which contains GitLab projects that contain a Git Repository plus other data for handling additional features such as merge requests and CI/CD and many more.",
             "visibility":"private","path":"smartclide"}' $GITLAB_API/groups);

#take the group id, we gonna need it later for seting it as parent_id in child groups
GROUP_ID=$(echo $RESPONSE | grep -o '"[^"]*"\s*:\s*[^"]*' | grep -E '^"(id)"' | grep -oP '(?<=[:])\w+(?=[,])');

#Create SmartCLIDE/Services group
echo creating Services group under SmartCLIDE group ...;
RESPONSE=$(curl --insecure \
-H 'Content-Type: application/json' \
-H 'Accept: application/json' \
-H "Authorization: Bearer $TOKEN" \
--request POST --data '{"name":"Services","description":"Services is written from scratch, assembled using a template, or otherwise modified from existing source code, the service should have its own Git repository on the GitLab server. Each service has the potential to be re-used in different workflows"
,"visibility":"private","path":"services","parent_id":'"$GROUP_ID"'}' $GITLAB_API/groups);

#Create SmartCLIDE/Workflows
echo creating Workflows under SmartCLIDE group ...;
RESPONSE=$(curl --insecure \
-H 'Content-Type: application/json' \
-H 'Accept: application/json' \
-H "Authorization: Bearer $TOKEN" \
--request POST --data '{"name":"Workflows","description":"Workflows","visibility":"private","path":"workflows","parent_id":'"$GROUP_ID"'}' $GITLAB_API/groups);

#Create SmartCLIDE-public
echo creating SmartCLIDE-public group ...;
RESPONSE=$(curl --insecure \
-H 'Content-Type: application/json' \
-H 'Accept: application/json' \
-H "Authorization: Bearer $TOKEN" \
--request POST --data '{"name":"SmartCLIDE-public","description":"This group contains projects that are meant to be public and accessible from anywhere","visibility":"private","path":"smartclide-public"}' $GITLAB_API/groups);
