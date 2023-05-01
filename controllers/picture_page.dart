import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:photo_view/photo_view.dart';

class PicturePage {
  String pathToImageFromProfil;
  int nomberOfLikes;
  int index;
  String publishDate;

  PicturePage(
      {Key? key,
      required this.pathToImageFromProfil,
      required this.nomberOfLikes,
      required this.index,
      required this.publishDate});

  Widget displayPost(
      {required String pathToImage,
      required int nomberOfLikes,
      required int index,
      required String publishDate,
      required double screenHeight,
      required double screenWidth}) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        shadowColor: Colors.black,
        backgroundColor: const Color.fromARGB(0, 32, 12, 12),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenHeight,
          width: screenWidth,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Material(
                      elevation: 10,
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      child: post(
                          pathToImage: pathToImage,
                          screenHeight: screenHeight,
                          screenWidth: screenWidth),
                    ),
                    title(title: "Sortie entre amis !!!! Bonne soirée à tous"),
                    likesAndDate(
                        nbrLikes: nomberOfLikes, publishDate: publishDate),
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  Widget post(
      {required String pathToImage,
      required double screenHeight,
      required double screenWidth}) {
    return Container(
      decoration: const BoxDecoration(
          color: Color.fromARGB(147, 233, 221, 221),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      height: screenHeight / 1.7,
      width: screenWidth,
      child: Hero(
        tag: pathToImage,
        child: CachedNetworkImage(
            fit: BoxFit.contain, imageUrl: pathToImage.toString()),
      ),
    );
  }

  Widget likesAndDate({required int nbrLikes, required String publishDate}) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(nbrLikes.toString(),
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(fontSize: 25))),
          Container(width: 5),
          const FaIcon(FontAwesomeIcons.heart),
          const Spacer(),
          Text(publishDate,
              style:
                  GoogleFonts.poppins(textStyle: const TextStyle(fontSize: 15)))
        ],
      ),
    );
  }

  Widget title({required String title}) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        title,
        style: GoogleFonts.poppins(
            textStyle: const TextStyle(fontStyle: FontStyle.italic)),
      ),
    );
  }
}
