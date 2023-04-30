import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:thebes_academy/cubit/states.dart';
import 'package:thebes_academy/remoteNetwork/cacheHelper.dart';
import 'package:thebes_academy/remoteNetwork/dioHelper.dart';
import 'package:thebes_academy/shared/applocale.dart';
import 'package:thebes_academy/shared/bloc_observer.dart';
import 'package:thebes_academy/shared/constants.dart';
import 'package:thebes_academy/shared/test.dart';

import 'cubit/appCubit.dart';
import 'layouts/layout.dart';

Future<void> main(context) async {
  WidgetsFlutterBinding.ensureInitialized();

  await internetConection(context);
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
      const SystemUiOverlayStyle(
        statusBarColor: primaryColor,
      ),
    );
    return BlocProvider(
      create: (context) => AppCubit()
        ..getHomeData()
        ..getCategoryData()
        ..getProfileData()
        ..getTripsData()
        ..checkCurrentValue(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Thebes Academy',
            theme: ThemeData(
              primarySwatch: primaryColor,
              scaffoldBackgroundColor: Colors.white,
              primaryColor: primaryColor,
              iconTheme: const IconThemeData(
                color: Colors.white,
              ),
              appBarTheme: const AppBarTheme(
                centerTitle: true,
                color: primaryColor,
              ),
            ),
            home: splashScreen(),
            localizationsDelegates: const [
              AppLocale.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate
            ],
            supportedLocales: const [
              Locale("en", ""),
              Locale("ar", ""),
            ],
            locale: Locale(lang, ''),
            localeResolutionCallback: (currentLang, supportLang) {
              if (currentLang != null) {
                for (Locale locale in supportLang) {
                  if (locale.languageCode == currentLang.languageCode) {
                    return currentLang;
                  }
                }
              }
              return supportLang.first;
            },
          );
        },
      ),
    );
  }

  Widget splashScreen() => SplashScreenView(
        navigateRoute: const Layout(),
        duration: 4000,
        imageSize: 300,
        imageSrc: "lib/assets/images/logo.jpeg",
        text: "  ",
        textType: TextType.ScaleAnimatedText,
        textStyle: const TextStyle(
          fontSize: 38.0,
          color: primaryColor,
          fontWeight: FontWeight.w900,
        ),
        backgroundColor: Colors.white,
      );
}
