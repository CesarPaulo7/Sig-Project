import 'package:flutter/material.dart';

class UiProvider extends ChangeNotifier{

  int _selectMenuOpt= 1;

  int get selectMenuOpt{
    return this._selectMenuOpt;
  }

  set selectMenuOpt(int i){
    this._selectMenuOpt = i;
    notifyListeners();
  }


}