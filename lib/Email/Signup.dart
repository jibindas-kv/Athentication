import 'package:authentication/Email/Login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  var Email_ctrl = TextEditingController();
  var Password_ctrl = TextEditingController();
  var Name_ctrl = TextEditingController();
  var Number_ctrl = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  // Email RegExp
  final RegExp emailRegExp =
  RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

  // Phone number RegExp (this one expects a 10-digit number)
  final RegExp phoneRegExp = RegExp(r'^\d{10}$');

  // Password RegExp (at least 6 characters in this example)
  final RegExp passwordRegExp = RegExp(r'^.{6,}$');

  Future<void> Signup() async {
    try {
      await FirebaseFirestore.instance.collection("Signup").add({
        "Email": Email_ctrl.text,
        "Password": Password_ctrl.text,
        "Name": Name_ctrl.text,
        "Number": Number_ctrl.text,
      });
      // Clear all the input fields after successful registration
      Email_ctrl.clear();
      Password_ctrl.clear();
      Name_ctrl.clear();
      Number_ctrl.clear();

      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return LoginPage();
        },
      ));
    } catch (e) {
      // Error handling for Firebase operation
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error registering user: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 280.h),
                Text(
                  'User Signup',
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(height: 24),
                // Name field
                TextFormField(
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                  controller: Name_ctrl,
                  decoration: InputDecoration(
                    labelText: ' Name',
                    labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your Name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                // Phone number field
                TextFormField(
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                  controller: Number_ctrl,
                  decoration: InputDecoration(
                    labelText: ' Phone Number',
                    labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your Phone Number';
                    } else if (!phoneRegExp.hasMatch(value)) {
                      return 'Enter a valid 10-digit Phone Number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                // Email field
                TextFormField(
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                  controller: Email_ctrl,
                  decoration: InputDecoration(
                    labelText: ' Email',
                    labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your Email';
                    } else if (!emailRegExp.hasMatch(value)) {
                      return 'Please enter a valid Email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                // Password field
                TextFormField(
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                  controller: Password_ctrl,
                  decoration: InputDecoration(
                    labelText: ' Password',
                    labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your Password';
                    } else if (!passwordRegExp.hasMatch(value)) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Signup();
                    }
                  },
                  child: Text(
                    'Signup',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    backgroundColor: Colors.blue,
                    textStyle: TextStyle(fontSize: 18),
                  ),
                ),
                SizedBox(height: 200.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 3),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                              return LoginPage();
                            }));
                      },
                      child: Text(
                        " Login",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    )
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
