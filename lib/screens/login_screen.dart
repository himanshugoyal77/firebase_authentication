import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment/controller/auth_controller.dart';
import 'package:flutter_assignment/screens/display_all.dart';
import 'package:flutter_assignment/screens/info_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Login Via Google",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: (() {
                Authentication.signInWithGoogle(context: context).then(
                  (value) async {
                    print(value);
                    if (value != null) {
                      var collection =
                          FirebaseFirestore.instance.collection('userInfo');
                      var docSnapshot = await collection.doc(value.uid).get();
                      if (docSnapshot.exists) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => Display(
                                    user: value,
                                  )),
                        );
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => InfoScreen(
                                    data: value,
                                  )),
                        );
                      }
                    }
                  },
                );
              }),
              child: Center(
                child: Container(
                  width: 80,
                  height: 80,
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(50)),
                  child: Image.network(
                    "https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/1200px-Google_%22G%22_Logo.svg.png",
                    height: 40,
                    width: double.infinity,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
