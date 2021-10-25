import 'package:flutter/material.dart';
import 'package:practica_2/src/providers/ui_provider.dart';
import 'package:provider/provider.dart';

class CustomNavigationBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    
    final currentIndex = uiProvider.selectedMenuOpt;

    return BottomNavigationBar(
      onTap: ( int i ) => uiProvider.selectedMenuOpt = i,
      currentIndex: currentIndex,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.trending_up_rounded),
          label: 'Populares'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_rounded),
          label: 'Favoritas'
        ),
      ],
    );
  }
}