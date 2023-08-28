import 'package:flutter/material.dart';

class Works extends ChangeNotifier{
  int count=0;
  counter(){
    count=count+1;
    notifyListeners();
  }
}