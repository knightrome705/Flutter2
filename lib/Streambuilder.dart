import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/Update.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Strm extends StatefulWidget {

  @override
  State<Strm> createState() => _StrmState();
}

class _StrmState extends State<Strm> {
  TextEditingController controller=TextEditingController();
  add()async{
    await FirebaseFirestore.instance.collection("dummy_data").add({"name":controller.text});
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
            controller: controller,
            decoration: InputDecoration(
              label: Text("Enter data"),
              border: OutlineInputBorder()
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(onPressed: (){
            add();
          }, child:Text("Submit")),
          SizedBox(
            height: 20,
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection("dummy_data").snapshots(),
            builder: (context,snapshot) {
              if(snapshot.hasData){
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context,index) {
                        return Row(
                          children: [
                            GestureDetector(
                              onTap: (){
                                 Navigator.of(context).push(MaterialPageRoute(builder: (builder)=>Update(id:snapshot.data!.docs[index].id,data:snapshot.data!.docs[index].data()["name"],)));
                              },
                                child: Text(snapshot.data!.docs[index].data()["name"])),
                            GestureDetector(
                              onTap: ()async{

                                 await FirebaseFirestore.instance.collection("dummy_data").doc(snapshot.data!.docs[index].id).delete();
                              },
                                child: Icon(Icons.delete,color:Colors.red,size: 30,)
                            )
                          ],
                        );
                      }
                  ),
                );
              }else{
                return Center(
                  child: Text("Something wrong"),
                );
              }
              }

          )

        ],
      ),
    );
  }
}
