import 'package:flutter/material.dart';

class Agent {
  String prenom;
  String nom;
  String email;
  int telephone;
  String secteur;
  String photoProfil;

  Agent(
      {required this.prenom,
      required this.nom,
      required this.email,
      required this.telephone,
      required this.secteur,
      required this.photoProfil});

  Widget getRoundProfilPicture({required String photoProfil}) {
    return CircleAvatar(backgroundImage: NetworkImage(photoProfil));
  }
}
