var requestPathSuffix = context.getVariable("proxy.pathsuffix");
if((requestPathSuffix.indexOf('ConceptMap') >-1) || (requestPathSuffix.indexOf('metadata') >-1 )) {
  context.setVariable("service_callout_basepath", "spark-dstu2");
}
else {
  
  context.setVariable("service_callout_basepath", "hapi-dstu2");
}
