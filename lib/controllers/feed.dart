import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<RiveAnimation>(
          future: displayAnimation(),
          builder:
              (BuildContext context, AsyncSnapshot<RiveAnimation> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Text('Error: ${snapshot.error}');
              }
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  Future<RiveAnimation> displayAnimation() async {
    final riveFile = await RiveFile.asset('assets/rives-animated-emojis.riv');
    return RiveAnimation.direct(riveFile);
  }
}
