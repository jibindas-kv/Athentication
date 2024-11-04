import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class Otp_field extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
        fontSize: 20,
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Center(child: Text("ENTER OTP")),
      ),
      body: Column(  crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Pinput(
              length: 4, // Number of PIN characters
              defaultPinTheme: defaultPinTheme,
              focusedPinTheme: defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration!.copyWith(
                  border: Border.all(color: Colors.blue),
                ),
              ),
              submittedPinTheme: defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration!.copyWith(
                  color: Colors.white,
                ),
              ),
              validator: (value) {
                return value == "1234" ? null : "Incorrect PIN";
              },
              onCompleted: (pin) {
                print("Entered PIN: $pin");
              },
            ),
          ),
          SizedBox(height: 30,),
          ElevatedButton(onPressed: () {

          }, child: Text("DONE"))
        ],
      ),
    );
  }
}