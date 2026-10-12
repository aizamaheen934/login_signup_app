import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';

class SignUpScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return SignUpScreenState();
  }

}
class SignUpScreenState extends State {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  String errorMessage = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade300,
        title: Text("Sign Up Page"),
      ),
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [ Colors.white, Colors.blue.shade300],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
        ),

        //Name, password , confirmpassword
        child: Column(
          children: [
            SizedBox(height: 44,),
            Text("Fill Out Your Form!",
              style: TextStyle(color: Colors.blue.shade500,
                fontWeight: FontWeight.bold,
                fontSize: 24,),),
            SizedBox(height: 24),
            Padding
              (padding: EdgeInsetsGeometry.only(left: 33, right: 33),
                child: TextField(
                  controller: usernameController,
                  autofocus: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hint: Text("Enter User Name!"),
                    hintStyle: TextStyle(color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                          color: Colors.blue.shade500, width: 2.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.white, width: 5),
                    ),
                  ),
                )),
            Padding(
              padding: EdgeInsetsGeometry.only(left: 33, right: 33),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  hint: Text("Enter Email!"),
                  hintStyle: TextStyle(color: Colors.black),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Colors.blue.shade500,
                      width: 2.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 5,
                    ),
                  ),
                ),
              ),
            ),

            Padding
              (padding: EdgeInsetsGeometry.only(left: 33, right: 33),
                child: TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hint: Text("Enter Password!"),
                    hintStyle: TextStyle(color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                          color: Colors.blue.shade500, width: 2.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.white, width: 5),
                    ),
                  ),
                )),

            Padding
              (padding: EdgeInsetsGeometry.only(left: 33, right: 33),
                child: TextField(controller: confirmpasswordController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hint: Text("Enter Confirm Password!"),
                    hintStyle: TextStyle(color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                          color: Colors.blue.shade500, width: 2.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.white, width: 5),
                    ),
                  ),
                )),
            SizedBox(height: 44,),
            InkWell(child: Container(
              alignment: Alignment.center,
              color: Colors.orange,
              width: 164,
              height: 66,
              child: Text("Sign Up", style: TextStyle(color: Colors.black),),
            ), onTap: () => signup(),),
            SizedBox(height: 24,),
            Text(
              errorMessage, style: TextStyle(color: Colors.red, fontSize: 25),),

          ],
        ),
      ),

    );
  }

  Future<void> signup() async {
    String email = emailController.text;
    String password = passwordController.text;
    String confirmPassword = confirmpasswordController.text;

    if (usernameController.text.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      setState(() => errorMessage = "Fill all fields");
      return;
    }

    if (password != confirmPassword) {
      setState(() => errorMessage = "Passwords do not match");
      return;
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } on FirebaseAuthException catch (e) {
      setState(() => errorMessage = e.message ?? "Signup failed");
    }
  }
}
