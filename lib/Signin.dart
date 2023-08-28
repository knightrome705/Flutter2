import 'package:firebase/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Sigin extends StatefulWidget {
  const Sigin({Key? key}) : super(key: key);

  @override
  State<Sigin> createState() => _SiginState();
}

class _SiginState extends State<Sigin> {
  TextEditingController controller1=TextEditingController();
  TextEditingController controller2=TextEditingController();
  sigin()async{
    try {
      var userCrenditails = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: controller1.text, password: controller2.text);

    }
    catch(e){
      String error=e.toString();
      if(e.toString().contains("The email address is already in use by another account."))
      {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor:Colors.blue,elevation:10,content: Text("The email address is already in use by another account")));
      }
     else if(error.contains("The given password is invalid.")){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor:Colors.blue,elevation:10,content:Text("The given password is invalid")));
    }
     else if(error.contains("Unable to establish connection on channel.")){
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor:Colors.red,elevation:10,content: Text("Given String is empty or null")));
      }
     else if(error.contains("The email address is badly formatted.")){
       ScaffoldMessenger.of(context).showSnackBar(SnackBar( backgroundColor:Colors.red,elevation:10,content: Text("The email address is badly formatted")));
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Sigin.up"),
        centerTitle: true,
        actions: [Icon(Icons.more_vert)],
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                label: Text("Enter email"),
                border: OutlineInputBorder()
              ),
              controller: controller1,
            ),
          ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
              label: Text("password"),
              border: OutlineInputBorder()
            ),
            controller: controller2,
          ),
        ),
        SizedBox(
          width: 350,
            child: MaterialButton(
                color: Colors.red,
                onPressed:(){
              sigin();
            }, child:Text("Sigup")))
        ],
      ),
    );
  }
}
