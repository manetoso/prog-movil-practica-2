import 'package:flutter/material.dart';
import 'package:practica_2/src/database/database_helper.dart';
import 'package:practica_2/src/models/popular_movies_model.dart';

class CardPopularView extends StatelessWidget {
  final PopularMoviesModel popular;

  const CardPopularView({
    Key? key,
    required this.popular,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DatabaseHelper _databaseHelper = DatabaseHelper();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black87,
            offset: Offset(0, 5),
            blurRadius: 2.5,
          )
        ]
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              child: Hero(
                tag: 'dash${popular.id}',
                child: Image(image: NetworkImage('https://image.tmdb.org/t/p/w500/${popular.backdropPath}'),),
              ),
            ),
            Opacity(
              opacity: 0.5,
              child: Container(
                height: 60.0,
                color: Colors.black,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(popular.title!, style: TextStyle(color: Colors.white, fontSize: 12),),
                    MaterialButton(
                      onPressed: () async {
                        var test = await _databaseHelper.recognizeMovie(popular.id.toString());
                        Navigator.pushNamed(
                          context,
                          '/movie-detail',
                          arguments: {
                            'title': popular.title,
                            'overview': popular.overview,
                            'posterPath': popular.posterPath,
                            'id': popular.id.toString(),
                            'isFavorite': test
                          },
                        );
                      },
                      child: Icon(Icons.chevron_right, color: Colors.white,),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}