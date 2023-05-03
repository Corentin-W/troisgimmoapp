import 'package:flutter/material.dart';

class ImageEdit extends StatefulWidget {
  String imageURL = "";

  ImageEdit({required this.imageURL, super.key});

  @override
  State<ImageEdit> createState() => _ImageEditState();
}

class _ImageEditState extends State<ImageEdit> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("oui"),
              displayImage(url: widget.imageURL),
              Text("boutonvalider")
            ],
          ),
        ),
      ),
    );
  }

  Widget displayImage({required String url}) {
    return Column(
      children: [
        Image.network(url),
        Container(height: 10),
        TextFormField(
          autocorrect: true,
          decoration: InputDecoration(
            labelText: 'Description',
            border: OutlineInputBorder(),
            suffixIcon: Icon(
              Icons.error,
            ),
          ),
        )
      ],
    );
  }
}
