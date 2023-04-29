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
  Agent agent = Agent(
      prenom: 'Patrick',
      nom: 'Patulacci',
      email: 'ppatulacci@3gimmobilier.com',
      telephone: 0612345678,
      secteur: 'Corse',
      photoProfil: 'https://pbs.twimg.com/media/FjU2lkcWYAgNG6d.jpg');
  // Controller _controllerFeed;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return LoaderOverlay(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(height: 20),
                headerRow(
                    urlPhoto: agent.photoProfil,
                    prenom: agent.prenom,
                    nom: agent.nom),
                Container(height: 20),
                infosRow(email: agent.email, telephone: agent.telephone),
                likesAndSavesBar(),
                Container(height: 5),
                SizedBox(
                  height: 1000,
                  child: FutureBuilder<List>(
                      future: getPicturesFromStorage(),
                      builder:
                          (BuildContext context, AsyncSnapshot<List> snapshot) {
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
                                          borderRadius:
                                              BorderRadius.circular(5),
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
                      }),
                ),
              ]),
        ),
      ),
    );
  }

  onTapOnePhoto(url, screenWidth, screenHeight) {
    print("salut coco");
    print(url);
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
      padding: EdgeInsets.all(1),
      child: Column(
        children: [
          const Divider(
            thickness: 0.5,
            color: Colors.grey,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(Icons.favorite_border, size: 30),
              Icon(Icons.file_download_done, size: 30),
            ],
          ),
          const Divider(thickness: 0.5, color: Colors.grey)
        ],
      ),
    );
  }

  Column infosRow({required String email, required int telephone}) {
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(Icons.phone),
          Text(telephone.toString(),
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(color: Colors.grey)))
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

  Container headerRow(
      {required String urlPhoto, required String prenom, required String nom}) {
    return Container(
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
