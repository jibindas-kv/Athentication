import 'package:authentication/Email/Home.dart';
import 'package:authentication/Email/Signup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount == null) return;

      final GoogleSignInAuthentication googleAuth =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      if (userCredential.user != null) {
        await _saveUserDataToFirestore(userCredential.user!);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Home();
        },));
      }
    } catch (error) {
      print("Google Sign-In Error: $error");
    }
  }

  Future<void> _saveUserDataToFirestore(User user) async {
    final DocumentSnapshot userDoc =
        await _firestore.collection("CrudUser").doc(user.uid).get();

    if (!userDoc.exists) {
      await _firestore.collection("CrudUser").doc(user.uid).set({
        'name': user.displayName,
        'email': user.email,
        'place': "",
        // Add additional fields like "Trade" and "OfficeLocation" if required
      });
    }
  }

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final RegExp emailRegExp =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
                SizedBox(
                  height: 300.h,
                ),
                Text(
                  'Welcome Back!',
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(height: 24),
                TextFormField(
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: ' Email',
                    labelStyle: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
                    }
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: ' Password',
                    labelStyle: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your password';
                    }
                  },
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    backgroundColor: Colors.blue,
                    textStyle: TextStyle(fontSize: 18),
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    signInWithGoogle();
                  },
                  icon: Icon(Icons.login),
                  label: Text(
                    ' Sign in with Google',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    backgroundColor: Colors.white, // Google red color
                    textStyle: TextStyle(fontSize: 18),
                  ),
                ),
                SizedBox(height: 13),
                Text(
                  'Forgot Password?',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 200.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Do you have an account?",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 3),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return Signup();
                          },
                        ));
                      },
                      child: Text(
                        " Sign Up",
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
