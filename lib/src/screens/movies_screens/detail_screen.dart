import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:practica_2/src/models/cast_model.dart';
import 'package:practica_2/src/models/movie_video_model.dart';
import 'package:practica_2/src/network/api_popular.dart';
import 'package:practica_2/src/providers/movie-provider.dart';
import 'package:practica_2/src/providers/movie_list_provider.dart';
import 'package:practica_2/src/screens/movies_screens/trailer_screen.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      final movie = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;  
      final size = MediaQuery.of(context).size;
      final provider = Provider.of<MovieProvider>(context);
      final movieListProvider = Provider.of<MovieListProvider>(context, listen: false);


      ApiPopular apiPopular = ApiPopular();

      if (movie['isFavorite']) {
        provider.setIsFavoriteWithoutListener = true;
        movie['isFavorite'] = false;
      }
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.8,
                width: double.infinity,
                child: Stack(
                  children: [
                    Container(
                      child: Hero(
                        tag: 'dash${movie['id']}',
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                          child: Image(
                            image: NetworkImage('https://image.tmdb.org/t/p/w500/${movie['posterPath']}'),
                            fit: BoxFit.cover,
                          )
                        )
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 15, top: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () async {
                              if (!provider.isFavorite) {
                                await movieListProvider.insertNewMovie(
                                  movie['title'],
                                  movie['overview'],
                                  movie['posterPath'],
                                  movie['id']
                                );
                                await Future.delayed(Duration(milliseconds: 500));
                                _customDialog(context, 'Agregada', 'Pélicula agregada a favoritas');
                                provider.setIsFavorite = true;
                              } else {
                                await movieListProvider.deleteMovie(movie['id']);
                                await Future.delayed(Duration(milliseconds: 500));
                                _customDialog(context, 'Eliminada', 'Pélicula eliminada de favoritas');
                                provider.setIsFavorite = false;
                              }
                            },
                            icon: Icon(
                              provider.isFavorite
                                ? Icons.favorite_rounded
                                : Icons.favorite_border_rounded,
                              color: Colors.red,
                              size: 40,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 25, vertical: 40),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Text('Resumen:', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                    ),
                    Text(
                      '${movie['overview']}',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black54
                      ),
                    ),
                    FutureBuilder(
                      future: apiPopular.getMovieVideo(movie['id']),
                      builder: (
                        BuildContext context,
                        AsyncSnapshot<List<MovieVideoModel>?> snapshot
                      ) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text('Hay un error en la petición'),
                          );
                        } else {
                          if (snapshot.connectionState == ConnectionState.done) {
                            List<MovieVideoModel>? movies = snapshot.data;
                            MovieVideoModel movie = movies![1];
                            return Row(
                              children: [
                                MaterialButton(
                                  child: Text('Ver Tráiler'),
                                  color: Colors.black,
                                  textColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  onPressed: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => TrailerScreen(videoKey: movie.key,)
                                      )
                                    );
                                  },
                                ),
                              ],
                            );
                          } else {
                            return CircularProgressIndicator();
                          }
                        }
                      }
                    )
                  ],
                )
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, bottom: 20),
                child: Row(
                  children: [
                    Text('Casting:', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),)
                  ],
                ),
              ),
              SizedBox(
                height: 100,
                width: double.infinity,
                child: FutureBuilder(
                  future: apiPopular.getCast(movie['id']),
                  builder: (
                    BuildContext context,
                    AsyncSnapshot<List<CastModel>?> snapshot
                  ) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Hay un error en la petición'),
                      );
                    } else {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return _listCast(snapshot.data);
                      } else {
                        return CircularProgressIndicator();
                      }
                    }
                  }
                ),
              ),
              SizedBox(height: 50,)
            ],
          ),
        )
      );
    }

  Future<dynamic> _customDialog(BuildContext context, String title, String content) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.close, color: Color(0xFF5D6065),)
            )
          ],
          content: SizedBox(
            height: 60,
            child: Column(
              children: [
                Text(title, style: TextStyle(
                  color: Color(0xFF5D6065),
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0
                ),),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Text(content, style: TextStyle(
                      color: Color.fromRGBO(93, 96, 101, 0.5),
                      fontWeight: FontWeight.normal,
                      fontSize: 13.0
                    ),),
                  ],
                ),
              ],
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          backgroundColor: Color(0xFFFDFDFD),
        );
      });
  }

  Widget _listCast(List<CastModel>? castResult) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          CastModel cast = castResult![index];
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 50,
                  width: 50,
                  // color: Colors.red,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    image: DecorationImage(
                      image: cast.profilePath!.length > 2
                        ? NetworkImage('https://image.tmdb.org/t/p/w500/${cast.profilePath}')
                        : NetworkImage('https://www.slotcharter.net/wp-content/uploads/2020/02/no-avatar.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 20,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Nombre:', style: TextStyle(fontWeight: FontWeight.bold),),
                    Text('${cast.name}'),
                    Text('Personaje:', style: TextStyle(fontWeight: FontWeight.bold),),
                    Text('${cast.character}'),
                  ],
                ),
              ],
            ),
          );
        },
        separatorBuilder: (_, __) => SizedBox(width: 25,),
        itemCount: castResult!.length
      ),
    );
  }
}
