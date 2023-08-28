import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Store extends StatefulWidget {
  const Store({Key? key}) : super(key: key);

  @override
  State<Store> createState() => _StoreState();
}

class _StoreState extends State<Store> {
  TextEditingController controller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.blue,
    ),
      body: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              label: Text("add Data"),
              border: OutlineInputBorder()
            ),
          ),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(onPressed: ()async{
            Map<String,dynamic> data={"name":controller.text};
             await FirebaseFirestore.instance.collection("Detils").add(data);
          }, child:Text("Add Data")),
          ElevatedButton(onPressed: ()async{
           var data= await FirebaseFirestore.instance.collection("Details").get();
            var data1=data.docs[0].data()["email"];
            print(data1);
          }, child:Text("get data"))
        ],
      ),
    );
  }
}
