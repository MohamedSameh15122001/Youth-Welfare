import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thebes_academy/cubit/appCubit.dart';
import 'package:thebes_academy/shared/constants.dart';

import '../cubit/states.dart';

class Home extends StatelessWidget {
  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return Conditional.single(
            context: context,
            conditionBuilder: (context) => cubit.homeModel != null ,
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
                            viewportFraction: 1.0,
                          ),
                          items: cubit.homeModel!.result![0].images!.map((i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * .9,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 1.0),
                                  decoration:
                                  const BoxDecoration(color: Colors.white),
                                  child: CachedNetworkImage(
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    imageUrl: '${i.url}',
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
                              const SizedBox(height: 20),
                              Text(
                                '${cubit.homeModel!.result![0].nameAr}',
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .4,
                                child: const Divider(
                                  color: primaryColor,
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
                                      '  ${getDate(cubit.homeModel!.result![0].updatedAt)}'),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  '${cubit.homeModel!.result![0].descriptionAr}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    height: 1.2,
                                    wordSpacing: -2,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ]),
                ),
              ),
            ),
            fallbackBuilder: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
