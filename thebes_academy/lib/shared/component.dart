import 'package:flutter/material.dart';
import 'package:thebes_academy/shared/constants.dart';


Widget defaultFormField({
  required context,
  TextEditingController? controller,
  dynamic label,
  dynamic hint,
  IconData ? prefix,
  String ? initialValue,
  TextInputType ?keyboardType,
  onSubmit,
  onChange,
  onTap,
  required  validate,
  bool isPassword = false,
  bool enabled = true,
  IconData ?suffix,
  suffixPressed,
}) =>
    TextFormField(
      // cursorColor: defaultColor,

      controller: controller,
      keyboardType: keyboardType,
      obscureText: isPassword,
      textAlign: TextAlign.start,
      onFieldSubmitted: onSubmit,
      enabled: enabled,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      textCapitalization: TextCapitalization.words,
      textAlignVertical: TextAlignVertical.center,
      style:Theme.of(context).textTheme.bodyText1,
      initialValue:initialValue ,
      //textCapitalization: TextCapitalization.words,

      decoration: InputDecoration(
        iconColor: primaryColor,
        hintText: label,
        labelText: hint,
        border:const UnderlineInputBorder(),
        prefixIcon: Icon(prefix,),
        suffixIcon: suffix != null ? IconButton(onPressed: suffixPressed, icon: Icon(suffix)) : null,

      ),
    );

Widget defaultButton({
  required VoidCallback onTap,
  required String text,
  double? width = double.infinity,

}) => Container(
  height: 40,
  width: width,
  decoration: const BoxDecoration(
    color: primaryColor,
  ),
  child: ElevatedButton(

    onPressed: onTap,
    child: Text(
      '$text',
      style: const TextStyle(
        color: Colors.white,
        fontSize: 17,
      ),
    ),
  ),
);



