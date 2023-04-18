import 'package:flutter/material.dart';
import 'package:troisgimmoapp/controllers/agent_profil.dart';
import 'package:troisgimmoapp/controllers/annonces.dart';


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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(0, 32, 12, 12),
        title: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network('https://maisondesmandataires.com/wp-content/uploads/2022/05/3G-LOGO-HORI.png', width: 200, height: 100),
              Icon( Icons.notifications_none, color: Colors.black,size: 35,),
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
