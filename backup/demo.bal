import ballerina/http;
import ballerina/log;

//The Target Endpoint
endpoint http:Client targetEndpoint {
   url: "https://api.pizzastore.com/pizzashack/v1"
};

//This service is accessible at /pizzashack/1.0.0 on port 9090
@http:ServiceConfig {
   basePath: "/pizzashack/1.0.0"
}
service<http:Service> passthrough bind { port: 9090 } {

   @http:ResourceConfig {
       methods:["GET"],
       path: "/menu"
   }
   passthrough(endpoint caller, http:Request req) {

       //Forward the client request to the /menu resource of the Target
	 //Endpoint.
       var clientResponse = targetEndpoint->forward("/menu", req);

       //Check if the response from the target Endpoint was a success or not.
       match clientResponse {

           http:Response res => {
               caller->respond(res) but { error e =>
                          log:printError("Error sending response", err = e) };
           }

           error err => {
               http:Response res = new;
               res.statusCode = 500;
               res.setPayload(err.message);
               caller->respond(res) but { error e =>
                          log:printError("Error sending response", err = e) };
           }
       }
   }
}




// import ballerina/http;

// endpoint http: Listner listener {
//     port: 9090
// };

// @http:ServiceConfig {
//     basePath: "/"
// }

// service<http:Service> helloWorld bind listner {
//     @http:ResourceConfig {
//         path: "/"
//     }

//     sayHello(endpoint outboundEP, http:Request request) {
//         http:Response response = new;
//         response.setTextPayload("Hello World \n");
//         _ = outboundEP.send(response);
//     }
// }