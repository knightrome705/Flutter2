import 'package:firebase/counterprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class Martin extends StatefulWidget {
  const Martin({Key? key}) : super(key: key);

  @override
  State<Martin> createState() => _MartinState();
}

class _MartinState extends State<Martin> {
  @override

  Widget build(BuildContext context) {
    print("ui once loaded");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<Works>(
              builder: (context,value,_) {
                return Text(value.count.toString());
              }
            ),
            FloatingActionButton(onPressed: (){
              print("button loaded");
            Provider.of<Works>(context,listen: false).counter();
            })
          ],
        ),
      ),
    );
  }
}
