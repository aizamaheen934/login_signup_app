import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {


  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade300,
        title: Text("Login Page"),
      ),
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.blue.shade300],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        // Email and Password
        child: Column(
          children: [
            SizedBox(height: 24),
            Padding(
              padding: EdgeInsetsGeometry.only(left: 33, right: 33),
              child: TextField(
                controller: passwordController,
                autofocus: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.password),
                  hint: Text("Enter Your Password"),
                  hintStyle: TextStyle(color: Colors.blueGrey),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.blue.shade500)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.white, width: 5),
                  ),

                ),
              ),
            ),
            SizedBox(height: 24),
            Padding(
              padding: EdgeInsetsGeometry.only(left: 33, right: 33),
              child: TextField(
                controller: emailController,
                autofocus: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  hint: Text("Enter Your Email"),
                  hintStyle: TextStyle(color: Colors.blueGrey),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.blue.shade500)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.white, width: 5),
                  ),

                ),
              ),
            ),
            SizedBox(height: 44,),
            InkWell(
              child: Container(
                alignment: Alignment.center,
                color: Colors.blue,
                width: 164,
                height: 66,
                child: Text("Login", style: TextStyle(color: Colors.black),),
              ),
              onTap: () => Login(),
            ),
            SizedBox(height: 24,),


          ],
        ),
      ),
    );
  }

  Future<void> Login() async {
    String email = emailController.text;
    String password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      Fluttertoast.showToast(msg: "Enter email and password");
      return;
    }

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
        msg: e.message ?? "Login failed",
      );
    }
  }
}


