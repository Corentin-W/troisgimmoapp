import 'package:flutter/material.dart';

class Agent {
  String? prenom;
  String? nom;
  String? email;
  String? photoProfil;

  Widget getRoundProfilPicture({required String photoProfil}) {
    return CircleAvatar(backgroundImage: NetworkImage(photoProfil));
  }


}
