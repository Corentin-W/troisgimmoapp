import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
        body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          displayPost(),
          displayPost(),
          displayPost(),
          displayPost(),
          displayPost(),
        ],
      ),
    ));
  }

  Widget displayPost() {
    return Padding(
      padding: EdgeInsets.all(2),
      child: SizedBox(
        height: 400,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [rowPost(), imagePost(), socialsPost()],
        ),
      ),
    );
  }

  rowPost() {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Row(
        children: [
          const CircleAvatar(
              radius: 23,
              backgroundColor: Color(0xff87d300),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://avatarfiles.alphacoders.com/223/223913.jpg"),
                radius: 20,
              )),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              "Corentin Waucampt",
              style: GoogleFonts.poppins(
                  textStyle:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            ),
          ),
          Spacer(),
          Icon(Icons.menu_open),
        ],
      ),
    );
  }

  imagePost() {
    return Image.network(
        'https://imageio.forbes.com/specials-images/dam/imageserve/1171238184/0x0.jpg?format=jpg&width=1200');
  }

  socialsPost() {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Column(children: [
        Row(children: [
          Icon(
            Icons.favorite_border,
          ),
          Icon(
            Icons.mode_comment,
          ),
        ]),
        Row(
          children: [
            Text(
              "4 likes",
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(fontWeight: FontWeight.bold)),
            )
          ],
        )
      ]),
    );
  }
}
