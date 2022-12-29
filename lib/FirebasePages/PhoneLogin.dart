import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_f2/FirebasePages/OtpPage.dart';

import '../CustomChange/Utils.dart';

class PhoneLogin extends StatefulWidget {
  const PhoneLogin({super.key});

  @override
  State<PhoneLogin> createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  bool loading = false;
  final phoneNumberController = TextEditingController();
  final auth = FirebaseAuth.instance;

  void _onBackPressed() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: _onBackPressed),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(top: 170),
        child: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(children: <Widget>[
              Expanded(
                flex: 2,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: <Widget>[
                          txt(),
                          Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: TextFormField(
                              controller: phoneNumberController,
                              keyboardType: TextInputType.phone,
                              decoration:
                                  const InputDecoration(hintText: '9033851013'),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            constraints: const BoxConstraints(maxWidth: 500),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  const Text(
                                    'Next',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  btn(context)
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ]),
          ),
        ),
      )),
    );
  }

  InkWell btn(BuildContext context) {
    return InkWell(
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.black,
          ),
          child: const Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
            size: 16,
          ),
        ),
        onTap: () {
          loading:
          loading;

          setState(() {
            loading = true;
          });
          auth.verifyPhoneNumber(
            phoneNumber: '+91 ${phoneNumberController.text}',
            verificationCompleted: (_) {
              setState(() {
                loading = false;
              });
            },
            verificationFailed: (e) {
              setState(() {
                loading = false;
              });
              Utils().toastMessage(e.toString());
            },
            codeSent: (String verificationId, int? token) {
              // print('id is ${verificationId}');
              // print(' tokan is $token');
              if (phoneNumberController.text.length > 11) {
                Utils().toastMessage('Enter a 10 digit ');
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VerifyCodeScreen(
                              verificationId: verificationId,
                            )));
              }
              setState(() {
                loading = false;
              });
            },
            codeAutoRetrievalTimeout: (e) {
              Utils().toastMessage(e.toString());
              setState(() {
                loading = false;
              });
            },
          );
        });
  }

  Container txt() {
    return Container(
        constraints: const BoxConstraints(maxWidth: 500),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(children: <TextSpan>[
            TextSpan(
                text: 'We will send you an ',
                style: TextStyle(color: Colors.black)),
            TextSpan(
                text: 'One Time Password ',
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
            TextSpan(
                text: 'on this mobile number',
                style: TextStyle(color: Colors.black)),
          ]),
        ));
  }
}
