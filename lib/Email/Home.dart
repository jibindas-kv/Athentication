import 'package:authentication/Email/Profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class Home extends StatelessWidget {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Future<Map<String, dynamic>?> fetchUserData() async {
    String uid = _auth.currentUser!.uid;
    DocumentSnapshot userDoc =
    await _firestore.collection('CrudUser').doc(uid).get();
    return userDoc.data() as Map<String, dynamic>?;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        automaticallyImplyLeading: false,
        leading: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return Profile();
                },
              ));
            },
            child: CircleAvatar()),
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: fetchUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text("No user data found"));
          }

          Map<String, dynamic> userData = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Name: ${userData['name']}"),
                Text("Email: ${userData['email']}"),
                Text("Place: ${userData['place']}"),
              ],
            ),
          );
        },
      ),
    );
  }
}
