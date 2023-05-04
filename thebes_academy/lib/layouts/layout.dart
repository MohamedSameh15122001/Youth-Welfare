import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thebes_academy/cubit/appCubit.dart';
import 'package:thebes_academy/cubit/states.dart';
import 'package:thebes_academy/modules/Login.dart';
import 'package:thebes_academy/modules/categorys.dart';
import 'package:thebes_academy/modules/home.dart';
import 'package:thebes_academy/modules/profile.dart';
import 'package:thebes_academy/shared/applocale.dart';
import 'package:thebes_academy/shared/test.dart';

import '../modules/noConnection.dart';
import '../shared/component.dart';
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
  var sendKey = GlobalKey<FormState>();
  TextEditingController contactController = TextEditingController();
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is ContantSuccessState) {
          showToast(
              text: '${state.contantModel.message}', state: ToastStates.SUCCESS);
          Navigator.pop(context);
          contactController.clear();
        }

        if (state is ContantErrorState) {
          showToast(
              text: '${AppCubit.get(context).errorModel!.message}',
              state: ToastStates.ERROR);
          Navigator.pop(context);
        }

        if (state is RemoveTokenState) {
          showToast(
              text: getLang(context, 'succeessfully signed out'),
              state: ToastStates.SUCCESS);
        }
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            centerTitle: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if(lang =='ar')
                const SizedBox(
                  width: 34,
                ),
                if(lang =='en')
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
            // actions: [
            //   Icon(Icons.notifications),
            // ],
          ),
          drawer: Drawer(
            backgroundColor: Colors.white,
            child: Column(
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
                Spacer(),
                SizedBox(
                  height: 50,
                  child: TextButton(
                    // color: primaryColor,
                    child: Text(
                      getLang(context, 'Contact Us'),
                      style: const TextStyle(
                        color: primaryColor,
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () {
                      if (token == null) {
                        showToast(
                            text: getLang(context,
                                'activityYouMustLoginFirst'),
                            state: ToastStates.WARNING);
                        currentPage = 2;
                        navigateAndKill(
                            context, const Layout());
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(
                                getLang(context,
                                    'Send Us'),
                                style:
                                GoogleFonts.poppins(
                                    color:
                                    primaryColor,
                                    fontSize: 20,
                                    fontWeight:
                                    FontWeight
                                        .w400),
                              ),
                              content: Form(
                                key: sendKey,
                                child: Column(
                                  mainAxisSize:
                                  MainAxisSize.min,
                                  crossAxisAlignment:
                                  CrossAxisAlignment
                                      .center,
                                  children: [
                                    defaultFormField(
                                        context: context,
                                        controller: contactController,
                                        keyboardType: TextInputType.emailAddress,
                                        prefix: Icons.text_fields,
                                        validate: (value) {
                                          if (value!.isEmpty) {
                                            return getLang(
                                                context, 'You must complete the message')
                                            as String;
                                          }
                                        }),
                                    SizedBox(height: 10,),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        OutlinedButton(
                                            onPressed:
                                                () {
                                              Navigator.pop(
                                                  context);
                                              contactController.clear();
                                                },
                                            child: Text(
                                                getLang(
                                                    context,
                                                    'activityRateCancelButton'),
                                                style: GoogleFonts.poppins(
                                                    color: primaryColor,
                                                    fontWeight: FontWeight.w500))),
                                        OutlinedButton(
                                            onPressed: () {
                                              if(sendKey.currentState!.validate()){
                                                AppCubit.get(context).setContant(token: token,message: contactController.text);
                                              }
                                            },
                                            child: Text(
                                                getLang(
                                                    context,
                                                    'Send'),
                                                style: GoogleFonts.poppins(
                                                    color: primaryColor,
                                                    fontWeight: FontWeight.w500)))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ));
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                if(token != null)
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
                if(token == null)
                  SizedBox(
                    height: 50,
                    child: TextButton(
                      // color: primaryColor,
                      child: Text(
                        getLang(context, 'loginSendButton'),
                        style: const TextStyle(
                          color: primaryColor,
                          fontSize: 20,
                        ),
                      ),
                      onPressed: () {
                       navigateAndKill(context, const Login());
                      },
                    ),
                  ),
                const SizedBox(
                  height: 50,
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
