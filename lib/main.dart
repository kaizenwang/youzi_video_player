import 'package:flutter/material.dart';
import 'package:youzi_video_player/widget/video_player_widget.dart';

void main() {
  runApp(const VideoPlayerApp());
}

class VideoPlayerApp extends StatelessWidget {
  const VideoPlayerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Video Player Demo', home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late VideoPlayerWidget videoPlayerWidget = VideoPlayerWidget('');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Player'),
      ),
      body: Row(
        children: [
          Expanded(
            flex: 7,
            child: videoPlayerWidget,
          ),
          const Expanded(
            flex: 3,
            child: FlutterLogo(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            videoPlayerWidget = VideoPlayerWidget('https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4');
          });
        },
      ),
    );
  }
}
