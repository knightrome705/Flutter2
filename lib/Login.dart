import 'package:firebase/Signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  login() async {
    try {
      var userCrenditails = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: controller1.text, password: controller2.text);
    } catch (e) {
      String error = e.toString();
      print(error);
      if (error.contains("The email address is badly formatted."))
      {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(backgroundColor: Colors.red,content: Text("The email address is badly formatted.")));
      }
      else if(error.contains("Unable to establish connection on channel.")){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.red,content: Text("Unable to establish connection on channel.")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controller1,
              decoration: InputDecoration(
                  label: Text("Enter email"), border: OutlineInputBorder()),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controller2,
              decoration: InputDecoration(
                  label: Text("Enter password"), border: OutlineInputBorder()),
            ),
          ),
          SizedBox(
              width: 350,
              child: ElevatedButton(
                  onPressed: () {
                    login();
                  },
                  child: Text("login"))),
          ElevatedButton(onPressed: (){
            FirebaseAuth.instance.signOut();
          }, child:Text("Signout"))
        ],
      ),
    );
  }
}
