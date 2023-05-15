import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';
import 'package:thebes_academy/shared/applocale.dart';

import '../cubit/appCubit.dart';
import '../cubit/states.dart';
import '../layouts/layout.dart';
import '../models/tripsModel.dart';
import '../shared/constants.dart';
import 'activityDetail.dart';

class Trips extends StatelessWidget {
  const Trips({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AddTripSuccessState) {
          showToast(
              text: '${state.enrollTripModel.message}',
              state: ToastStates.SUCCESS);
          Navigator.pop(context);
        }

        if (state is AddTripErrorState) {
          showToast(
              text: '${AppCubit.get(context).errorModel!.message}',
              state: ToastStates.ERROR);
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
                  Text(getLang(context, "layoutTitle2"),
                      style: GoogleFonts.poppins()),
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
                  if (lang == 'ar')
                    const SizedBox(
                      width: 76,
                    ),
                  if (lang == 'en')
                    const SizedBox(
                      width: 30,
                    ),
                ],
              ),
            ),
            body: Conditional.single(
              context: context,
              conditionBuilder: (context) => cubit.tripsModel != null,
              widgetBuilder: (context) => AnimationLimiter(
                  child: ListView.separated(
                      itemBuilder: (context, index) =>
                          AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 0),
                            child: SlideAnimation(
                              verticalOffset: 50.0,
                              child: FadeInAnimation(
                                child: buildTripsItem(
                                    cubit.tripsModel!.result![index],
                                    context,
                                    cubit),
                              ),
                            ),
                          ),
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 20,
                          ),
                      itemCount:
                          AppCubit.get(context).tripsModel!.result!.length)),
              fallbackBuilder: (context) => const Center(
                child: CircularProgressIndicator(),
              ),
            ));
      },
    );
  }
}

Widget buildTripsItem(Result model, context, AppCubit cubit) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Container(
      decoration: BoxDecoration(
          border: Border.all(color: primaryColor),
          borderRadius: BorderRadius.circular(30)),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '${model.titleAr}',
            style:
                GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Text(
            '${model.descriptionAr}',
            style: GoogleFonts.poppins(fontSize: 15),
          ),
          const SizedBox(
            height: 5,
          ),
          ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: '${model.image}',
                width: MediaQuery.of(context).size.width,
                height: 120,
                fit: BoxFit.cover,
              )),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Text(
                      getLang(context, "PlaceText"),
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Expanded(
                        child: Text(
                      '${model.placeAr}',
                      style: GoogleFonts.poppins(fontSize: 15),
                    )),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Text(
                      getLang(context, "DateText"),
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Expanded(
                        child: Text(
                      getDate(model.date),
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                      ),
                    ))
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                getLang(context, "PriceText"),
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold, fontSize: 15),
              ),
              Text(
                '${model.price}',
                style: GoogleFonts.poppins(
                  fontSize: 15,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          if (!cubit.RT.contains('${model.sId}'))
            Container(
              width: 110,
              height: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: MaterialButton(
                  onPressed: () {
                    if (token == null) {
                      showToast(
                          text: getLang(context, 'activityYouMustLoginFirst'),
                          state: ToastStates.WARNING);
                      currentPage = 2;
                      navigateAndKill(context, const Layout());
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Center(
                                    child: Text(
                                  getLang(context, 'Are you sure'),
                                  style: GoogleFonts.poppins(
                                      color: primaryColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400),
                                )),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        OutlinedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                                getLang(context,
                                                    'activityRateCancelButton'),
                                                style: GoogleFonts.poppins(
                                                    color: primaryColor,
                                                    fontWeight:
                                                        FontWeight.w500))),
                                        OutlinedButton(
                                            onPressed: () {
                                              AppCubit.get(context).addTrip(
                                                  token: token,
                                                  tripID: model.sId);
                                            },
                                            child: Text(
                                                getLang(context,
                                                    'register in trip'),
                                                style: GoogleFonts.poppins(
                                                    color: primaryColor,
                                                    fontWeight:
                                                        FontWeight.w500)))
                                      ],
                                    )
                                  ],
                                ),
                              ));
                    }
                  },
                  minWidth: MediaQuery.of(context).size.width,
                  height: 50,
                  color: primaryColor,
                  child: Text(getLang(context, 'register in trip'),
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 15,
                      )),
                ),
              ),
            ),
          if (cubit.RT.contains('${model.sId}'))
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: 155,
                height: 40,
                color: Colors.grey,
                child: Center(
                    child: Text(
                  '${getLang(context, 'Already registered')}',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600, fontSize: 15),
                )),
              ),
            ),
        ],
      ),
    ),
  );
}
