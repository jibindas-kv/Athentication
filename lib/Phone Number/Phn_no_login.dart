import 'package:authentication/Phone%20Number/Otp_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class Phn_no_login extends StatefulWidget {
  const Phn_no_login({super.key});

  @override
  State<Phn_no_login> createState() => _Phn_no_loginState();
}

class _Phn_no_loginState extends State<Phn_no_login> {
  final formkey = GlobalKey<FormState>(); // for validations

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.only(left: 15,right: 15),
            child: Column(
              children: [
                SizedBox(height: 300),
                Row(
                  children: [
                    Text(
                      "Enter Your Phone Number",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Colors.white),
                    )
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: IntlPhoneField(
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          labelStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        initialCountryCode: 'US', // default country code
                        onChanged: (phone) {
                          print(phone.completeNumber); // prints the full phone number with country code
                        },
                        validator: (value) {
                          if (value == null || value.number.isEmpty) {
                            return "Please enter a valid phone number";
                          }
                          return null;
                        },
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {

                      },
                      child: Text(
                        '     Login     ',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        textStyle: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
