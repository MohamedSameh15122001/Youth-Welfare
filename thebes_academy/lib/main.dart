import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:thebes_academy/remoteNetwork/dioHelper.dart';
import 'package:thebes_academy/shared/bloc_observer.dart';

import 'cubit/appCubit.dart';
import 'layouts/layout.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.blue[800],
      ),
    );
    return BlocProvider(
      create: (context) => AppCubit()..getHomeData()..getCategoryData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'graduation project',
        theme: ThemeData(
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          appBarTheme: AppBarTheme(
            centerTitle: true,
            color: Colors.blue[800],
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
        imageSrc: "lib/assets/images/logo.jpg",
        text: "  ",
        textType: TextType.ScaleAnimatedText,
        textStyle: TextStyle(
          fontSize: 38.0,
          color: Colors.blue[800],
          fontWeight: FontWeight.w900,
        ),
        backgroundColor: Colors.white,
      );
}

// getdata() async {
//     var url = 'https://69b2-41-236-140-106.eu.ngrok.io/api/v1/products/';
//     var response = await http.get(Uri.parse(url));
//     Map data = jsonDecode(response.body);
//     debugPrint(data['page']);
//   }