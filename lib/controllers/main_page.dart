import 'dart:io';
import 'dart:async';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter/material.dart';
import 'package:troisgimmoapp/controllers/agent_profil.dart';
import 'package:troisgimmoapp/controllers/annonces.dart';
import 'package:image_picker/image_picker.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final scrollController = ScrollController();
  int _selectedIndex = 0;
  static const List _pages = [
    Annonces(),
    Icon(
      Icons.camera,
      size: 150,
    ),
    AgentProfil(),
  ];
  late File _imageFile;
  late File _croppedFile;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _cropImage() async {
    final ImageCropper imageCropper = ImageCropper();
    final croppedFile = await imageCropper.cropImage(
      sourcePath: _imageFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
    );

    setState(() {
      if (croppedFile != null) {
        _croppedFile = croppedFile as File;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(0, 32, 12, 12),
        title: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(
                  'https://maisondesmandataires.com/wp-content/uploads/2022/05/3G-LOGO-HORI.png',
                  width: 200,
                  height: 100),
              IconButton(
                  onPressed: () => _pickImage(ImageSource.gallery),
                  icon: Icon(
                    Icons.add_a_photo_outlined,
                    color: Colors.black,
                    size: 35,
                  )),
            ],
          ),
        ),
        elevation: 0,
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 7,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Annonces',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            label: 'Feed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_alt_outlined),
            label: 'Profil',
          ),
        ],
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: _pages.elementAt(_selectedIndex),
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
