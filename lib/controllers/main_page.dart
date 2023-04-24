import 'dart:io';
import 'package:flutter/material.dart';
import 'package:troisgimmoapp/controllers/agent_profil.dart';
import 'package:troisgimmoapp/controllers/annonces.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final scrollController = ScrollController();
  int _selectedIndex = 0;
  String imageUrl = "";

  static const List _pages = [
    Annonces(),
    Icon(
      Icons.camera,
      size: 150,
    ),
    AgentProfil(),
  ];

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
                  onPressed: () async {
                    /** PICK IMAGE FROM GALLERY */
                    ImagePicker imagePicker = ImagePicker();
                    XFile? file = await imagePicker.pickImage(
                        source: ImageSource.gallery);
                    if (file == null) return;

                    // Random name for database
                    String uniqueFileName =
                        DateTime.now().microsecondsSinceEpoch.toString();
                    /** UPLOAD TO FIREBASE */
                    // Get a rederence to storage
                    Reference referenceRoot =
                        FirebaseStorage.instance.ref('feed/01/');
                    Reference referenceDirImages =
                        referenceRoot.child('images');
                    // Create a reference for the image to be stored
                    Reference referenceImageToUpload =
                        referenceDirImages.child(uniqueFileName);

                    // Handle errors success
                    try {
                      //Store the file
                      await referenceImageToUpload.putFile(File(file.path));

                      //Success get the download url
                      imageUrl = await referenceImageToUpload.getDownloadURL();
                    } catch (e) {}
                  },
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
