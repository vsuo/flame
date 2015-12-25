var responseData = response.content;
print("responseData = "+responseData);
var primaryResource = context.getVariable("primaryResource");
var targetBasePath = context.getVariable("target.url");
print("targetBasePath = "+targetBasePath);
var len = targetBasePath.lastIndexOf(primaryResource);
var targetPathExpressionre =  targetBasePath.substring(len-1,0);
print("targetPathExpressionre = "+targetPathExpressionre);
var contentLocation = context.getVariable("response.header.Content-Location");

var organizationName = context.getVariable("organization.name");
var environmentName = context.getVariable("environment.name");
var proxyBasePath = context.getVariable("proxy.basepath");
var host = context.getVariable("client.host");
print("proxyBasePath = "+proxyBasePath);

var prefixLen = proxyBasePath.lastIndexOf(primaryResource);
var proxyPrefix=proxyBasePath.substring(prefixLen-1,0);
print("proxyPrefix= "+proxyPrefix);                    
var proxyPath = "https://" + organizationName + "-" + environmentName + ".apigee.net" + proxyBasePath;
var proxyPath_Bundle = "https://" + organizationName + "-" + environmentName + ".apigee.net" + proxyPrefix;
var targetPathExpressionre1=targetPathExpressionre+"/"+primaryResource;
var re1=new RegExp(targetPathExpressionre1, 'g');
print("re1 = "+re1);
//var proxyPath1 = "https://" + organizationName + "-" + environmentName + ".apigee.net" + proxyBasePath;
responseData = responseData.replace(re1, proxyPath);


var re = new RegExp(targetPathExpressionre, 'g');
print("re = "+re);
responseData = responseData.replace(re, proxyPath);

var _getpages="_getpages";
var re2 = new RegExp(_getpages, 'g');
var _getpagesoffset="_getpagesoffset";
var re3 = new RegExp(_getpagesoffset, 'g');
var _count="_count";
var re4 = new RegExp(_count, 'g');
var emptySpace="amp;";
var re5 = new RegExp(emptySpace, 'g');

responseData = responseData.replace(re3, "page");
responseData = responseData.replace(re2, "stateid");
responseData = responseData.replace(re4, "page_size");
responseData = responseData.replace(re5, "");
context.setVariable("proxyResponse", responseData);
if(contentLocation!="" && contentLocation!=null)
{
  if(contentLocation.indexOf("Bundle") > -1){
  	contentLocation = contentLocation.replace(re, proxyPath_Bundle);
  }
  else
    contentLocation = contentLocation.replace(re1, proxyPath);
  print("contentLocation = "+contentLocation);
  context.setVariable("response.header.Content-Location", contentLocation);
}
