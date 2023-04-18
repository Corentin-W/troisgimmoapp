import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class PicturePage extends StatefulWidget {
  String pathToImageFromProfil;
  int nomberOfLikes;
  int index;
  String publishDate;

  PicturePage(
      {Key? key,
      required this.pathToImageFromProfil,
      required this.nomberOfLikes,
      required this.index,
      required this.publishDate})
      : super(key: key);

  @override
  State<PicturePage> createState() => _PicturePageState();
}

class _PicturePageState extends State<PicturePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('data'),
      ),
      body: SafeArea(
        child: Column(
        children: [
          displayPost(
            pathToImage: widget.pathToImageFromProfil,
            nomberOfLikes: widget.nomberOfLikes,
            index: widget.index,
            publishDate: widget.publishDate),
            Spacer()
        ],
      )),
    );
  }

  // Widget crossLeave(){
  //   return Padding(padding: EdgeInsets.only(top: 55, right: 10),
  //   child: Row(mainAxisAlignment: MainAxisAlignment.end,
  //   children: [IconButton(
  //     icon: Icon(Icons.cancel, size: 40),
  //     onPressed: () {
  //       Navigator.of(context).pop();
  //       print('oui');
  //     },)],),
  //   );
  // }

  Widget displayPost(
      {required String pathToImage,
      required int nomberOfLikes,
      required int index, required String publishDate}) {
    return Center(
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Column(
            mainAxisAlignment:  MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            header(publishDate:  publishDate),
            post(pathToImage: pathToImage),
            likes(nbrLikes: nomberOfLikes),
          ]),
        ),
    );
  }

  Widget post({required String pathToImage}) {
    return Image.network(pathToImage);
  }

  Widget likes({required int nbrLikes}) {
    return Row(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 5),
          child: Icon(Icons.favorite, size: 30,),
        ),
        Text(nbrLikes.toString(), style: GoogleFonts.poppins(textStyle: const TextStyle(fontSize: 25)))
      ],
    );
  }

  Widget header({required String publishDate}) {
    return Row(
      children: [
         const Spacer(),
        Text(publishDate, style: GoogleFonts.poppins(textStyle: const TextStyle(fontSize: 25)),)],
    );
  }

  // Widget displayPost(
  //     {required String pathToImage,
  //     required int nomberOfLikes,
  //     required int index}) {
  //   return Center(child: Hero(tag: index, child: Image.network(pathToImage)));
  // }
}
