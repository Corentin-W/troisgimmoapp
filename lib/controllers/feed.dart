import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cached_network_image/cached_network_image.dart';

class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  List? imageList;

  // @override
  // void initState() {
  //   super.initState();
  //   getAllPostsForFeed();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: getAllPostsForFeed(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List? urls = snapshot.data;
              return ListView.builder(
                  shrinkWrap: true,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount: urls?.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        displayPost(
                            urlPicture: urls![index],
                            urlProfilPicture:
                                'https://cdn.pixabay.com/photo/2023/01/28/19/22/ai-generated-7751582_960_720.jpg',
                            nbLikes: 12,
                            title:
                                "Brainstorming avec les collègues de la région, bon apéro à tous !!"),
                        Container(height: 10),
                        const Divider(),
                        Container(height: 10),
                      ],
                    );
                  });
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  Future<List> getAllPostsForFeed() async {
    List urls = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Feed url')
        .orderBy('date', descending: true)
        .get();
    for (var element in querySnapshot.docs) {
      urls.add(element['url']);
    }
    return urls;
  }

  Widget gridview() {
    print(imageList);
    return Text("cocolabricot");
  }

  Widget displayPost(
      {required String urlPicture,
      required String urlProfilPicture,
      required String title,
      required int nbLikes}) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            rowPost(urlProfilPicture: urlProfilPicture),
            imagePost(urlPicture: urlPicture),
            socialsPost(title: title, likes: nbLikes)
          ],
        ),
      ),
    );
  }

  rowPost({required String urlProfilPicture}) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Row(
        children: [
          CircleAvatar(
              radius: 23,
              backgroundColor: const Color(0xff87d300),
              child: CircleAvatar(
                backgroundImage: NetworkImage(urlProfilPicture),
                radius: 20,
              )),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              "Corentin Waucampt",
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold)),
            ),
          ),
          const Spacer(),
          const Icon(Icons.menu_open),
        ],
      ),
    );
  }

  imagePost({required String urlPicture}) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: CachedNetworkImage(imageUrl: urlPicture),
    );
  }

  socialsPost({required String title, required int likes}) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(fontStyle: FontStyle.italic))),
            )
          ],
        ),
        Row(children: [
          const Icon(
            Icons.favorite_border,
          ),
          Text(
            "$likes likes",
            style: GoogleFonts.poppins(
                textStyle: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          const Spacer(),
          Text('Il y a 12min',
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(fontWeight: FontWeight.bold)))
        ]),
      ]),
    );
  }
}
