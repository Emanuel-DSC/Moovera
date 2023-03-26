import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:video_player/video_player.dart';
import '../controllers/video_player_controller.dart';

class MoviePlayerScreen extends StatelessWidget {
  const MoviePlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text('watch your movie below'.toUpperCase()),
        leading: IconButton(
          icon: const Icon(LineAwesomeIcons.angle_left),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: const Center(child: 
      VideoPlayerView(
        dataSourceType: DataSourceType.network, 
        url: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4',
        ),
      ),
    );
  }
}