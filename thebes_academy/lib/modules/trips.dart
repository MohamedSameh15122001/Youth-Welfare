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
import '../models/tripsModel.dart';
import '../shared/constants.dart';
import 'activityDetail.dart';

class Trips extends StatelessWidget {
  const Trips({super.key});

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
                  if(lang =='ar')
                    const SizedBox(
                      width: 76,
                    ),
                  if(lang =='en')
                    const SizedBox(
                      width: 30,
                    ),

                ],
              ),
            ),
            body: Conditional.single(
              context: context,
              conditionBuilder: (context) => cubit.tripsModel != null ,
              widgetBuilder: (context) => AnimationLimiter(
                child:ListView.separated(
                    itemBuilder:(context,index) => AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 0),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child:buildTripsItem(cubit.tripsModel!.result![index],context),
                        ),
                      ),
                    ),
                    separatorBuilder:(context,index) => const SizedBox(height: 20,),
                    itemCount: AppCubit.get(context).tripsModel!.result!.length
                )
              ),
              fallbackBuilder: (context) => const Center(
                child: CircularProgressIndicator(),
              ),
            )
        );
      },
    );
  }
}


Widget buildTripsItem (Result model,context) {
  return
    Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: primaryColor),
          borderRadius: BorderRadius.circular(30)
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children:
          [
            Text('${model.titleAr}',style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 18),),
            Text('${model.descriptionAr}',style: GoogleFonts.poppins(fontSize: 15),),
            SizedBox(height: 5,),
            ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage( imageUrl: '${model.image}',width: MediaQuery.of(context).size.width,height: 120,fit: BoxFit.cover,)),
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Text(getLang(context, "PlaceText"),style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 15),),
                      Expanded(child: Text('${model.placeAr}',style: GoogleFonts.poppins(fontSize: 15),)),

                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Text(getLang(context,"DateText"),style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 15),),
                      Expanded(child: Text(getDate(model.date),style: GoogleFonts.poppins(fontSize: 15,),))

                    ],
                  ),
                ),

              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(getLang(context,"PriceText"),style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 15),),
                Text('${model.price}',style: GoogleFonts.poppins(fontSize: 15,),)

              ],
            ),
          ],
        ),
      ),
    );
}