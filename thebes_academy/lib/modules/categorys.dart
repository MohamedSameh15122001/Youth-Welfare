import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thebes_academy/modules/trips.dart';
import 'package:thebes_academy/shared/applocale.dart';

import '../cubit/appCubit.dart';
import '../cubit/states.dart';
import '../shared/constants.dart';
import 'categoryDetail.dart';

class Categorys extends StatelessWidget {
  const Categorys({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Conditional.single(
          context: context,
          conditionBuilder: (context) => cubit.categoriesModel != null ,
          widgetBuilder: (context) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 0.0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 20,),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                          borderRadius:
                          const BorderRadius.all(Radius.circular(40)),
                          child: Container(
                            width: 303,
                            height: 144,
                            color: Colors.grey,
                          )
                      ),
                      ClipRRect(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(40)),
                        child: InkWell(
                          onTap: (){
                            navigateTo(context, const Trips());
                          },
                          child: Container(
                            width: 300,
                            padding:
                            const EdgeInsets.symmetric(horizontal: 0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade300,
                                  blurRadius: 10.0,
                                  offset: const Offset(0.0, 5.0),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Image.asset(
                                  'lib/assets/images/trip.jpg',
                                  width: 400,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                                const Divider(
                                    color: Colors.grey, thickness: .3),
                                Text(
                                  getLang(context, 'tripsText'),
                                  style: GoogleFonts.poppins(),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  AnimationLimiter(
                    child: GridView.count(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      childAspectRatio: .6,
                      crossAxisSpacing: 30,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      crossAxisCount: 2,
                      children: List.generate(
                        cubit.categoriesModel!.result!.length,
                        (int index) {
                          return AnimationConfiguration.staggeredGrid(
                            position: index,
                            duration: const Duration(milliseconds: 500),
                            columnCount: 2,
                            child: ScaleAnimation(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.fastLinearToSlowEaseIn,
                              child: FadeInAnimation(
                                child: ClipRRect(
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(40)),
                                  child: GestureDetector(
                                    onTap: () {
                                      cubit.getCategoriesDetailData(
                                          cubit.categoriesModel!.result![index].sId);
                                      cubit.getActivityData(
                                          cubit.categoriesModel!.result![index].sId);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Category(),
                                        ),
                                      );
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.symmetric(vertical: 10),
                                      child: Container(
                                        padding:
                                            const EdgeInsets.symmetric(horizontal: 0),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.shade300,
                                              blurRadius: 10.0,
                                              offset: const Offset(0.0, 5.0),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          children: [
                                            CachedNetworkImage(
                                              imageUrl:
                                                  '${cubit.categoriesModel!.result![index].coverImage}',
                                              width: 160,
                                              height: 200,
                                              fit: BoxFit.contain,
                                            ),
                                            const Divider(
                                                color: Colors.grey, thickness: .3),
                                            Text(
                                              '${cubit.categoriesModel!.result![index].titleAr}',
                                              style: GoogleFonts.poppins(),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          fallbackBuilder: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}



