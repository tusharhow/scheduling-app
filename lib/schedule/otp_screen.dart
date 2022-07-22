import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../calendar/calendar_widget.dart';

class PhoneLogin extends StatefulWidget {
  PhoneLogin({
    Key key,
  }) : super(key: key);

  @override
  State<PhoneLogin> createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  TextEditingController otpController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool otpVisibility = false;
  String verificationID = "";
  FirebaseAuth auth = FirebaseAuth.instance;
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP Verification'),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: phoneController,
              decoration: InputDecoration(
                labelText: 'Enter Phone Number',
                border: OutlineInputBorder(),
                hintText: '+9191555442',
              ),
              keyboardType: TextInputType.phone,
              validator: (val) {
                if (val.isEmpty) {
                  return 'Phone Number is required';
                }
                return null;
              },
            ),
            SizedBox(
              height: 20,
            ),
            Visibility(
              child: TextField(
                controller: otpController,
                decoration: InputDecoration(
                  labelText: 'OTP',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              visible: otpVisibility,
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                if (phoneController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Phone Number is required'),
                    ),
                  );
                } else {
                  if (otpVisibility) {
                    //ToDo: signIn
                    signIn();
                  } else {
                    //Todo: verify
                    verifyPhone();
                  }
                }
              },
              child: Text(otpVisibility ? "Verify" : "Send OTP"),
            ),
          ],
        ),
      ),
    );
  }

  void verifyPhone() async {
    await auth.verifyPhoneNumber(
      timeout: const Duration(minutes: 2),
      phoneNumber: phoneController.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential).then((value) {
          print("You are logged in successfully");
        });
        Get.offAll(() => CalendarWidget(
              title: "Book a Session",
              desc: "Please enter your phone number to book a session",
              time: "30m",
            ));
      },
      verificationFailed: (FirebaseAuthException e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.message),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ));
      },
      codeSent: (String verificationId, int resendToken) {
        otpVisibility = true;
        verificationID = verificationId;
        setState(() {});
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  void signIn() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: otpController.text);
    await auth.signInWithCredential(credential).then((value) {
      print("You are logged in successfully" + value.user.phoneNumber);
      Fluttertoast.showToast(
          msg: "You are logged in successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    });
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CalendarWidget(
                  title: "Book a Session",
                  desc: "Please enter your phone number to book a session",
                  time: "30m",
                )));
    // Get.offAll(() => CalendarWidget(
    //       title: "Book a Session",
    //       desc: "Please enter your phone number to book a session",
    //       time: "30m",
    //     ));
  }
}
