import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Work extends StatefulWidget {
  const Work({Key? key}) : super(key: key);

  @override
  State<Work> createState() => _WorkState();
}

class _WorkState extends State<Work> {
  TextEditingController name=TextEditingController();
  TextEditingController phone=TextEditingController();
  var value;
  int count=0;
  add()async{
    var data={
      "name":name.text,
      "phone":phone.text
    };
    await FirebaseFirestore.instance.collection("Production").add(data);

  }
  Future<dynamic> get()async{
    value=await FirebaseFirestore.instance.collection("Production").get();
    return value;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          TextField(
            controller: name,
            decoration: InputDecoration(
                label: Text("name"),
              border: OutlineInputBorder()
            ),
          ),
          TextField(
            controller: phone,
          decoration: InputDecoration(
            label: Text("phone"),
          border: OutlineInputBorder()
          )
          ),
          ElevatedButton(onPressed:(){
            add();
          }, child:Text("Submit")),
          SizedBox(
            height: 500,
            child: FutureBuilder(
              future: get(),
              builder: (context,snapshot) {
                if(snapshot.hasData){
                  return Column(
                    children: [
                      value==null?SizedBox():Text(snapshot.data.docs[3].data()["name"]),
                      value==null?SizedBox():Text(snapshot.data.docs[3].data()["phone"].toString())
                    ],
                  );
                }
                else if(snapshot.connectionState==ConnectionState.waiting){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                else{
                  return Center(
                    child: Text("Something went wrong"),
                  );
                }
              }
            ),
          )
        ],
      ),
    );
  }
}
