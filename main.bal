import ballerina/io;
import ballerina/http;

public function main() returns @tainted error? {
    http:Client clientEp = check new ("http://httpbin.org");
    json resp = check clientEp->get("/get");
    io:println("Payload: ", resp);
}
