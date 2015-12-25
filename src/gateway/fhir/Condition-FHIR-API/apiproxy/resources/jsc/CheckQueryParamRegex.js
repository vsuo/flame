var querystring = context.getVariable('request.querystring');
var length = context.getVariable('request.queryparams.count');
var sqlRegex = "[\s]*((delete)|(exec)|(drop\s*table)|(insert)|(shutdown)|(update)|(\bor\b))";
var jsRegex = "&lt;\s*script\b[^&gt;]*&gt;[^&lt;]+&lt;\s*/\s*script\s*&gt;";

var sqlPatt = new RegExp(sqlRegex);
var jsPatt = new RegExp(jsRegex);
var params = querystring.split("&");
context.setVariable('threatPresent','false');
for(i=0;i<params.length;i++) {
   var value = params[i].split("=");
  
  if(sqlPatt.test(value[1]) || jsPatt.test(value[1])){
     context.setVariable('threatPresent','true');    
    
  }
  	
}
