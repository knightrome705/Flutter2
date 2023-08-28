import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/Streambuilder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Update extends StatefulWidget {
  String? id;
  String data;
  Update({required this.id,required this.data});

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  TextEditingController controller=TextEditingController();
  @override
  void initState() {
    controller.text=widget.data!;
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder()
            ),
          ),
          ElevatedButton(onPressed: ()async{
            try{
             await FirebaseFirestore.instance.collection("dummy_data").doc(widget.id).update({"name":controller.text});
             Navigator.of(context).push(MaterialPageRoute(builder: (builder)=>Strm()));

            }
            catch(e){
              String error=e.toString();
              print(error);
            }
          }, child:Text("update"))
        ],
      ),
    );
  }
}
