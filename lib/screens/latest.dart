import 'package:blog_web_site/values/values.dart';
import 'package:blog_web_site/widgets/page_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class LatestThingsScreen extends StatefulWidget {
  const LatestThingsScreen({Key? key}) : super(key: key);

  @override
  State<LatestThingsScreen> createState() => _LatestThingsScreenState();
}

class _LatestThingsScreenState extends State<LatestThingsScreen> {
  final YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'NRk3qahZ9hE',
    params: const YoutubePlayerParams(
      //playlist: ['nPt8bK2gbaU', 'gQDByCdjUXw'], // Defining custom playlist
      startAt: Duration(seconds: 0),
      showControls: true,
      showFullscreenButton: true,
      enableCaption: false,
    ),
  );
  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      title: StringConst.latestProjects,
      body: SingleChildScrollView(
        child: Container(
          decoration:
              BoxDecoration(color: Theme.of(context).colorScheme.background),
          child: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text("En Son Youtube Videosu"),
                Container(
                  constraints: const BoxConstraints(maxWidth: 750),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: YoutubePlayerIFrame(
                      controller: _controller,
                      aspectRatio: 16 / 9,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.arrow_circle_down),
        onPressed: () {},
      ),
    );
  }
}
