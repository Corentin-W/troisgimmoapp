import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    header(publishDate: publishDate),
                    Container(height: 5),
                    Material(
                      elevation: 15,
                      child: post(
                          pathToImage: pathToImage,
                          screenHeight: screenHeight,
                          screenWidth: screenWidth),
                    ),
                    Container(height: 20),
                    likes(nbrLikes: nomberOfLikes),
                  ]),
            ),
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
          style: GoogleFonts.poppins(textStyle: const TextStyle(fontSize: 20)),
        )
      ],
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
      height: screenHeight / 2,
      width: screenWidth,
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
        const Icon(
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
