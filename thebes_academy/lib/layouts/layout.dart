import 'package:flutter/material.dart';
import 'package:thebes_academy/modules/categorys.dart';
import 'package:thebes_academy/modules/home.dart';
import 'package:thebes_academy/modules/profile.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  List<Widget> layoutPage = [
    Home(),
    Categorys(),
    const Profile(),
  ];
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.search),
          )
        ],
        backgroundColor: Colors.blue[800],
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Thebes '),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                width: 50,
                'lib/assets/images/logo.jpg',
                fit: BoxFit.cover,
              ),
            ),
            const Text(' Academy'),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(child: Image.asset('lib/assets/images/header.png')),
            ListTile(
              leading: const Icon(
                Icons.dark_mode,
              ),
              title: const Text(
                'Dark Mode',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Switch(
                activeColor: Colors.blue[800],
                onChanged: (value) {},
                value: false,
              ),
            ),
            ListTile(
              onTap: () {},
              leading: const Icon(
                Icons.language,
              ),
              title: Row(
                children: [
                  const Text(
                    'language',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 60),
                  DropdownButton(
                    items: ["English", "Arabic"].map((valueItem) {
                      return DropdownMenuItem(
                        value: valueItem,
                        child: Text(
                          valueItem,
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (newValue) {},
                    value: 'English',
                    underline: const SizedBox(),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        iconSize: 30,
        selectedIconTheme: const IconThemeData(
          size: 30,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black54,
        backgroundColor: Colors.blue[800],
        elevation: 0,
        onTap: (index) => changeLayout(index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categorys',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      body: layoutPage[currentPage],
    );
  }

  changeLayout(index) {
    setState(() {
      currentPage = index;
    });
  }
}
