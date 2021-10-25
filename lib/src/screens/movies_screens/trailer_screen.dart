import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:practica_2/src/views/videoPlayerWidget.dart';
import 'package:video_player/video_player.dart';

class TrailerScreen extends StatefulWidget {
  final String? videoKey;
  TrailerScreen({Key? key, this.videoKey}) : super(key: key);

  @override
  _TrailerScreenState createState() => _TrailerScreenState();
}

class _TrailerScreenState extends State<TrailerScreen> {
  final FijkPlayer player = FijkPlayer();
  String? link;

  @override
  void initState() {
    super.initState();
    link = 'https://www.youtube.com/watch?v=${widget.videoKey}';
    player.setDataSource(
      'https://www.youtube.com/watch?v=${widget.videoKey}',
      autoPlay: true
    );
  }

  @override
  void dispose() {
    super.dispose();
    player.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('---- VIDEO LINK ----');
    print(link);
    return Scaffold(
      body: Center(
        child: FijkView(player: player,),
      ),
    );

    // return Scaffold(
    //   body: Center(
    //     child: FutureBuilder(
    //       future: _initializeVideoPlayerFuture,
    //       builder: (context, snapshot) {
    //         if (snapshot.connectionState == ConnectionState.done) {
    //           return AspectRatio(
    //             aspectRatio: _videoController.value.aspectRatio,
    //             child: VideoPlayer(_videoController),
    //           );
    //         } else {
    //           return const Center(
    //             child: CircularProgressIndicator(),
    //           );
    //         }
    //       },
    //     ),
    //   ),
    //   floatingActionButton: FloatingActionButton(
    //     onPressed: () {
    //       setState(() {
    //         if (_videoController.value.isPlaying) {
    //           _videoController.pause();
    //         } else {
    //           _videoController.play();
    //         }
    //       });
    //     },
    //     child: Icon(
    //       _videoController.value.isPlaying ? Icons.pause : Icons.play_arrow,
    //     ),
    //   ),
    // );
  }
}