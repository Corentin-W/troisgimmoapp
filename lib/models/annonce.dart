import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_database/firebase_database.dart';

class Annonce {
  int prix;
  double surface;
  double honoraires;
  String type;
  String linkPhoto;
  String villeDiffusion;

  Annonce(
      {required this.prix,
      required this.surface,
      required this.honoraires,
      required this.type,
      required this.linkPhoto,
      required this.villeDiffusion});

  // static getAllAnnonces() {
  //   final db = FirebaseFirestore.instance;
  //   db.collection('Annonces').get().then(
  //     (querySnapshot) {
  //       print("Success");
  //       for (var docSnapshot in querySnapshot.docs) {
  //         print('${docSnapshot.id} => ${docSnapshot.data()}');
  //       }
  //     },
  //     onError: (e) => print('probleme mamen'),
  //   );
  // }

  
  Widget cardAnnonce(
      {required String image,
      required String type,
      required String villeDiffusion,
      required int prix,
      required double surface,
      required double honoraires}) {
    return Card(
      margin: const EdgeInsets.only(top: 30, left: 10, right: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 4,
      child: Column(children: [
        SizedBox(
          width: 400,
          height: 200,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.cover,
              ),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
          ),
        ),
        Container(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      type,
                      style: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 20)),
                    ),
                    Container(
                      width: 10,
                    ),
                    Text(
                      '$surface m2',
                      style: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 20)),
                    )
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Icon(Icons.place_outlined),
                        Text(
                          villeDiffusion,
                          style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                                  color: Color.fromARGB(255, 99, 90, 90))),
                        ),
                        const Spacer(),
                        Text(
                          '$prix €',
                          style: GoogleFonts.roboto(
                              textStyle: const TextStyle(fontSize: 16)),
                        ),
                      ],
                    ))
              ],
            )),
        // ButtonBar(
        //   children: [
        //     // TextButton(
        //     //   child: const Text('CONTACT AGENT'),
        //     //   onPressed: () {},
        //     // ),
        //     TextButton(
        //       child: const Text('OUVRIR LE DETAIL'),
        //       onPressed: () {},
        //     )
        //   ],
        // )
      ]),
    );
  }

  // Container cardAnnonce(
  //     {required double prix,
  //     required double surface,
  //     required double honoraires,
  //     required String type,
  //     required String linkPhoto,
  //     required String villeDiffusion}) {
  //   return Container(
  //     width: 40,
  //     color: Colors.black,
  //   );
  // }
}
