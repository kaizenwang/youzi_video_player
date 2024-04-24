import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  VideoPlayerWidget(this.videoUrl, {super.key});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));

    _initializeVideoPlayerFuture = _controller.initialize();
    _initializeVideoPlayerFuture.then((_) {
      setState(() {
        _controller.play();
      });
    });
  }

  void _changeVideoSource(String videoUrl) {
    debugPrint('_changeVideoSource');
    _controller.seekTo(Duration.zero);
    _controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl));
    _initializeVideoPlayerFuture = _controller.initialize();
    _initializeVideoPlayerFuture.then((_) {
      setState(() {
        _controller.play();
      });
    });
  }

  @override
  void didUpdateWidget(covariant VideoPlayerWidget oldWidget) {
    debugPrint('didUpdateWidget');
    if (oldWidget.videoUrl != widget.videoUrl) {
      _changeVideoSource(widget.videoUrl);
    } else {
      _replay();
    }
    super.didUpdateWidget(oldWidget);
  }

  void _replay() {
    _controller.seekTo(Duration.zero);
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      alignment: Alignment.center,
      child: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('Video Player'),
    //   ),
    //   body: Row(
    //     children: <Widget>[
    //       Expanded(
    //           flex: 7,
    //           child: Container(
    //             color: Colors.black,
    //             child: Center(
    //               child: FutureBuilder(
    //                 future: _initializeVideoPlayerFuture,
    //                 builder: (context, snapshot) {
    //                   if (snapshot.connectionState == ConnectionState.done) {
    //                     return AspectRatio(
    //                       aspectRatio: _controller.value.aspectRatio,
    //                       child: VideoPlayer(_controller),
    //                     );
    //                   } else {
    //                     return const Center(
    //                       child: CircularProgressIndicator(),
    //                     );
    //                   }
    //                 },
    //               ),
    //             ),
    //           )),
    //       const Expanded(
    //         flex: 3,
    //         child: FittedBox(
    //           child: FlutterLogo(),
    //         ),
    //       ),
    //     ],
    //   ),
    //   floatingActionButton: FloatingActionButton(
    //     onPressed: () {
    //       setState(() {
    //         if (_controller.value.isPlaying) {
    //           _controller.pause();
    //         } else {
    //           _controller.play();
    //         }
    //       });
    //     },
    //     child: Icon(
    //       _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
    //     ),
    //   ),
    // );
  }
}
