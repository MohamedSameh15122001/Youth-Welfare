import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thebes_academy/modules/Login.dart';
import 'package:thebes_academy/modules/home.dart';
import 'package:thebes_academy/modules/profile.dart';
import 'package:thebes_academy/shared/constants.dart';

import '../cubit/appCubit.dart';
import '../cubit/states.dart';
import '../layouts/layout.dart';
import '../shared/dummy.dart';

class ActivityDetails extends StatelessWidget {
  ActivityDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AddActivitySuccessState) {
          showToast(
              text: '${state.enrollModel.message}', state: ToastStates.SUCCESS);
        }

        if (state is AddActivityErrorState) {
          showToast(
              text: '${AppCubit.get(context).errorModel!.message}', state: ToastStates.ERROR);
        }

        if (state is CancelActivitySuccessState) {
          showToast(text: '${state.cancelModel.message}', state: ToastStates.SUCCESS);
        }

        if (state is RateSuccessState) {
          showToast(text: '${state.rateModel.message}', state: ToastStates.SUCCESS);
          AppCubit.get(context).getActivitiesDetailData( AppCubit.get(context).categoriesDetailModel!.result!.sId,
              AppCubit.get(context).activitiesDetailModel!.result!.sId);
          Navigator.pop(context);
        }


        if (state is RateErrorState) {
          showToast(text: '${AppCubit.get(context).errorModel!.message}', state: ToastStates.ERROR);
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);


        return Scaffold(
            appBar: AppBar(
              backgroundColor: primaryColor,
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
                              if(!cubit.RA.contains('${cubit.activitiesDetailModel!.result!.titleAr}'))
                                ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: state is AddActivityLoadingState
                                    ? const SizedBox(
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                        height: 50,
                                      )
                                    : MaterialButton(
                                        onPressed: () {
                                          if (token == null) {
                                            showToast(text: 'You must login first', state: ToastStates.WARNING);
                                            currentPage=2;
                                           navigateAndKill(context, const Layout());
                                          } else {
                                            cubit.addActivity(
                                                activityID: cubit
                                                    .activitiesDetailModel!
                                                    .result!
                                                    .sId,
                                                categoryID: cubit
                                                    .categoriesDetailModel!
                                                    .result!
                                                    .sId);
                                          }
                                        },
                                        minWidth:
                                            MediaQuery.of(context).size.width,
                                        height: 50,
                                        color: primaryColor,
                                        child: Text('Register In Activity',
                                            style: GoogleFonts.poppins(
                                              color: Colors.white,
                                              fontSize: 20,
                                            )),
                                      ),
                              ),
                              if(cubit.RA.contains('${cubit.activitiesDetailModel!.result!.titleAr}') && token!=null)
                                ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: state is CancelActivityLoadingState
                                    ? const SizedBox(
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  height: 50,
                                )
                                    : MaterialButton(
                                  onPressed: () {
                                      cubit.cancelActivity(
                                          activityID: cubit
                                              .activitiesDetailModel!
                                              .result!
                                              .sId,
                                          categoryID: cubit
                                              .categoriesDetailModel!
                                              .result!
                                              .sId);
                                  },
                                  minWidth:
                                  MediaQuery.of(context).size.width,
                                  height: 50,
                                  color: primaryColor,
                                  child: Text('Cancel',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 20,
                                      )),
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
                                  const SizedBox(width: 40),
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 20.0,
                                  ),
                                  const SizedBox(width: 4.0),
                                  Text(
                                    '${cubit.activitiesDetailModel!.result!.averageRating}',
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                  const Spacer(),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: SizedBox(
                                      height: 40,
                                      width: 90,
                                      child: MaterialButton(onPressed: (){
                                        showDialog(context: context, builder: (context) => AlertDialog(
                                          title: Center(child: Text('Rate This Activity',style: GoogleFonts.poppins(color: primaryColor,fontWeight: FontWeight.w600),)),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              buildRating(),
                                              const SizedBox(height: 15,),
                                              state is RateLoadingState ?
                                              const LinearProgressIndicator() : Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  OutlinedButton(onPressed: (){
                                                    Navigator.pop(context);
                                                  }, child: Text('Cancel',style: GoogleFonts.poppins(color: primaryColor,fontWeight: FontWeight.w500))),
                                                  OutlinedButton(onPressed: (){
                                                    cubit.setRate(
                                                      categoryID: cubit.categoriesDetailModel!.result!.sId,
                                                      activityID: cubit.activitiesDetailModel!.result!.sId,
                                                      rate: Rating
                                                    );
                                                  }, child: Text('Done',style: GoogleFonts.poppins(color: primaryColor,fontWeight: FontWeight.w500)))

                                                ],
                                              )
                                            ],
                                          ),
                                        )
                                        );

                                      },color: primaryColor,child: Text('RATING',style: GoogleFonts.poppins(color: Colors.white),),),
                                    ),
                                  ),
                                  const SizedBox(width: 5.0),
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

double Rating =0;
Widget buildRating () => RatingBar.builder(
    itemBuilder: ((context, index) => const Icon(Icons.star,color: Colors.amber,)),
    onRatingUpdate:(rating) => Rating = rating,
  itemSize: 30,
  minRating: 1,
  maxRating: 5,
  itemPadding: const EdgeInsets.symmetric(horizontal: 4),
  updateOnDrag: true,
);