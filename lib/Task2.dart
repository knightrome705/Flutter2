import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Work2 extends StatefulWidget {
  const Work2({Key? key}) : super(key: key);

  @override
  State<Work2> createState() => _Work2State();
}

class _Work2State extends State<Work2> {
  TextEditingController name=TextEditingController();
  TextEditingController phone=TextEditingController();
  var value;
  add()async{
    var data={
      "name":name.text,
      "phone":phone.text
    };
    await FirebaseFirestore.instance.collection("Production").add(data);
    get();
  }
  get()async{
    value=await FirebaseFirestore.instance.collection("Production").get();
    setState(() {

    });
  }
  @override
  void initState() {
    get();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: name,
            decoration: InputDecoration(
                label: Text("name"),
                border: OutlineInputBorder()
            ),
          ),
          SizedBox(
            height: 30,
          ),
          TextField(
              controller: phone,
              decoration: InputDecoration(
                  label: Text("phone"),
                  border: OutlineInputBorder()
              )
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(onPressed:(){
            add();
          }, child:Text("Submit")),
          value==null?SizedBox():Expanded(
            child: ListView.builder(
                itemCount:value.docs.length,
                itemBuilder: (context,index) {
                  return Column(
                    children: [
                      Column(
                        children: [
                          Text(value.docs[index].data()["name"]),
                          Text(value.docs[index].data()["phone"].toString()),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      )
                    ],
                  );
                }
            ),
          )
        ],
      ),
    );
  }
}
