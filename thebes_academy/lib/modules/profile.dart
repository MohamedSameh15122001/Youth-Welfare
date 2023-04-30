import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_slimy_card/flutter_slimy_card.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thebes_academy/modules/Login.dart';
import 'package:thebes_academy/modules/editProfile.dart';
import 'package:thebes_academy/remoteNetwork/cacheHelper.dart';
import 'package:thebes_academy/shared/applocale.dart';

import '../cubit/appCubit.dart';
import '../cubit/states.dart';
import '../shared/constants.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return Conditional.single(
            conditionBuilder: (context) => token != null,
            fallbackBuilder: (context) => Column(
              children: [
                const SizedBox(height: 50),
                FlutterSlimyCard(
                  cardWidth: 280,
                  topCardHeight: 300,
                  bottomCardHeight: 80,
                  color: primaryColor,
                  topCardWidget: topCardWidget(context),
                  bottomCardWidget: bottomCardWidget(context),
                ),
              ],
            ),
            context: context,
            widgetBuilder: (context) => Conditional.single(
              context: context,
              conditionBuilder: (context) => cubit.profileModel != null,
              widgetBuilder: (context) => SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: AnimationLimiter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: AnimationConfiguration.toStaggeredList(
                        duration: const Duration(milliseconds: 300),
                        childAnimationBuilder: (widget) => SlideAnimation(
                          horizontalOffset: 50.0,
                          child: FadeInAnimation(
                            child: widget,
                          ),
                        ),
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                height: 50,
                                child: TextButton(
                                  // color: primaryColor,
                                  child: Text(getLang(context, 'profileEdit'),
                                      style: GoogleFonts.poppins(
                                          color: primaryColor,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500)),
                                  onPressed: () {
                                    navigateTo(context, EditProfile());
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (cubit.profileModel!.student!.image!.contains("http"))
                                CircleAvatar(
                                    radius: 60,
                                    backgroundImage: NetworkImage(
                                        '${cubit.profileModel!.student!.image}')),
                              if (!cubit.profileModel!.student!.image!.contains("http"))
                                CircleAvatar(
                                    radius: 60,
                                    backgroundImage: FileImage(File(
                                        '${cubit.profileModel!.student!.image}'))),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(getLang(context, 'profileName'),
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                              Text('${cubit.profileModel!.student!.fullName}',
                                  style: GoogleFonts.poppins(fontSize: 20)),
                            ],
                          ),
                          const Divider(
                            thickness: 1.5,
                          ),
                          const SizedBox(height: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(getLang(context, 'profileCode'),
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                              Text('${cubit.profileModel!.student!.code}',
                                  style: GoogleFonts.poppins(fontSize: 20)),
                            ],
                          ),
                          const Divider(
                            thickness: 1.5,
                          ),
                          const SizedBox(height: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(getLang(context, 'profileSpecialization'),
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                              Text(
                                  '${cubit.profileModel!.student!.specializationEn}',
                                  style: GoogleFonts.poppins(fontSize: 20)),
                            ],
                          ),
                          const Divider(
                            thickness: 1.5,
                          ),
                          const SizedBox(height: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(getLang(context, 'profileActivites'),
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                              if (cubit
                                  .profileModel!.student!.activity!.isEmpty)
                                Text(
                                    getLang(context,
                                        'profileYouAreNotParticipating'),
                                    style: GoogleFonts.poppins(fontSize: 18)),
                              if (cubit
                                  .profileModel!.student!.activity!.isNotEmpty)
                                SizedBox(
                                  height: 120,
                                  width: MediaQuery.of(context).size.width,
                                  child: ListView(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    children: List.generate(
                                        cubit.profileModel!.student!.activity!
                                            .length,
                                        (index) => Text(
                                            CacheHelper.getData('lang') == 'en'
                                                ? '${cubit.profileModel!.student!.activity![index].titleEn}'
                                                : '${cubit.profileModel!.student!.activity![index].titleAr}',
                                            style: GoogleFonts.poppins(
                                                fontSize: 20))),
                                  ),
                                ),
                              const Divider(
                                thickness: 1.5,
                              ),
                            ],
                          ),
                          // const Spacer(),
                          // Center(
                          //   child: Container(
                          //     height: 40,
                          //     child: TextButton(
                          //       // color: primaryColor,
                          //       child: const Text(
                          //         'EDIT',
                          //         style: TextStyle(
                          //           color: primaryColor,
                          //           fontSize: 20,
                          //         ),
                          //       ),
                          //       onPressed: (){
                          //
                          //       },
                          //
                          //     ),
                          //   ),
                          // ),

                          // Align(
                          //   alignment: Alignment.center,
                          //   child: ClipRRect(
                          //     borderRadius: BorderRadius.circular(20),
                          //     child: MaterialButton(
                          //       minWidth: MediaQuery.of(context).size.width,
                          //       height: 50,
                          //       onPressed: () {},
                          //       color: primaryColor,
                          //       child: const Text(
                          //         'SIGN OUT',
                          //         style: TextStyle(
                          //           color: Colors.white,
                          //           fontSize: 20,
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              fallbackBuilder: (context) => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        });
  }
}

// This widget will be passed as Top Card's Widget.
Widget topCardWidget(context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      getLang(context, 'profileYouMustLogin'),
      style: GoogleFonts.poppins(
        fontSize: 28,
        color: Colors.white,
      ),
    ),
  );
}

// This widget will be passed as Bottom Card's Widget.
Widget bottomCardWidget(context) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(20),
    child: InkWell(
      onTap: () {
        navigateTo(context, const Login());
      },
      child: Container(
        height: 100,
        width: 300,
        color: primaryColor,
        child: Center(
          child: Text(
            getLang(context, 'profileLoginNow'),
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 28,
            ),
          ),
        ),
      ),
    ),
  );
}
