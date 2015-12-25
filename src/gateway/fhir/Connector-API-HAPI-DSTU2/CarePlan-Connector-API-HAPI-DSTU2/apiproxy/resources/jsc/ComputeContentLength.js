 var body= context.getVariable('response.content');
 var rt=context.getVariable('returnType');
 if(rt.indexOf("json") >= 0)
 {
    var bodyStr = JSON.stringify(JSON.parse(body));
 }
 else{
      var bodyStr = String(body);
 }
 var noBytes=  (unescape(encodeURIComponent((bodyStr)))).length;
 context.setVariable('response.header.Content-Length', noBytes);
