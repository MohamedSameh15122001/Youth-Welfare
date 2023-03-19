import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thebes_academy/modules/categorys.dart';
import 'package:thebes_academy/modules/home.dart';
import 'package:thebes_academy/modules/profile.dart';

import '../shared/constants.dart';

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
        backgroundColor:defaultColor,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 22,),
             Text('Thebes ',style: GoogleFonts.poppins(),),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                width: 50,
                'lib/assets/images/logo.jpg',
                fit: BoxFit.cover,
              ),
            ),
             Text(' Academy',style: GoogleFonts.poppins()),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(child: Image.asset('lib/assets/images/header.png')),
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
        iconSize: 25,
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
        selectedItemColor:defaultColor ,
        unselectedItemColor: Colors.grey[500],
        backgroundColor: Colors.white,
        elevation: 10,
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
