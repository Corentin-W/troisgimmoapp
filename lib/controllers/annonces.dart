import 'package:flutter/material.dart';
import '../models/annonce.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Annonces extends StatefulWidget {
  const Annonces({super.key});

  @override
  State<Annonces> createState() => _AnnoncesState();
}

class _AnnoncesState extends State<Annonces> {
  // List<Annonce> allAnnonces = [
  //   Annonce(
  //       prix: 100000,
  //       surface: 28,
  //       honoraires: 1500,
  //       type: 'Appartement',
  //       linkPhoto:
  //           'https://v.seloger.com/s/cdn/x/visuels/0/t/2/7/0t27el8ypp2bcq0lgtajk235gx0w8etr012que8ao.jpg',
  //       villeDiffusion: 'Annecy'),
  //   Annonce(
  //       prix: 300000,
  //       surface: 88,
  //       honoraires: 1500,
  //       type: 'Maison',
  //       linkPhoto:
  //           'https://v.seloger.com/s/cdn/x/visuels/0/t/2/7/0t27el8ypp2bcq0lgtajk235gx0w8etr012que8ao.jpg',
  //       villeDiffusion: 'Toulouse'),
  //   Annonce(
  //       prix: 1505000,
  //       surface: 228,
  //       honoraires: 11500,
  //       type: 'Villa',
  //       linkPhoto:
  //           'https://v.seloger.com/s/cdn/x/visuels/0/t/2/7/0t27el8ypp2bcq0lgtajk235gx0w8etr012que8ao.jpg',
  //       villeDiffusion: 'Saint-Jorioz'),
  //   Annonce(
  //       prix: 9860000,
  //       surface: 128,
  //       honoraires: 8500,
  //       type: 'Maison / Villa',
  //       linkPhoto:
  //           'https://v.seloger.com/s/cdn/x/visuels/0/t/2/7/0t27el8ypp2bcq0lgtajk235gx0w8etr012que8ao.jpg',
  //       villeDiffusion: 'Bordeaux'),
  //   Annonce(
  //       prix: 830750,
  //       surface: 78,
  //       honoraires: 10500,
  //       type: 'Maison',
  //       linkPhoto:
  //           'https://v.seloger.com/s/cdn/x/visuels/0/t/2/7/0t27el8ypp2bcq0lgtajk235gx0w8etr012que8ao.jpg',
  //       villeDiffusion: 'Rennes'),
  //   Annonce(
  //       prix: 100000,
  //       surface: 28,
  //       honoraires: 1500,
  //       type: 'Appartement',
  //       linkPhoto:
  //           'https://v.seloger.com/s/cdn/x/visuels/0/t/2/7/0t27el8ypp2bcq0lgtajk235gx0w8etr012que8ao.jpg',
  //       villeDiffusion: 'Annecy'),
  //   Annonce(
  //       prix: 300000,
  //       surface: 88,
  //       honoraires: 1500,
  //       type: 'Maison',
  //       linkPhoto:
  //           'https://v.seloger.com/s/cdn/x/visuels/0/t/2/7/0t27el8ypp2bcq0lgtajk235gx0w8etr012que8ao.jpg',
  //       villeDiffusion: 'Toulouse'),
  //   Annonce(
  //       prix: 1505000,
  //       surface: 228,
  //       honoraires: 11500,
  //       type: 'Villa',
  //       linkPhoto:
  //           'https://v.seloger.com/s/cdn/x/visuels/0/t/2/7/0t27el8ypp2bcq0lgtajk235gx0w8etr012que8ao.jpg',
  //       villeDiffusion: 'Saint-Jorioz'),
  //   Annonce(
  //       prix: 9860000,
  //       surface: 128,
  //       honoraires: 8500,
  //       type: 'Maison / Villa',
  //       linkPhoto:
  //           'https://v.seloger.com/s/cdn/x/visuels/0/t/2/7/0t27el8ypp2bcq0lgtajk235gx0w8etr012que8ao.jpg',
  //       villeDiffusion: 'Bordeaux'),
  //   Annonce(
  //       prix: 830750,
  //       surface: 78,
  //       honoraires: 10500,
  //       type: 'Maison',
  //       linkPhoto:
  //           'https://v.seloger.com/s/cdn/x/visuels/0/t/2/7/0t27el8ypp2bcq0lgtajk235gx0w8etr012que8ao.jpg',
  //       villeDiffusion: 'Rennes'),
  // ];

  @override
  Widget build(BuildContext context) {
    return listeLesAnnonces();
  }

  Future listeLesAnnonces() async {
    Future<List<dynamic>?> allAnnonces = await getAllAnnonces();
    print(allAnnonces);

    return Text('hellomoto');
  }

  getAllAnnonces() async {
    final db = FirebaseFirestore.instance;
    List<dynamic>? listeDesAnnonces = [];
    db.collection('Annonces').get().then(
      (querySnapshot) {
        print("Success");
        for (var docSnapshot in querySnapshot.docs) {
          Annonce annonce = Annonce(
              prix: docSnapshot.get('prix'),
              surface: double.parse(docSnapshot.get('surface').toString()),
              honoraires:
                  double.parse(docSnapshot.get('honoraires').toString()),
              type: docSnapshot.get('type').toString(),
              linkPhoto: docSnapshot.get('linkPhoto').toString(),
              villeDiffusion: docSnapshot.get('villeDiffusion').toString());
          listeDesAnnonces.add(annonce);
        }
        return listeDesAnnonces;
      },
      onError: (e) => print('probleme mamen'),
    );
  }
}
