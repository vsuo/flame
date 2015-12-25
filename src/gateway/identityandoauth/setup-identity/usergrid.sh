### usergrid.sh
URI="https://api.usergrid.com"
ADMIN_EMAIL=sonali_somase@persistent.co.in
APW=Sks21@apigee

### These are the Custom variables ###
echo "Enter Apigee App services org, followed by [ENTER]:"
read ORG

unamestr=`uname`
if [[ "$unamestr" == 'Linux' || "$unamestr" == *"CYGWIN"* ]]; then
	sed -i  "s/__UGORG__/$ORG/g" ./config.sh
else
	sed -i "" "s/__UGORG__/$ORG/g" ./config.sh
fi
	
echo "Enter Application Name , followed by [ENTER]:"
read APP_NAME

echo "Fetching App Services Token, to login ..."
token=`curl -k -X POST ${URI}/management/token  -d '{"grant_type":"password", "username": "'${ADMIN_EMAIL}'", "password": "'${APW}'"}' | sed 's/.*access_token\"\:\"\(.*\)\"\,\"expires_in.*/\1/'`

echo "Create App Services Application: ${APP_NAME}, with Token: ${token}"
`curl -k -X POST ${URI}/management/orgs/${ORG}/apps?access_token="${token}" -d '{"name":"'${APP_NAME}'"}'`

creds=`curl -k -X POST ${URI}/management/orgs/${ORG}/apps/${APP_NAME}/credentials?access_token="${token}" | sed 's/}//'`
echo "Got App Services Credentials for the App, that was created above: ${creds}"
c_id=${creds#*client_id*:}
c_id=`echo ${c_id%,*} | tr -d ' '`
sec=${creds#*client_secret*:}
sec=`echo ${sec%*} | tr -d ' '`
echo "Client ID: ${c_id}"
echo "Client Secret: ${sec}"

echo "Creating Collections"
resp=`curl -k -X POST ${URI}/${ORG}/${APP_NAME}/consent?access_token="${token}"`
echo "Status: Creating Consent Collection: ${resp}"

resp=`curl -k -X POST ${URI}/${ORG}/${APP_NAME}/sso?access_token="${token}"`
echo "Status: Creating SSO Collection:${resp}"

if [[ "$unamestr" == 'Linux' || "$unamestr" == *"CYGWIN"* ]] ; then
	sed -i  "s/__UGKEY__/$c_id/g" ./config.sh
	sed -i  "s/__UGSECRET__/$sec/g" ./config.sh
	sed -i  "s/__UGAPP__/$APP_NAME/g" ./config.sh
	echo "eifs"
else
	sed -i "" "s/__UGKEY__/$c_id/g" ./config.sh
	sed -i "" "s/__UGSECRET__/$sec/g" ./config.sh
	sed -i "" "s/__UGAPP__/$APP_NAME/g" ./config.sh	
	echo "elseus"
fi
### End - Create Application ###

if [[ "$unamestr" == 'Linux' || "$unamestr" == *"CYGWIN"* ]] ; then
	bash ./config.sh
else
	sh ./config.sh
fi