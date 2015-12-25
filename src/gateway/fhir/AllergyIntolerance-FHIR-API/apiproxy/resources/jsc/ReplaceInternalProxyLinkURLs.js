var responseData = context.getVariable("invokeConnectorAPIResponse.content");
var statusCode = context.getVariable("invokeConnectorAPIResponse.status.code");
print("statusCode"+statusCode);
var primaryResource = context.getVariable("primaryResource");
var serviceCalloutDomain = context.getVariable("service_callout_domain");
var serviceCalloutBasepath = context.getVariable("service_callout_basepath");
var targetBasePath = "https://"+serviceCalloutDomain+"/"+serviceCalloutBasepath;

print("targetBasePath= "+targetBasePath);

var len = targetBasePath.lastIndexOf(primaryResource);
var targetPathExpressionre =  targetBasePath.substring(len-1,0)
var contentLocation = context.getVariable("invokeConnectorAPIResponse.header.Content-Location");


var organizationName = context.getVariable("organization.name");
var environmentName = context.getVariable("environment.name");
var proxyBasePath = context.getVariable("proxy.basepath");
var host = context.getVariable("client.host");

print("proxyBasePath"+proxyBasePath);

var prefixLen = proxyBasePath.lastIndexOf(primaryResource);
var proxyPrefix=proxyBasePath.substring(prefixLen-1,0);

print("proxyPrefix= "+proxyPrefix);
 
var proxyPath = "https://" + organizationName + "-" + environmentName + ".apigee.net" + proxyPrefix;


var re = new RegExp(targetPathExpressionre, 'g');
responseData = responseData.replace(re, proxyPath);
var contentType=context.getVariable("invokeConnectorAPIResponse.header.Content-Type");
context.setVariable("response.content", responseData);
context.setVariable("response.header.Content-Type",contentType);
context.setVariable("response.status.code",statusCode);

if(contentLocation!="" && contentLocation!=null)
{
  contentLocation = contentLocation.replace(re, proxyPath);
  context.setVariable("response.header.Content-Location", contentLocation);
}


var headerNames = context.getVariable("invokeConnectorAPIResponse.headers.names") + "";
headerNames.split(", ").sort().forEach(function(headerName) {
    if (headerName)
        print(headerName+":"+context.getVariable("invokeConnectorAPIResponse.header."+headerName));
});

 