import ballerina/email;
import ballerina/io;

public function main() {
  email:SmtpClient smtpClient = new ("smtp.email.com", "sender@email.com"
        , "pass123");

        email:Email email = {
Define the email that is required to be sent.
        to: ["receiver1@email.com", "receiver2@email.com"],
        cc: ["receiver3@email.com", "receiver4@email.com"],
        bcc: ["receiver5@email.com"],
“TO”, “CC” and “BCC” address lists are added as follows. Only “TO” address list is mandatory out of these three.
        subject: "Sample Email",
Subject of the email is added as follows. This field is mandatory.
        body: "This is a sample email.",
Body content of the email is added as follows. This field is mandatory.
        'from: "author@email.com",
Email author’s address is added as follows. This field is mandatory.
        sender: "sender@email.com",
Email sender service address is added as follows. This field is optional. Sender is same as the 'from when the email author himself sends the email.
        replyTo: ["replyTo1@email.com", "replyTo2@email.com"]
    };
List of recipients when replying to the email is added as follows. This field is optional. These addresses are required when the emails are to be replied to some other address(es) other than the sender or the author.
    email:Error? response = smtpClient->send(email);
    if (response is email:Error) {
        io:println("Error while sending the email: "
            + <string> response.detail()["message"]);
    }
}