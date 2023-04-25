import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:troisgimmoapp/models/agent.dart';
import 'package:google_fonts/google_fonts.dart';

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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              headerRow(
                  urlPhoto: agent.photoProfil,
                  prenom: agent.prenom,
                  nom: agent.nom),
              SizedBox(
                height: 600,
                child: FutureBuilder<List>(
                  future: getPicturesFromStorage(),
                  builder:
                      (BuildContext context, AsyncSnapshot<List> snapshot) {
                    print(snapshot);
                    if (snapshot.hasData) {
                      return ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: snapshot.data!
                            .map((url) => Image.network(url.toString()))
                            .toList(),
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
              ),
            ]),
      ),
    );
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
    print(urlList);

    return urlList;
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
        color: Colors.white,
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
