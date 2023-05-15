import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:thebes_academy/cubit/appCubit.dart';
import 'package:thebes_academy/cubit/states.dart';

import '../remoteNetwork/cacheHelper.dart';

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

void showToast({
  required String text,
  required ToastStates state,
  int time = 5,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: time,
      backgroundColor: primaryColor,
      textColor: Colors.white,
      fontSize: 16.0,

    );

// enum
// ignore: constant_identifier_names
enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.yellow;
      break;
  }

  return color;
}

String getDate(formattedString) {
  DateTime dateTime = DateTime.parse(formattedString);
  String date = DateFormat.yMMMd().format(dateTime);
  return date;
}

void navigateTo(BuildContext context, Widget widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

Widget separator(double wide, double high) {
  return SizedBox(
    width: wide,
    height: high,
  );
}

void pop(context) {
  Navigator.pop(context);
}

void navigateAndKill(context, widget) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => widget), (route) => false);
}

Widget myDivider() => Container(
      color: Colors.grey[300],
      height: 1,
      width: double.infinity,
    );

void signOut(context) {
  CacheHelper.removeData('token').then((value) {
    token = null;
    AppCubit.get(context).RA = [];
    AppCubit.get(context).emit(RemoveTokenState());
  });
}

const MaterialColor primaryColor = MaterialColor(
  0xFF0D47A1,
  <int, Color>{
    50: Color(0xFFE3F2FD),
    100: Color(0xFFBBDEFB),
    200: Color(0xFF90CAF9),
    300: Color(0xFF64B5F6),
    400: Color(0xFF42A5F5),
    500: Color(0xFF2196F3),
    600: Color(0xFF1E88E5),
    700: Color(0xFF1976D2),
    800: Color(0xFF1565C0),
    900: Color(0xFF0D47A1),
  },
);

String? token;
String lang = CacheHelper.getData('lang') ?? 'ar';
String specialization = 'علوم حاسب';

// List<String> s = ["التبرع بالدم", "التكافل الاجتماعي", "زياره ملاجئ الايتام"];



List<String> items = [
"علوم حاسب",
"محاسبة",
"هندسة",
"نظم المعلومات الادارية",
"ادارة الاعمال",
"تسويق",
];


bool isValidEmail(email) {
  return RegExp(
    r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
  ).hasMatch(email);
}

bool isValidPass(pass) {
  return RegExp(r"^(?=.*[a-zA-Z])(?=.*\d).{8,}$").hasMatch(pass);
}