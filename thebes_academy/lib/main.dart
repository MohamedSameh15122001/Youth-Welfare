import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:thebes_academy/remoteNetwork/cacheHelper.dart';
import 'package:thebes_academy/remoteNetwork/dioHelper.dart';
import 'package:thebes_academy/shared/bloc_observer.dart';
import 'package:thebes_academy/shared/constants.dart';

import 'cubit/appCubit.dart';
import 'layouts/layout.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  token = CacheHelper.getData('token');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: defaultColor,
      ),
    );
    return BlocProvider(
      create: (context) => AppCubit()..getHomeData()..getCategoryData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'graduation project',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primaryColor: defaultColor,
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          appBarTheme: AppBarTheme(
            centerTitle: true,
            color: defaultColor,
          ),
        ),
        home: splashScreen(),
      ),
    );
  }

  Widget splashScreen() => SplashScreenView(
        navigateRoute: const Layout(),
        duration: 4000,
        imageSize: 200,
        imageSrc: "lib/assets/images/header.png",
        text: "  ",
        textType: TextType.ScaleAnimatedText,
        textStyle: TextStyle(
          fontSize: 38.0,
          color: defaultColor ,
          fontWeight: FontWeight.w900,
        ),
        backgroundColor: Colors.white,
      );
}
