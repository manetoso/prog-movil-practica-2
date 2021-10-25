import 'package:flutter/material.dart';
import 'package:practica_2/src/database/database_helper.dart';
import 'package:practica_2/src/models/popular_movies_model.dart';
import 'package:practica_2/src/network/api_popular.dart';
import 'package:practica_2/src/providers/movie_list_provider.dart';
import 'package:practica_2/src/providers/ui_provider.dart';
import 'package:practica_2/src/screens/movies_screens/favorite_movies.dart';
import 'package:practica_2/src/views/card-popular.dart';
import 'package:practica_2/src/views/customBottomNavBar.dart';
import 'package:provider/provider.dart';

class PopularScreen extends StatefulWidget {
  PopularScreen({Key? key}) : super(key: key);

  @override
  _PopularScreenState createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {
  ApiPopular? apiPopular;

  @override
  void initState() {
    super.initState();
    apiPopular = ApiPopular();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _headerChildContent(),
      bottomNavigationBar: CustomNavigationBar(),
    );
  }

  _headerChildContent() {
    final uiProvider = Provider.of<UiProvider>(context);
    final currentIndex = uiProvider.selectedMenuOpt;
    final movieListProvider = Provider.of<MovieListProvider>(context, listen: false);

    switch( currentIndex ) {
      case 0:
        return FutureBuilder(
          future: apiPopular!.getAllPopular(),
          builder: (
            BuildContext context,
            AsyncSnapshot<List<PopularMoviesModel>?> snapshot
          ) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Hay un error en la petición'),
              );
            } else {
              if (snapshot.connectionState == ConnectionState.done) {
                return _listPopularMovies(snapshot.data);
              } else {
                return CircularProgressIndicator();
              }
            }
          });

      case 1:
        movieListProvider.loadMovies();
        return FavoritesMoviesScreen();
    }
  }

  Widget _listPopularMovies(List<PopularMoviesModel>? movies) {
    return ListView.separated(
        itemBuilder: (context, index) {
          PopularMoviesModel popular = movies![index];
          return CardPopularView(popular: popular);
          // return Center(child: Text(popular.title!),);
        },
        separatorBuilder: (_, __) => Divider(
              height: 10,
            ),
        itemCount: movies!.length);
  }
}