import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth extends StatefulWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  sigin()async{
    try {
      var userCrenditails = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: email.text, password: password.text);

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
  siginwithgoogle()async{
   GoogleSignInAccount? googleSignInAccount=await GoogleSignIn().signIn();
   if(googleSignInAccount!=null){
    GoogleSignInAuthentication googleSignInAuthentication=await googleSignInAccount.authentication;

    var credential=GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken
    );
    await FirebaseAuth.instance.signInWithCredential(credential);
   }
  }
  googlesignout()async{
    await GoogleSignIn().signOut();
   await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          TextField(
            controller: email,
            decoration: InputDecoration(
              hintText: "email",
              label: Text("Enter email"),
              border: OutlineInputBorder(
              )
            ),
          ),
          SizedBox(
            height: 20,),
          TextField(
            controller: password,
            decoration: InputDecoration(
              hintText:"passwors",
              label: Text("password"),
              border: OutlineInputBorder()
            ),
          ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            ElevatedButton(onPressed: (){
              sigin();
            }, child: Text("signupwithemail")),
            SizedBox(
              width: 80,
            ),
            GestureDetector(
              onTap: (){
                siginwithgoogle();
              },
              child: Container(
                height: 30,
                width: 130,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  image: DecorationImage(
                    image: NetworkImage("https://blog.hubspot.com/hubfs/image8-2.jpg")
                  )
                ),
              ),
            )],
        ),
      ),
          ElevatedButton(onPressed: (){
            googlesignout();
          }, child:Text("signout")),
        ],
      ),
    );
  }
}
