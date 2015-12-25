apikey="8ys7c3V1mrjfO8mBPx3yHGCf6PC7rdAC"
apisecret="ggdnMmGQvMgRdamU"
auth=`echo ${apikey}:${apisecret} | base64`
org=sonalisomase10
env=test
host=$org-$env.apigee.net
appkey="YXA6-p3b8JRCEeW6xB9VrkjmPg"
appsecret="YXA6k7tEIre5_PjzXc0XFpk06-QJNBM"
apporg=sonalisomase10
appapp=nysonaliapp

#identity-consent-app config.json 

unamestr=`uname`
if [[ "$unamestr" == 'Linux' || "$unamestr" == *"CYGWIN"* ]]  ; then
	sed -i  "s/__APIKEY__/$apikey/g" ../identity-consent-app/config.json
	sed -i  "s/__AUTH__/$auth/g" ../identity-consent-app/config.json
	sed -i  "s/__HOST__/$host/g" ../identity-consent-app/config.json
else 
	sed -i  "" "s/__APIKEY__/$apikey/g" ../identity-consent-app/config.json
	sed -i  "" "s/__AUTH__/$auth/g" ../identity-consent-app/config.json
	sed -i  "" "s/__HOST__/$host/g" ../identity-consent-app/config.json
fi

#identity-consentmgmt-api config.json
if [[ "$unamestr" == 'Linux' || "$unamestr" == *"CYGWIN"* ]] ; then
	sed -i  "s/__APPKEY__/$appkey/g" ../identity-consentmgmt-api/config.json
	sed -i  "s/__APPSECRET__/$appsecret/g" ../identity-consentmgmt-api/config.json
	sed -i  "s/__APPORG__/$apporg/g" ../identity-consentmgmt-api/config.json
	sed -i  "s/__APPAPP__/$appapp/g" ../identity-consentmgmt-api/config.json
else
	sed -i  "" "s/__APPKEY__/$appkey/g" ../identity-consentmgmt-api/config.json
	sed -i  "" "s/__APPSECRET__/$appsecret/g" ../identity-consentmgmt-api/config.json
	sed -i  "" "s/__APPORG__/$apporg/g" ../identity-consentmgmt-api/config.json
	sed -i  "" "s/__APPAPP__/$appapp/g" ../identity-consentmgmt-api/config.json
fi

#identity-consentmgmt-api package.json
if [[ "$unamestr" == 'Linux' || "$unamestr" == *"CYGWIN"* ]] ; then
	sed -i  "s/__APPORG__/$apporg/g" ../identity-consentmgmt-api-node-module/consentmgmt/package.json
	sed -i  "s/__APPAPP__/$appapp/g" ../identity-consentmgmt-api-node-module/consentmgmt/package.json
	sed -i  "s/__APPKEY__/$appkey/g" ../identity-consentmgmt-api-node-module/consentmgmt/package.json
	sed -i  "s/__APPSECRET__/$appsecret/g" ../identity-consentmgmt-api-node-module/consentmgmt/package.json
else
	sed -i  "" "s/__APPORG__/$apporg/g" ../identity-consentmgmt-api-node-module/consentmgmt/package.json
	sed -i  "" "s/__APPAPP__/$appapp/g" ../identity-consentmgmt-api-node-module/consentmgmt/package.json
	sed -i  "" "s/__APPKEY__/$appkey/g" ../identity-consentmgmt-api-node-module/consentmgmt/package.json
	sed -i  "" "s/__APPSECRET__/$appsecret/g" ../identity-consentmgmt-api-node-module/consentmgmt/package.json
fi

#identity-oauthv2-api config.json
if [[ "$unamestr" == 'Linux' || "$unamestr" == *"CYGWIN"* ]] ; then
	sed -i  "s/__HOST__/$host/g" ../identity-oauthv2-api/config.json
	sed -i  "s/__AUTH__/$auth/g" ../identity-oauthv2-api/config.json
else
	sed -i  "" "s/__HOST__/$host/g" ../identity-oauthv2-api/config.json
	sed -i  "" "s/__AUTH__/$auth/g" ../identity-oauthv2-api/config.json
fi

#identity-usermgmt-api config.json
if [[ "$unamestr" == 'Linux' || "$unamestr" == *"CYGWIN"* ]] ; then
	sed -i  "s/__APPORG__/$apporg/g" ../identity-usermgmt-api/config.json
	sed -i  "s/__APPAPP__/$appapp/g" ../identity-usermgmt-api/config.json
	sed -i  "s/__APPKEY__/$appkey/g" ../identity-usermgmt-api/config.json
	sed -i  "s/__APPSECRET__/$appsecret/g" ../identity-usermgmt-api/config.json

else
	sed -i  "" "s/__APPORG__/$apporg/g" ../identity-usermgmt-api/config.json
	sed -i  "" "s/__APPAPP__/$appapp/g" ../identity-usermgmt-api/config.json
	sed -i  "" "s/__APPKEY__/$appkey/g" ../identity-usermgmt-api/config.json
	sed -i  "" "s/__APPSECRET__/$appsecret/g" ../identity-usermgmt-api/config.json
fi

#identity-usermgmt-api package.json
if [[ "$unamestr" == 'Linux' || "$unamestr" == *"CYGWIN"* ]] ; then
	sed -i  "s/__APPORG__/$apporg/g" ../identity-usermgmt-node-module/usermgmt/package.json
	sed -i  "s/__APPAPP__/$appapp/g" ../identity-usermgmt-node-module/usermgmt/package.json
	sed -i  "s/__APPKEY__/$appkey/g" ../identity-usermgmt-node-module/usermgmt/package.json
	sed -i  "s/__APPSECRET__/$appsecret/g" ../identity-usermgmt-node-module/usermgmt/package.json
else
	sed -i  "" "s/__APPORG__/$apporg/g" ../identity-usermgmt-node-module/usermgmt/package.json
	sed -i  "" "s/__APPAPP__/$appapp/g" ../identity-usermgmt-node-module/usermgmt/package.json
	sed -i  "" "s/__APPKEY__/$appkey/g" ../identity-usermgmt-node-module/usermgmt/package.json
	sed -i  "" "s/__APPSECRET__/$appsecret/g" ../identity-usermgmt-node-module/usermgmt/package.json
fi

#identity-demo-api config.json
if [[ "$unamestr" == 'Linux' || "$unamestr" == *"CYGWIN"* ]] ; then
	sed -i  "s/__HOST__/$host/g" ../identity-demo-app/config.json
	sed -i  "s/__APIKEY__/$apikey/g" ../identity-demo-app/config.json
	sed -i  "s/__APISECRET__/$apisecret/g" ../identity-demo-app/config.json
else
	sed -i  "" "s/__HOST__/$host/g" ../identity-demo-app/config.json
	sed -i  "" "s/__APIKEY__/$apikey/g" ../identity-demo-app/config.json
	sed -i  "" "s/__APISECRET__/$apisecret/g" ../identity-demo-app/config.json
fi

