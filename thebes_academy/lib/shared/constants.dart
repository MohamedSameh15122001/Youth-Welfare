import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

// void showToast(msg) {
//   Fluttertoast.showToast(
//       msg: msg,
//       toastLength: Toast.LENGTH_LONG,
//       gravity: ToastGravity.BOTTOM,
//       timeInSecForIosWeb: 5,
//       backgroundColor: Colors.red,
//       textColor: Colors.white,
//       fontSize: 16.0);
// }
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





Color defaultColor = Colors.red;

String? token = '';
String lang ='en';
