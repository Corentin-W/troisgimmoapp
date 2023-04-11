import 'package:flutter/material.dart';
import 'package:troisgimmoapp/controllers/picture_page.dart';
import 'package:troisgimmoapp/models/agent.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:troisgimmoapp/models/post.dart';

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

  List images = [
    'https://casoar.org/wp-content/uploads/2020/10/Bob-leponge.png',
    'https://casoar.org/wp-content/uploads/2020/10/Bob-leponge.png',
    'https://casoar.org/wp-content/uploads/2020/10/Bob-leponge.png',
    'https://casoar.org/wp-content/uploads/2020/10/Bob-leponge.png',
    'https://casoar.org/wp-content/uploads/2020/10/Bob-leponge.png',
    'https://casoar.org/wp-content/uploads/2020/10/Bob-leponge.png',
    'https://casoar.org/wp-content/uploads/2020/10/Bob-leponge.png',
    'https://casoar.org/wp-content/uploads/2020/10/Bob-leponge.png',
    'https://casoar.org/wp-content/uploads/2020/10/Bob-leponge.png',
    'https://casoar.org/wp-content/uploads/2020/10/Bob-leponge.png',
    'https://casoar.org/wp-content/uploads/2020/10/Bob-leponge.png',
    'https://casoar.org/wp-content/uploads/2020/10/Bob-leponge.png',
    'https://casoar.org/wp-content/uploads/2020/10/Bob-leponge.png',
    'https://casoar.org/wp-content/uploads/2020/10/Bob-leponge.png',
    'https://casoar.org/wp-content/uploads/2020/10/Bob-leponge.png',
    'https://casoar.org/wp-content/uploads/2020/10/Bob-leponge.png',
    'https://casoar.org/wp-content/uploads/2020/10/Bob-leponge.png',
    'https://casoar.org/wp-content/uploads/2020/10/Bob-leponge.png',
    'https://casoar.org/wp-content/uploads/2020/10/Bob-leponge.png',
    'https://casoar.org/wp-content/uploads/2020/10/Bob-leponge.png',
    'https://casoar.org/wp-content/uploads/2020/10/Bob-leponge.png',
    'https://casoar.org/wp-content/uploads/2020/10/Bob-leponge.png',
    'https://casoar.org/wp-content/uploads/2020/10/Bob-leponge.png',
    'https://casoar.org/wp-content/uploads/2020/10/Bob-leponge.png',
    'https://casoar.org/wp-content/uploads/2020/10/Bob-leponge.png',
    'https://casoar.org/wp-content/uploads/2020/10/Bob-leponge.png',
    'https://casoar.org/wp-content/uploads/2020/10/Bob-leponge.png',
    'https://casoar.org/wp-content/uploads/2020/10/Bob-leponge.png',
    'https://casoar.org/wp-content/uploads/2020/10/Bob-leponge.png',
    'https://casoar.org/wp-content/uploads/2020/10/Bob-leponge.png',
    'https://casoar.org/wp-content/uploads/2020/10/Bob-leponge.png',
    'https://casoar.org/wp-content/uploads/2020/10/Bob-leponge.png',
    'https://casoar.org/wp-content/uploads/2020/10/Bob-leponge.png',
    'https://casoar.org/wp-content/uploads/2020/10/Bob-leponge.png',
    'https://casoar.org/wp-content/uploads/2020/10/Bob-leponge.png',
    'https://casoar.org/wp-content/uploads/2020/10/Bob-leponge.png',
    'https://casoar.org/wp-content/uploads/2020/10/Bob-leponge.png',
    'https://casoar.org/wp-content/uploads/2020/10/Bob-leponge.png',
    'https://casoar.org/wp-content/uploads/2020/10/Bob-leponge.png',
    'https://casoar.org/wp-content/uploads/2020/10/Bob-leponge.png',
    'https://casoar.org/wp-content/uploads/2020/10/Bob-leponge.png',
    'https://casoar.org/wp-content/uploads/2020/10/Bob-leponge.png',
    'https://casoar.org/wp-content/uploads/2020/10/Bob-leponge.png',
    'https://casoar.org/wp-content/uploads/2020/10/Bob-leponge.png',
    'https://casoar.org/wp-content/uploads/2020/10/Bob-leponge.png',
    'https://casoar.org/wp-content/uploads/2020/10/Bob-leponge.png',
    'https://casoar.org/wp-content/uploads/2020/10/Bob-leponge.png',
    'https://casoar.org/wp-content/uploads/2020/10/Bob-leponge.png',
    'https://casoar.org/wp-content/uploads/2020/10/Bob-leponge.png',
    'https://casoar.org/wp-content/uploads/2020/10/Bob-leponge.png',
    'https://casoar.org/wp-content/uploads/2020/10/Bob-leponge.png',
    'https://casoar.org/wp-content/uploads/2020/10/Bob-leponge.png',
    'https://casoar.org/wp-content/uploads/2020/10/Bob-leponge.png'
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(7),
        child: gridFeed(
            email: agent.email,
            telephone: agent.telephone,
            urlPhoto: agent.photoProfil,
            prenom: agent.prenom,
            nom: agent.nom));
  }

  Widget allHeader(
      {required String email,
      required int telephone,
      required String urlPhoto,
      required String prenom,
      required String nom}) {
    return Column(
      children: [
        headerRow(
            urlPhoto: agent.photoProfil, prenom: agent.prenom, nom: agent.nom),
        infosRow(email: agent.email, telephone: agent.telephone)
      ],
    );
  }

  Widget gridFeed(
      {required String email,
      required int telephone,
      required String urlPhoto,
      required String prenom,
      required String nom}) {
    return Expanded(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 250,
            backgroundColor: Colors.white,
            pinned: false,
            floating: false,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                padding: const EdgeInsets.all(22),
                child: allHeader(
                    email: email,
                    telephone: telephone,
                    urlPhoto: urlPhoto,
                    prenom: prenom,
                    nom: nom),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                          return PicturePage(
                            pathToImageFromProfil: images[index],
                            nomberOfLikes: 4,
                            index: index,
                          );
                        }));
                      },
                      child: Container(
                        height: 50,
                        width: 30,
                        child: Hero(
                            tag: index, child: Image.network(images[index])),
                      ));
                },
                childCount: images.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column infosRow({required String email, required int telephone}) {
    return Column(
      children: [
        Container(
          height: 20,
        ),
        Row(children: [
          const Icon(Icons.phone),
          Text(telephone.toString(),
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(color: Colors.grey)))
        ]),
        Container(
          height: 10,
        ),
        Row(
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

  Row headerRow(
      {required String urlPhoto, required String prenom, required String nom}) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(urlPhoto),
          radius: 70,
        ),
        const Spacer(),
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
            Image.network(
              'https://maisondesmandataires.com/wp-content/uploads/2022/05/3G-LOGO-HORI.png',
              height: 50,
              width: 150,
            )
          ],
        )
      ],
    );
  }
}
