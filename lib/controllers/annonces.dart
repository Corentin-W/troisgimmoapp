import 'package:flutter/material.dart';
import '../models/annonce.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Annonces extends StatefulWidget {
  const Annonces({super.key});

  @override
  State<Annonces> createState() => _AnnoncesState();
}

class _AnnoncesState extends State<Annonces> {
  final Stream<QuerySnapshot> db =
      FirebaseFirestore.instance.collection('Annonces').snapshots();
  List<Annonce>? listeDesAnnonces = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: db,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            final doc = snapshot.data!.docs[index];
            return Annonce(
                    prix: doc['prix'],
                    surface: double.parse(doc['surface'].toString()),
                    honoraires: double.parse(doc['honoraires'].toString()),
                    type: doc['type'],
                    linkPhoto: doc['linkPhoto'],
                    villeDiffusion: doc['villeDiffusion'])
                .cardAnnonce(
                    image: doc['linkPhoto'],
                    type: doc['type'],
                    villeDiffusion: doc['type'],
                    prix: doc['prix'],
                    surface: double.parse(doc['surface'].toString()),
                    honoraires: double.parse(doc['honoraires'].toString()));
          },
        );
      },
    );
  }

  // ListView(
  //         children: snapshot.data!.docs.map((DocumentSnapshot document) {
  //           Map<String, dynamic> data = document.data() as Map<String, dynamic>;
  //           return ListTile(
  //             title: Text(data['villeDiffusion']),
  //             subtitle: Text(data['surface'].toString()),
  //           );
  //         }).toList(),

  // getAllAnnonces() async {
  //   final db = FirebaseFirestore.instance;
  //   List<dynamic>? listeDesAnnonces = [];
  //   db.collection('Annonces').get().then(
  //     (querySnapshot) {
  //       for (var docSnapshot in querySnapshot.docs) {
  //         Annonce annonce = Annonce(
  //             prix: docSnapshot.get('prix'),
  //             surface: double.parse(docSnapshot.get('surface').toString()),
  //             honoraires:
  //                 double.parse(docSnapshot.get('honoraires').toString()),
  //             type: docSnapshot.get('type').toString(),
  //             linkPhoto: docSnapshot.get('linkPhoto').toString(),
  //             villeDiffusion: docSnapshot.get('villeDiffusion').toString());
  //         listeDesAnnonces.add(annonce);
  //       }
  //       return listeDesAnnonces;
  //     },
  //     onError: (e) => print('probleme mamen'),
  //   );
  // }
}
