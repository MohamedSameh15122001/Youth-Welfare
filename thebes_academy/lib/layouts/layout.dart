import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thebes_academy/cubit/appCubit.dart';
import 'package:thebes_academy/cubit/states.dart';
import 'package:thebes_academy/modules/categorys.dart';
import 'package:thebes_academy/modules/home.dart';
import 'package:thebes_academy/modules/profile.dart';
import 'package:thebes_academy/shared/applocale.dart';
import 'package:thebes_academy/shared/test.dart';

import '../modules/noConnection.dart';
import '../shared/constants.dart';

List<Widget> layoutPage = [
  Home(),
  const Categorys(),
  const Profile(),
];
int currentPage = 0;

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            centerTitle: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 22,
                ),
                Text(
                  getLang(context, "layoutTitle2"),
                  style: GoogleFonts.poppins(),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    width: 50,
                    'lib/assets/images/logo.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                Text(getLang(context, "layoutTitle1"),
                    style: GoogleFonts.poppins()),
              ],
            ),
          ),
          drawer: Drawer(
            backgroundColor: Colors.white,
            child: ListView(
              children: [
                DrawerHeader(
                    child: Image.asset(
                  'lib/assets/images/header.png',
                )),
                const SizedBox(
                  height: 30,
                ),
                ListTile(
                  onTap: () {},
                  leading: const Icon(
                    Icons.language,
                  ),
                  title: Row(
                    children: [
                      Text(
                        getLang(context, 'layoutDrawerLanguage'),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      // const SizedBox(width: 60),
                      DropdownButton(
                        items: ["English", "العربية"].map((valueItem) {
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
                        onChanged: (newValue) {
                          cubit.changelanguage(newValue);
                        },
                        value: cubit.currentValue,
                        underline: const SizedBox(),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 50,
                  child: TextButton(
                    // color: primaryColor,
                    child: Text(
                      getLang(context, 'layoutSignOut'),
                      style: const TextStyle(
                        color: primaryColor,
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () {
                      signOut(context);
                      Navigator.pop(context);
                      AppCubit.get(context).getProfileData();
                    },
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
            selectedItemColor: primaryColor,
            unselectedItemColor: Colors.grey[500],
            backgroundColor: Colors.white,
            elevation: 10,
            onTap: (index) => changeLayout(index),
            items: [
              BottomNavigationBarItem(
                icon: const Icon(
                  Icons.home,
                ),
                label: getLang(context, "layoutHome"),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.category),
                label: getLang(context, "layoutCategories"),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.person),
                label: getLang(context, "layoutProfile"),
              ),
            ],
          ),
          body: isNetworkConnection == true
              ? layoutPage[currentPage]
              : const NoConnection(),
        );
      },
    );
  }

  changeLayout(index) {
    setState(() {
      currentPage = index;
    });
  }
}
