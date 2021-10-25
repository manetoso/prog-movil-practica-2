import 'package:flutter/material.dart';
import 'package:practica_2/src/database/database_helper.dart';
import 'package:practica_2/src/providers/movie_list_provider.dart';
import 'package:provider/provider.dart';

class FavoritesMoviesScreen extends StatelessWidget {

    @override
    Widget build(BuildContext context) {
      final movieListProvider = Provider.of<MovieListProvider>(context);
      final movies = movieListProvider.movies;
      DatabaseHelper _databaseHelper = DatabaseHelper();

      return Scaffold(
        body: ListView.builder(
          itemCount: movies.length,
          itemBuilder: (_, i) => Dismissible(
            onDismissed: (DismissDirection direction) {
              movieListProvider.deleteMovie(movies[i]!.idMovie!);
            },
            direction: DismissDirection.endToStart,
            key: UniqueKey(),
            background: Container(
              padding: EdgeInsets.only(right: 30),
              color: Colors.red,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Icon(Icons.delete, color: Colors.white, size: 30,)
                ],
              ),
            ),
            child: ListTile(
              onTap: () async {
                var test = await _databaseHelper.recognizeMovie(movies[i]!.idMovie!);
                Navigator.pushNamed(
                  context,
                  '/movie-detail',
                  arguments: {
                    'title': movies[i]!.title,
                    'overview': movies[i]!.overview,
                    'posterPath': movies[i]!.posterPath,
                    'id': movies[i]!.idMovie,
                    'isFavorite': test
                  },
                );
              },
              title: Text(
                '${movies[i]!.title}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: Color(0xFF5D6065),
                )
              ),
              subtitle: Text(
                '${movies[i]!.overview!.substring(0, 40)}...',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 13.0,
                    color: Color.fromRGBO(93, 96, 101, 0.5),
                  )
              ),
              trailing: Icon(Icons.chevron_right, color: Colors.grey,),
            ),
          ),
        ),
      );
    }
}