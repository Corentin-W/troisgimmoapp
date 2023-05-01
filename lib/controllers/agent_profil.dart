import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:troisgimmoapp/controllers/picture_page.dart';
import 'package:troisgimmoapp/models/agent.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AgentProfil extends StatefulWidget {
  const AgentProfil({super.key});

  @override
  State<AgentProfil> createState() => _AgentProfilState();
}

class _AgentProfilState extends State<AgentProfil> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final db = FirebaseFirestore.instance;
    return LoaderOverlay(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(height: 20),
                headerRow(),
                // Container(height: 20),
                // infosRow(email: agent.email),
                // getConnectedUserInfos(),
                likesAndSavesBar(),
                Container(height: 5),
                SizedBox(
                  height: 1000,
                  child: futurebuilderPourGridPhotos(
                      screenWidth: screenWidth, screenHeight: screenHeight),
                ),
              ]),
        ),
      ),
    );
  }

  // Future<String> getConnectedUserInfos() async {
  //   Agent? instanceAgent;
  //   var email = "NONN";
  //   final FirebaseAuth auth = FirebaseAuth.instance;
  //   final User? user = auth.currentUser;
  //   final String userID = user!.uid;
  //   var result = await FirebaseFirestore.instance
  //       .collection('Users')
  //       .where('id', isEqualTo: userID)
  //       .get();
  //   var prenom = result.docs.first.data()['prenom'];
  //   var nom = result.docs.first.data()['nom'];
  //   var urlPhoto = result.docs.first.data()['urlPhoto'];
  //   email = result.docs.first.data()['email'];
  //   print(email);
  //   return email;
  //   // instanceAgent =
  //   //     Agent(prenom: prenom, nom: nom, email: email, photoProfil: urlPhoto);

  //   // return instanceAgent;
  // }

  Future<dynamic> queryForAgentInfos() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final String userID = user!.uid;
    var result = await FirebaseFirestore.instance
        .collection('Users')
        .where('id', isEqualTo: userID)
        .get();
    return result;
  }

  futurebuilderPourGridPhotos({required screenWidth, required screenHeight}) {
    return FutureBuilder<List>(
        future: getPicturesFromStorage(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            context.loaderOverlay.hide();
            return GridView.count(
              primary: false,
              crossAxisSpacing: 3,
              mainAxisSpacing: 3,
              crossAxisCount: 3,
              children: snapshot.data!
                  .map((url) => InkWell(
                        onTap: () {
                          onTapOnePhoto(url, screenWidth, screenHeight);
                        },
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: SizedBox.fromSize(
                              size: const Size.fromRadius(28),
                              child: Hero(
                                tag: url,
                                child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: url.toString()),
                              ),
                            )),
                      ))
                  .toList(),
            );
          } else {
            context.loaderOverlay.show();
          }
          return const Text('');
        });
  }

  onTapOnePhoto(url, screenWidth, screenHeight) {
    Navigator.push(context, MaterialPageRoute(builder: ((context) {
      return PicturePage(
              pathToImageFromProfil: url,
              nomberOfLikes: 0,
              index: 0,
              publishDate: "Il y a 2h")
          .displayPost(
              pathToImage: url,
              nomberOfLikes: 0,
              index: 0,
              publishDate: "Il y a 2h",
              screenWidth: screenWidth,
              screenHeight: screenHeight);
    })));
  }

  Future<List> getPicturesFromStorage() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final String userID = user!.uid;
    List urlList = [];
    final ListResult result =
        await FirebaseStorage.instance.ref('feed/$userID/images/').listAll();
    for (final ref in result.items) {
      final url = await ref.getDownloadURL();
      urlList.add(url.toString());
    }
    return urlList;
  }

  Widget likesAndSavesBar() {
    return Padding(
      padding: const EdgeInsets.all(1),
      child: Column(
        children: [
          const Divider(
            thickness: 0.5,
            color: Colors.grey,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Icon(Icons.favorite_border, size: 30),
              Icon(Icons.file_download_done, size: 30),
            ],
          ),
          const Divider(thickness: 0.5, color: Colors.grey)
        ],
      ),
    );
  }

  Column infosRow({required String email}) {
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
          Icon(Icons.phone),
        ]),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.email_outlined),
            Text(email,
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(color: Colors.grey)))
          ],
        )
      ],
    );
  }

  Widget headerRow() {
    final db = FirebaseFirestore.instance;
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final String userID = user!.uid;
    return StreamBuilder(
      stream: db.collection('Users').where('id', isEqualTo: userID).snapshots(),
      builder: (context, snpashot) {
        String urlPhoto = snpashot.data?.docs.single.data()["urlPhoto"] ??
            "https://www.3gimmobilier.com/Ressource/Logo/LOGO3G-2022-classique-header.png";

        String prenom = snpashot.data?.docs.single.data()["prenom"] ?? "3G";

        String nom = snpashot.data?.docs.single.data()["nom"] ?? "IMMO";
        return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(urlPhoto),
                  radius: 60,
                ),
                Column(
                  children: [
                    Text(
                      prenom,
                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w800,
                              fontStyle: FontStyle.italic)),
                    ),
                    Text(
                      nom,
                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w800,
                              fontStyle: FontStyle.italic)),
                    ),
                  ],
                )
              ],
            ));
      },
    );
  }
}

// Widget gridFeed(
//     {required String email,
//     required int telephone,
//     required String urlPhoto,
//     required String prenom,
//     required String nom}) {
//   return Expanded(
//     child: CustomScrollView(
//       slivers: <Widget>[
//         SliverAppBar(
//           expandedHeight: 250,
//           backgroundColor: Colors.white,
//           pinned: false,
//           floating: false,
//           flexibleSpace: FlexibleSpaceBar(
//             background: Container(
//               color: Theme.of(context).colorScheme.background,
//               padding: const EdgeInsets.all(22),
//               child: allHeader(
//                   email: email,
//                   telephone: telephone,
//                   urlPhoto: urlPhoto,
//                   prenom: prenom,
//                   nom: nom),
//             ),
//           ),
//         ),
//         SliverPadding(
//           padding: const EdgeInsets.all(8.0),
//           sliver: SliverGrid(
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 3,
//               mainAxisSpacing: 10.0,
//               crossAxisSpacing: 10.0,
//             ),
//             delegate: SliverChildBuilderDelegate(
//               (BuildContext context, int index) {
//                 return GestureDetector(
//                     onTap: () {
//                       Navigator.of(context).push(
//                           MaterialPageRoute(builder: (BuildContext context) {
//                         return PicturePage(
//                           pathToImageFromProfil: images[index],
//                           nomberOfLikes: 4,
//                           index: index,
//                           publishDate: 'Il y a 2h',
//                         );
//                       }));
//                     },
//                     child: Container(
//                       height: 50,
//                       width: 30,
//                       child: Image.network(images[index])),
//                     );
//               },
//               childCount: images.length,
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }

// Widget allHeader(
//     {required String email,
//     required int telephone,
//     required String urlPhoto,
//     required String prenom,
//     required String nom}) {
//   return Column(children: [
//     headerRow(
//         urlPhoto: agent.photoProfil, prenom: agent.prenom, nom: agent.nom),
//     infosRow(email: agent.email, telephone: agent.telephone)
//   ]);
// }
