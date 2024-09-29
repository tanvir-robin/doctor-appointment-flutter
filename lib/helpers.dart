import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class EmailService {
  Future<void> sendOtpEmail(String receiverEmail, String otp) async {
    // Define the SMTP server settings
    String username = 'tanvirrobin0@gmail.com';
    String password = 'fkvawdrjzgnklheb';

    final smtpServer = SmtpServer(
      'smtp.gmail.com',
      port: 465,
      ssl: true,
      username: username,
      password: password,
    );

    // Create the email content
    final message = Message()
      ..from = Address(username, 'Dental Care')
      ..recipients.add(receiverEmail)
      ..subject = 'Your OTP Code'
      ..html = '''
    <div style="font-family: Helvetica,Arial,sans-serif;min-width:1000px;overflow:auto;line-height:2">
      <div style="margin:50px auto;width:70%;padding:20px 0">
        <div style="border-bottom:1px solid #eee">
          <a href="" style="font-size:1.4em;color: #00466a;text-decoration:none;font-weight:600">Dental Care</a>
        </div>
        <p style="font-size:1.1em">Hi,</p>
        <p>Thank you for choosing Dental Care. Use the following OTP to complete your Sign Up procedures. OTP is valid for 5 minutes</p>
        <h2 style="background: #00466a;margin: 0 auto;width: max-content;padding: 0 10px;color: #fff;border-radius: 4px;">$otp</h2>
        <p style="font-size:0.9em;">Regards,<br />Dental Care</p>
        <hr style="border:none;border-top:1px solid #eee" />
        <div style="float:right;padding:8px 0;color:#aaa;font-size:0.8em;line-height:1;font-weight:300">
          <p>Dental Care</p>
          <p>Bangladesh</p>
        </div>
      </div>
    </div>
    ''';

    try {
      // Send the email
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent. \n${e.toString()}');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }
}
