import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thebes_academy/cubit/appCubit.dart';
import 'package:thebes_academy/layouts/layout.dart';

import '../cubit/states.dart';
import '../shared/applocale.dart';
import '../shared/constants.dart';
import '../shared/test.dart';

class NoConnection extends StatelessWidget {
  const NoConnection({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state) {},
      builder: (context,state) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(getLang(context, "No connection"),style: GoogleFonts.poppins(fontSize: 25),),
            SizedBox(height: 20,),
            Icon(Icons.wifi,size: 170,color: Colors.grey,),
            Text(getLang(context, "An internet error"),style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w300),),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: MaterialButton(
                  onPressed: () {
                    internetConection(context).then((value) {
                      AppCubit.get(context).getHomeData();
                      AppCubit.get(context).getCategoryData();
                      AppCubit.get(context).getProfileData();
                      AppCubit.get(context).emit(CheckInternetState());
                      navigateAndKill(context, Layout());
                    });
                  },
                  minWidth: MediaQuery.of(context).size.width,
                  height: 50,
                  color: primaryColor,
                  child: Text(getLang(context, "TRY AGAIN"),
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 20,
                      )),
                ),
              ),
            ),
          ],
        );
      },

    );

  }
}