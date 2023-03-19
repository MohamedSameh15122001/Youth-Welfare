import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';



void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

void showToast({
  required String text,
  required ToastStates state,
  int time=5,

}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: time,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

// enum
// ignore: constant_identifier_names
enum ToastStates {SUCCESS, ERROR, WARNING}

Color chooseToastColor(ToastStates state)
{
  Color color;

  switch(state)
  {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
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

// void signOut(context) {
//   CacheHelper.removeData('token').then((value) {
//     navigateAndKill(context, LoginScreen());
//     ShopCubit.get(context).currentIndex = 0;
//   });
// }





Color defaultColor = Colors.blue[800]!;

String? token = '';
String lang ='ar';
String specialization='Computer Science';
