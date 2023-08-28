import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Stroage extends StatefulWidget {
  const Stroage({Key? key}) : super(key: key);

  @override
  State<Stroage> createState() => _StroageState();
}

class _StroageState extends State<Stroage> {
  getImage()async{
    ImagePicker imagePicker=ImagePicker();
   XFile? xFile=await imagePicker.pickImage(source:ImageSource.camera);
   if(xFile!=null){
     File file=File(xFile!.path);
     store(file);
   }
  }
  store(File file)async{
   var ref=await FirebaseStorage.instance.ref().child("image/${file.path}");
      await ref.putFile(file);
    var url= await ref.getDownloadURL();
    get(url);
  }
  get( var url){
    var data={"image":url};
    FirebaseFirestore.instance.collection("dummy_data").add(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: Column(
        //crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(onPressed: (){
            getImage();
          }, child:Text("image_pick"))
        ],
      ),
    );
  }
}
