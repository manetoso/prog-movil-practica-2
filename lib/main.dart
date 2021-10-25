import 'package:flutter/material.dart';
import 'package:practica_2/src/providers/movie-provider.dart';
import 'package:practica_2/src/providers/movie_list_provider.dart';
import 'package:practica_2/src/providers/ui_provider.dart';
import 'package:practica_2/src/screens/agregar_nota_screen.dart';
import 'package:practica_2/src/screens/edit_user_screen.dart';
import 'package:practica_2/src/screens/intenciones_screen.dart';
import 'package:practica_2/src/screens/movies_screens/detail_screen.dart';
import 'package:practica_2/src/screens/movies_screens/popular_screen.dart';
import 'package:practica_2/src/screens/movies_screens/trailer_screen.dart';
import 'package:practica_2/src/screens/notas_screen.dart';
import 'package:practica_2/src/screens/profile_screen.dart';
import 'package:practica_2/src/screens/propinas_screen.dart';
import 'package:provider/provider.dart';
import 'package:practica_2/src/screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _ ) => new MovieListProvider()),
        ChangeNotifierProvider(create: ( _ ) => new UiProvider()),
      ],
      child: MaterialApp(
          routes: {
            '/propinas': (BuildContext context) => PropinasScreen(),
            '/intenciones': (BuildContext context) => IntencionesScreen(),
            '/notas': (BuildContext context) => NotasScreen(),
            '/agregar': (BuildContext context) => AgregarNotasScreen(),
            '/profile-info': (BuildContext context) => ProfileScreen(),
            '/profile-edit': (BuildContext context) => EditUserScreen(),
            '/movie-popular': (BuildContext context) => PopularScreen(),
            '/movie-trailer': (BuildContext context) => TrailerScreen(),
            '/movie-detail': (_) => ChangeNotifierProvider(
              create: (_) => MovieProvider(),
              child: DetailScreen(),
            ),
          },
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        ),
    );
  }
}
