// import 'package:bloc/bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shop/cubit/states.dart';
// import 'package:shop/models/profileModels/userModel.dart';
// import 'package:shop/remoteNetwork/dioHelper.dart';
// import 'package:shop/remoteNetwork/endPoints.dart';
// import 'package:shop/shared/constants.dart';
//
// class RegisterCubit extends Cubit<ShopStates>
// {
//   RegisterCubit() : super(InitialState());
//
//   static RegisterCubit get(context) => BlocProvider.of(context);
//
//   late UserModel registerModel;
//
//   void signUp({
//     required String name,
//     required String phone,
//     required String email,
//     required String password,
//   }) {
//     emit(SignUpLoadingState());
//     DioHelper.postData(
//         url: SIGNUP,
//         token: token,
//         data:
//         {
//           'name': '$name',
//           'email': '$email',
//           'phone': '$phone',
//           'password': '$password',
//         }).then((value) {
//       registerModel = UserModel.fromJson(value.data);
//       emit(SignUpSuccessState(registerModel));
//     }).catchError((error) {
//       print(error.toString());
//       emit(SignUpErrorState());
//     });
//   }
//
//   bool showPassword = true;
//   IconData suffixIcon = Icons.visibility;
//   void changeSuffixIcon(context){
//     showPassword =! showPassword;
//     if(showPassword==false)
//       suffixIcon = Icons.visibility_off;
//     else
//       suffixIcon = Icons.visibility;
//     emit(ChangeSuffixIconState());
//   }
//
//   bool showConfirmPassword = true;
//   IconData confirmSuffixIcon = Icons.visibility;
//   void changeConfirmSuffixIcon(context){
//     showConfirmPassword =! showConfirmPassword;
//     if(showConfirmPassword==false)
//       confirmSuffixIcon = Icons.visibility_off;
//     else
//       confirmSuffixIcon = Icons.visibility;
//     emit(ChangeSuffixIconState());
//   }
//
// }