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
