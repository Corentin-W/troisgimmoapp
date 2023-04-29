import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:rive/rive.dart';

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
        backgroundColor: Color.fromARGB(0, 32, 12, 12),
      ),
      body: SizedBox(
        height: screenHeight / 1.5,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: [
                  header(publishDate: publishDate),
                  post(
                      pathToImage: pathToImage,
                      screenHeight: screenHeight,
                      screenWidth: screenWidth),
                  likes(nbrLikes: nomberOfLikes),
                ]),
          ),
        ),
      ),
    );
  }

  Widget header({required String publishDate}) {
    return Row(
      children: [
        const Spacer(),
        Text(
          publishDate,
          style: GoogleFonts.poppins(textStyle: const TextStyle(fontSize: 25)),
        )
      ],
    );
  }

  Widget post(
      {required String pathToImage,
      required double screenHeight,
      required double screenWidth}) {
    return Container(
      decoration: BoxDecoration(
          color: Color.fromARGB(147, 233, 221, 221),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      height: screenHeight / 1.8,
      width: screenWidth / 1.1,
      child: Hero(
        tag: pathToImage,
        child: CachedNetworkImage(
            fit: BoxFit.contain, imageUrl: pathToImage.toString()),
      ),
    );
  }

  Widget likes({required int nbrLikes}) {
    return Row(
      children: [
        Icon(
          Icons.favorite,
          size: 30,
        ),
        Text(nbrLikes.toString(),
            style:
                GoogleFonts.poppins(textStyle: const TextStyle(fontSize: 25)))
      ],
    );
  }
}






// // ignore: must_be_immutable
// class PicturePage extends StatefulWidget {


  

//   @override
//   State<PicturePage> createState() => _PicturePageState();
// }

// class _PicturePageState extends State<PicturePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('data'),
//       ),
//       body: SafeArea(
//         child: Column(
//         children: [
//           displayPost(
//             pathToImage: widget.pathToImageFromProfil,
//             nomberOfLikes: widget.nomberOfLikes,
//             index: widget.index,
//             publishDate: widget.publishDate),
//             Spacer()
//         ],
//       )),
//     );
//   }

//   // Widget crossLeave(){
//   //   return Padding(padding: EdgeInsets.only(top: 55, right: 10),
//   //   child: Row(mainAxisAlignment: MainAxisAlignment.end,
//   //   children: [IconButton(
//   //     icon: Icon(Icons.cancel, size: 40),
//   //     onPressed: () {
//   //       Navigator.of(context).pop();
//   //       print('oui');
//   //     },)],),
//   //   );
//   // }


// }
