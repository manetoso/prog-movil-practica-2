import 'package:flutter/material.dart';

class MovieProvider extends ChangeNotifier {
  bool isFavorite = false;

  bool get getIsFavorite => isFavorite;
  
  set setIsFavorite( bool value ) {
    this.isFavorite = value;
    notifyListeners();
  }

  set setIsFavoriteWithoutListener( bool value ) {
    this.isFavorite = value;
  }
}