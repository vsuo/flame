URI="https://api.enterprise.apigee.com"
usage() {
  echo "Usage: $(basename $0) [-o <org name>] [-e <env name>] [-u <admin email>] [-p <admin password>]"
  echo "  -h | --help :                        Display usage information"
  echo "  -o | --org <orgname> :               Organisation Name"
  echo "  -e | --env <envname> :               Environment Name"
  echo "  -u | --username <adminusername> :    Admin Email"
  echo "  -p | --password <password> :         Admin Password"
  exit 0
}

# if [ $# -eq 0 ]; then
# 	usage
# fi

while [ $# -gt 0 ]; do
  case "$1" in
    -o|--org)
      if [ -n "$2" ]; then
        ORG=$2
        shift
        shift
      else
        usage
      fi
    ;;
    -e|--env)
      if [ -n "$2" ]; then
        ENV=$2
        shift
        shift
      else
        usage
      fi
    ;;
    -u|--username)
      if [ -n "$2" ]; then
        ADMIN_EMAIL=$2
        shift
        shift
      else
        usage
      fi
    ;;
    -p|--password)
      if [ -n "$2" ]; then
        APW=$2
        shift
        shift
      else
        usage
      fi
    ;;
    -h|--help)
      usage
    ;;
    *)
      usage
  esac
done

if [ -z "${ORG}" ]; then
    echo "Enter Apigee Enterprise Organization, followed by [ENTER]:"
    read ORG
fi

if [ -z "${ENV}" ]; then
    echo "Enter Organization's Environment, followed by [ENTER]:"
    read ENV
fi

if [ -z "${ADMIN_EMAIL}" ]; then
    echo "Enter Apigee Enterprise LOGIN EMAIL, followed by [ENTER]:"
    read ADMIN_EMAIL
fi

if [ -z "${APW}" ]; then
    echo "Enter Apigee Enterprise PASSWORD, followed by [ENTER]:"
   # read -s -r APW
    read  -r APW
fi

########################################################################

HOST=$ORG-$ENV.apigee.net

### Create App Resources Now ###
echo `date`": Deleting Developer, Product, App ; Please hang On !!"
SETUP_RESULT=`curl -k -u "${ADMIN_EMAIL}:${APW}" -X DELETE "${URI}/v1/o/${ORG}/developers/testuser@apigee.com"  1>&2`
echo "${SETUP_RESULT}"
echo ""

SETUP_RESULT=`curl -k -u "${ADMIN_EMAIL}:${APW}" -X DELETE "${URI}/v1/o/${ORG}/apiproducts/testFHIRproduct"  1>&2`
echo "${SETUP_RESULT}"
echo ""

SETUP_RESULT=`curl -k -u "${ADMIN_EMAIL}:${APW}" -X DELETE "${URI}/v1/o/${ORG}/developers/testuser@apigee.com/apps/testFHIRApp"  1>&2`
echo "${SETUP_RESULT}"
echo ""
### End - Delete App Resources ###

### Create App Resources Now ###
echo `date`": Creating Developer, Product, App ; Please hang On !!"

SETUP_RESULT=`curl -k -u "${ADMIN_EMAIL}:${APW}" -X POST "${URI}/v1/o/${ORG}/developers" -H "Content-Type: application/json" -d '{"email":"testuser@apigee.com", "firstName":"test","lastName":"user","userName":"testuser"}' 1>&2`
echo "${SETUP_RESULT}"
echo ""

SETUP_RESULT=`curl -k -u "${ADMIN_EMAIL}:${APW}" -X POST "${URI}/v1/o/${ORG}/apiproducts" -H "Content-Type: application/json" -d '{"approvalType":"auto","attributes": [{"name": "RATE_LIMIT_OVERRIDE_LIMIT","value": "100ps"}],"displayName":"Fhir Api Product","name":"testFHIRproduct","environments":["test","prod"],"apiResources":["/","/**"],"quota": "10000", "quotaInterval": "1", "quotaTimeUnit": "minute","scopes" : ["allergyintolerance.read","careplan.read","condition.read","diagnosticorder.read","diagnosticreport.read","documentreference.read","encounter.read","immunization.read","medicationadministration.read","medicationdispense.read","medicationorder.read","medicationstatement.read","observation.read","patient.read","patient/Allergyintolerance.read","patient/Careplan.read","patient/Condition.read","patient/Diagnosticorder.read","patient/Diagnosticreport.read","patient/Documentreference.read","patient/Encounter.read","patient/Immunization.read","patient/Medicationadministration.read","patient/Medicationdispense.read","patient/Medicationorder.read","patient/Medicationstatement.read","patient/Observation.read","patient/Observation.write","patient/Patient.read","patient/Practitioner.read","patient/Procedure.read","practitioner.read","procedure.read","user/Allergyintolerance.read","user/Allergyintolerance.write","user/Careplan.read","user/Careplan.write","user/Condition.read","user/Condition.write","user/Diagnosticorder.read","user/Diagnosticorder.write","user/Diagnosticreport.read","user/Diagnosticreport.write","user/Documentreference.read","user/Documentreference.write","user/Encounter.read","user/Encounter.write","user/Immunization.read","user/Immunization.write","user/Medicationadministration.read","user/Medicationadministration.write","user/Medicationdispense.read","user/Medicationdispense.write","user/Medicationorder.read","user/Medicationorder.write","user/Medicationstatement.read","user/Medicationstatement.write","user/Observation.read","user/Observation.write","user/Patient.read","user/Patient.write","user/Practitioner.read","user/Practitioner.write","user/Procedure.read","user/Procedure.write","schedule.read","patient/Schedule.read","user/Schedule.read","user/Schedule.write"]}' 1>&2
`
echo "${SETUP_RESULT}"
echo ""

callback_url=https://$HOST
app_data="{\"name\":\"testFHIRApp\", \"callbackUrl\":\"${callback_url}\"}"
SETUP_RESULT=`curl -k -u "${ADMIN_EMAIL}:${APW}" -X POST "${URI}/v1/o/${ORG}/developers/testuser@apigee.com/apps" -H "Content-Type: application/json" -d "$app_data" `
echo "${SETUP_RESULT}"

apikey=${SETUP_RESULT#*consumerKey*:}
apikey=`echo ${apikey%,*consumerSecret*} | tr -d ' '`
apisecret=${SETUP_RESULT#*consumerSecret*:}
apisecret=`echo ${apisecret%,*expiresAt*} | tr -d ' '`
echo "Generated API Key: ${apikey}"
echo "Generated API Secret: ${apisecret}"
echo ""

ckey=`echo ${apikey} | tr -d '"'`
SETUP_RESULT=`curl -k -u "${ADMIN_EMAIL}:${APW}" -X POST "${URI}/v1/o/${ORG}/developers/testuser@apigee.com/apps/testFHIRApp/keys/${ckey}" -H "Content-Type: application/xml" -d '<CredentialRequest><ApiProducts><ApiProduct>testFHIRproduct</ApiProduct></ApiProducts></CredentialRequest>' `
echo "${SETUP_RESULT}"