import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thebes_academy/modules/Login.dart';
import 'package:thebes_academy/modules/home.dart';
import 'package:thebes_academy/shared/constants.dart';

import '../cubit/appCubit.dart';
import '../cubit/states.dart';
import '../shared/dummy.dart';

class ActivityDetails extends StatelessWidget {
  ActivityDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue[800],
              centerTitle: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Thebes ', style: GoogleFonts.poppins()),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      width: 50,
                      'lib/assets/images/logo.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(' Academy', style: GoogleFonts.poppins()),
                  const SizedBox(
                    width: 30,
                  ),
                ],
              ),
            ),
            body: Conditional.single(
              context: context,
              conditionBuilder: (context) =>
                  cubit.categoriesDetailModel != null &&
                  cubit.activitiesDetailModel != null,
              widgetBuilder: (context) => SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: AnimationLimiter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: AnimationConfiguration.toStaggeredList(
                      duration: const Duration(milliseconds: 500),
                      childAnimationBuilder: (widget) => SlideAnimation(
                        horizontalOffset: 50.0,
                        child: FadeInAnimation(
                          child: widget,
                        ),
                      ),
                      children: [
                        CarouselSlider(
                          options: CarouselOptions(
                            height: 220,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: true,
                            autoPlayInterval: const Duration(
                              seconds: 3,
                            ),
                            autoPlayAnimationDuration: const Duration(
                              seconds: 1,
                            ),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            scrollDirection: Axis.horizontal,
                            viewportFraction: 1,
                          ),
                          items: cubit.activitiesDetailModel!.result!.images!
                              .map((i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * .9,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 1.0),
                                  decoration:
                                      const BoxDecoration(color: Colors.amber),
                                  child: CachedNetworkImage(
                                    imageUrl: '${i.url}',
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: MaterialButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return const Login();
                                        },
                                      ),
                                    );
                                  },
                                  minWidth: MediaQuery.of(context).size.width,
                                  height: 50,
                                  color: defaultColor,
                                  child: Text(
                                    'Register In Activity',
                                    style:GoogleFonts.poppins(color: Colors.white,
                                      fontSize: 20,)
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                '${cubit.activitiesDetailModel!.result!.titleAr}',
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .4,
                                child: Divider(
                                  color: Colors.blue[800],
                                  thickness: 5,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.calendar_month,
                                    color: Colors.black,
                                  ),
                                  Text(
                                      '  ${getDate(cubit.activitiesDetailModel!.result!.createdAt)}'),
                                  const SizedBox(width: 50),
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 20.0,
                                  ),
                                  const SizedBox(width: 4.0),
                                  Text(
                                    '${cubit.activitiesDetailModel!.result!.ratingCount}',
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                  const SizedBox(width: 4.0),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  '${cubit.activitiesDetailModel!.result!.descriptionAr}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    height: 1.2,
                                    wordSpacing: -2,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              fallbackBuilder: (context) => const Center(
                child: CircularProgressIndicator(),
              ),
            ));
      },
    );
  }
}
