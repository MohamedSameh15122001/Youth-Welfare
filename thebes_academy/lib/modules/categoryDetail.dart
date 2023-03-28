import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';
import 'package:thebes_academy/modules/home.dart';

import '../cubit/appCubit.dart';
import '../cubit/states.dart';
import '../shared/constants.dart';
import '../shared/dummy.dart';
import 'activityDetail.dart';

class Category extends StatelessWidget {


  Category({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state)
      {},
        builder: (context,state){
          var cubit =AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            centerTitle: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Text('Thebes ',style: GoogleFonts.poppins()),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    width: 50,
                    'lib/assets/images/logo.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                 Text(' Academy',style: GoogleFonts.poppins()),
                const SizedBox(width: 30,),

              ],
            ),
          ),
          body:Conditional.single(
            context: context,
            conditionBuilder: (context) => cubit.categoriesDetailModel != null && cubit.activitiesModel != null,
            widgetBuilder:(context) => SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: AnimationLimiter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: AnimationConfiguration.toStaggeredList(
                      duration: const Duration(milliseconds: 500),
                      childAnimationBuilder:(widget) => SlideAnimation(
                    horizontalOffset: 50.0,
                    child: FadeInAnimation(
                      child: widget,
                    ),
                  ) ,
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
                          items: cubit.categoriesDetailModel!.result!.images!.map((i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height * .9,
                                  margin: const EdgeInsets.symmetric(horizontal: 1.0),
                                  decoration: const BoxDecoration(color: Colors.amber),
                                  child: CachedNetworkImage(
                                    imageUrl:'${i.url}',
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
                              Text(
                                '${cubit.categoriesDetailModel!.result!.titleAr}',
                                style:
                                const TextStyle(
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
                                children:  [
                                  const Icon(
                                    Icons.calendar_month,
                                    color: Colors.black,
                                  ),
                                  Text('  ${getDate(cubit.categoriesDetailModel!.result!.updatedAt)}'),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0),
                                child: ReadMoreText(
                                  '${cubit.categoriesDetailModel!.result!.descriptionAr}',
                                  trimLines: 10,
                                  // textAlign: TextAlign.left,
                                  lessStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                  moreStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                  trimMode: TrimMode.Line,
                                  trimCollapsedText: " Show More ",
                                  trimExpandedText: " Show Less ",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    height: 1.2,
                                    wordSpacing: -2,
                                  ),
                                ),
                              ),
                              const Divider(
                                color: primaryColor,
                                thickness: 5,
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                'The most important activities:-',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              AnimationLimiter(
                                child: GridView.count(
                                  shrinkWrap:true,
                                  childAspectRatio: .6,
                                  crossAxisSpacing: 12,
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: const EdgeInsets.symmetric(vertical: 20),
                                  crossAxisCount: 3,
                                  children: List.generate(
                                    cubit.activitiesModel!.result!.length,
                                        (int index) {
                                      return AnimationConfiguration.staggeredGrid(
                                        position: index,
                                        duration: const Duration(milliseconds: 500),
                                        columnCount: 3,
                                        child: ScaleAnimation(
                                          duration: const Duration(milliseconds: 900),
                                          curve: Curves.fastLinearToSlowEaseIn,
                                          child: FadeInAnimation(
                                            child: ClipRRect(
                                              borderRadius: const BorderRadius.all(Radius.circular(40)),
                                              child: GestureDetector(
                                                onTap: () {
                                                  cubit.getActivitiesDetailData(cubit.categoriesDetailModel!.result!.sId,cubit.activitiesModel!.result![index].sId );

                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => ActivityDetails(),
                                                    ),
                                                  );
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                                  child: Container(
                                                    padding: const EdgeInsets.symmetric(horizontal: 0),
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
                                                          width: 80,
                                                          height: 100,
                                                          fit: BoxFit.fill,
                                                          imageUrl: '${cubit.activitiesModel!.result![index].coverImage}',
                                                        ),
                                                        const Divider(color: Colors.grey, thickness: .4),
                                                        Text(
                                                          '${cubit.activitiesModel!.result![index].titleAr}',
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
                              )

                            ],
                          ),
                        ),
                      ]),

                ),
              ),
            ),
            fallbackBuilder:(context) => const Center(child: CircularProgressIndicator(),),
          )

        );
        },

    );
  }
}
