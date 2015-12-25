var requestingProvider = context.getVariable("devAttributes.provider");
var patientAuthorizations = context.getVariable("authorizations");
var primaryResource = context.getVariable("primaryResource");

var authorized = false;

if (patientAuthorizations && requestingProvider && primaryResource) {
    var authObject = {
        "name" : "authorizations",
        "authorizations" : JSON.parse(patientAuthorizations)
    };

    authorized = authObject.authorizations.some(
        function(elem1, index1, array1) {
            return ((elem1.provider == requestingProvider) &&
            (elem1.authorizations.some(function (elem2, index2, array2) { return elem2 == primaryResource; }) == true));
        });
} else {
    // error - no authorizations
    authorized = false;
}

context.setVariable("isAuthorizedByPatient", authorized);
