#!/bin/bash 
export VAULT_ADDR=https://xyz.dv.domainname.net:8100
vault auth -method=ldap username=ldapusername
CREDS=$(vault write -format=json account/11111111111111/sts/IAM-Admin ttl=30m)

aws configure set aws_session_token `echo "$CREDS" |  jq '.data.security_token' -r` --profile testprofile
aws configure set aws_access_key_id `echo "$CREDS" |  jq '.data.access_key' -r` --profile testprofile
aws configure set aws_secret_access_key `echo "$CREDS" |  jq '.data.secret_key' -r` --profile testprofile
