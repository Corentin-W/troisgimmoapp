import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PicturePage extends StatefulWidget {
  String pathToImageFromProfil;
  int nomberOfLikes;
  int index;
  PicturePage(
      {Key? key,
      required this.pathToImageFromProfil,
      required this.nomberOfLikes,
      required this.index})
      : super(key: key);

  @override
  State<PicturePage> createState() => _PicturePageState();
}

class _PicturePageState extends State<PicturePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: displayPost(
            pathToImage: widget.pathToImageFromProfil,
            nomberOfLikes: widget.nomberOfLikes,
            index: widget.index),
      ),
    );
  }

  Widget displayPost(
      {required String pathToImage,
      required int nomberOfLikes,
      required int index}) {
    return Hero(
        tag: index,
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(30),
            child: Column(children: [
              const Spacer(),
              header(),
              post(pathToImage: pathToImage),
              likes(nbrLikes: nomberOfLikes),
              const Spacer()
            ]),
          ),
        ));
  }

  Widget post({required String pathToImage}) {
    return Image.network(pathToImage);
  }

  Widget likes({required int nbrLikes}) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 5),
          child: Icon(Icons.heart_broken),
        ),
        Text(nbrLikes.toString())
      ],
    );
  }

  Widget header() {
    return Row(
      children: [Text('data')],
    );
  }

  // Widget displayPost(
  //     {required String pathToImage,
  //     required int nomberOfLikes,
  //     required int index}) {
  //   return Center(child: Hero(tag: index, child: Image.network(pathToImage)));
  // }
}
