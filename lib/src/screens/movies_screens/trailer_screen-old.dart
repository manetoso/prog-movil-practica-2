import 'package:flutter/material.dart';
import 'package:practica_2/src/views/videoPlayerWidget.dart';
import 'package:video_player/video_player.dart';

class TrailerScreenOld extends StatefulWidget {
  final String? videoKey;
  TrailerScreenOld({Key? key, this.videoKey}) : super(key: key);

  @override
  _TrailerScreenState createState() => _TrailerScreenState();
}

class _TrailerScreenState extends State<TrailerScreenOld> {
  late VideoPlayerController _videoController;
  String? link;
  // late Future<void> _initializeVideoPlayerFuture;

  // @override
  // void initState() {
  //   _videoController = VideoPlayerController.network(
  //     'https://www.youtube.com/watch?v=${widget.videoKey}'
  //   );
  //   _initializeVideoPlayerFuture = _videoController.initialize();
  //   _videoController.setLooping(true);

  //   super.initState();
  // }

  @override
  void initState() {
    super.initState();
    link = 'https://www.youtube.com/watch?v=${widget.videoKey}.mp4';
    _videoController = VideoPlayerController.network(
      'https://www.youtube.com/watch?v=${widget.videoKey}.mp4'
    )
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((_) => _videoController.play());
  }

  @override
  void dispose() {
    _videoController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('---- VIDEO LINK ----');
    print(link);
    return VideoPlayerWidget(controller: _videoController);

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