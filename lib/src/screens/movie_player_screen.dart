import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:video_player/video_player.dart';
import '../controllers/video_player_controller.dart';

class MoviePlayerScreen extends StatelessWidget {
  const MoviePlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(LineAwesomeIcons.angle_left, color: isDarkMode ? Colors.white : Colors.black,),
          onPressed: () {
            Navigator.of(context).pop();
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitUp]);
          },
        ),
      ),
      body: const Center(
        child: VideoPlayerView(
          dataSourceType: DataSourceType.network, 
          url: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4',
          ),
      ),
    );
  }
}