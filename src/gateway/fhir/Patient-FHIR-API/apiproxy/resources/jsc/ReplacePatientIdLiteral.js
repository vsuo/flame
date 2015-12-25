var proxyPathSuffix = context.getVariable("proxy.pathsuffix");
print("proxy.pathsuffix = "+ proxyPathSuffix);
var patient_id =  context.getVariable("patient_id");
var primaryResourceId= context.getVariable('primaryResourceId');

var pathSuffixWithPatient = "";

if(primaryResourceId!="_history" && primaryResourceId!="_search" && primaryResourceId!="$meta" && primaryResourceId!="$everything")
{
   if ((proxyPathSuffix.indexOf('id')!=-1 || patient_id!=primaryResourceId )&& patient_id!=null) 
  {
    //var id="id";
    var regex = new RegExp(primaryResourceId, 'i');
    var res = proxyPathSuffix.replace(regex, patient_id);
               print("res for B2C: "+res);
    pathSuffixWithPatient=res;
    
  }
  if ((proxyPathSuffix.indexOf('id')!=-1 || patient_id!=primaryResourceId )&& patient_id==null) 
  {
    print("res for B2B: "+res);
     pathSuffixWithPatient=proxyPathSuffix;
  }
}
else{
  
  pathSuffixWithPatient="/"+primaryResourceId;
  print("Operations on Resource baseURL : "+ pathSuffixWithPatient);
}

context.setVariable("pathSuffixWithPatient",pathSuffixWithPatient);

