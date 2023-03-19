import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thebes_academy/cubit/states.dart';
import 'package:thebes_academy/models/categoriesModel.dart';
import 'package:thebes_academy/models/loginModel.dart';
import 'package:thebes_academy/remoteNetwork/endPoints.dart';

import '../models/activitiesModel.dart';
import '../models/activityDetailModel.dart';
import '../models/categoryDetailModel.dart';
import '../models/homeModel.dart';
import '../models/registerModel.dart';
import '../remoteNetwork/dioHelper.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(InitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  HomeModel? homeModel;
  void getHomeData() {
    emit(HomeLoadingState());
     Dio().get('https://actitvityv1.onrender.com').then((value)  {
     homeModel = HomeModel.fromJson(value.data);
     // print(value.data);
    emit(HomeSuccessState());
  }).catchError((error){
      emit(HomeErrorState());
      print(error.toString());
    }) ;

  }

  CategoriesModel? categoriesModel;
  void getCategoryData() {
    emit(CategoriesLoadingState());
    DioHelper.getData(
      url: Categories,
      query: {'lang':'ar'}
    ).then((value){
      categoriesModel = CategoriesModel.fromJson(value.data);
      // print(categoriesModel!.result![0].titleAr);
      emit(CategoriesSuccessState());
    }).catchError((error){
      emit(CategoriesErrorState());
      print(error.toString());
    });
  }


  CategoryDetailModel? categoriesDetailModel;
  void getCategoriesDetailData( String? categoryID ) {
    categoriesDetailModel=null;
    emit(CategoryDetailsLoadingState());
    DioHelper.getData(
        url:'$Categories/$categoryID',
        query: {'lang':'ar'}
    ).then((value){
      categoriesDetailModel = CategoryDetailModel.fromJson(value.data);
      // print('${categoriesDetailModel!.result!.titleAr}');
      emit(CategoryDetailsSuccessState());
    }).catchError((error){
      emit(CategoryDetailsErrorState());
      print(error.toString());
    });
  }

  ActivitiesModel? activitiesModel;
  void getActivityData(String? categoryID) {
    emit(ActivitiesLoadingState());
    DioHelper.getData(
        url: '$Categories/$categoryID/$Activities',
        query: {'lang':'ar'}
    ).then((value){
      activitiesModel = ActivitiesModel.fromJson(value.data);
       // print(activitiesModel!.result![0].titleAr);
      emit(ActivitiesSuccessState());
    }).catchError((error){
      emit(ActivitiesErrorState());
      print(error.toString());
    });
  }


  ActivityDetailModel? activitiesDetailModel;
  void getActivitiesDetailData( String? categoryID,String? activityID ) {
    activitiesDetailModel=null;
    emit(ActivitiesDetailsLoadingState());
    DioHelper.getData(
        url:'$Categories/$categoryID/$Activities/$activityID',
        query: {'lang':'ar'}
    ).then((value){
      activitiesDetailModel = ActivityDetailModel.fromJson(value.data);
       // print('${activitiesDetailModel!.result!.titleAr}');
      emit(ActivitiesDetailsSuccessState());
    }).catchError((error){
      emit(ActivitiesDetailsErrorState());
      print(error.toString());
    });
  }

/////////////////////////////////////////////////////////////////////

  LoginModel? loginModel;
  void signIn({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(
      query: {'lang':'ar'},
        url: Login,
        data:
        {
          'email': '$email',
          'password': '$password',
        }).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      // print('${loginModel!.message}');

      emit(LoginSuccessState(loginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(LoginErrorState(loginModel!));
    });
  }

  bool showPassword = true;
  IconData suffixIcon = Icons.visibility;
  void changeSuffixIcon(context){
    showPassword =! showPassword;
    if(showPassword==false) {
      suffixIcon = Icons.visibility_off;
    } else {
      suffixIcon = Icons.visibility;
    }
    emit(ChangeSuffixIconState());
  }

///////////////////////////////////////////////////////////////////

   RegisterModel? registerModel;

  void signUp({
    required String fullName,
    required String code,
    required String phone,
    required String email,
    required String password,
    required String specialization_ar,
    required String specialization_en,

  }) {
    emit(SignUpLoadingState());
    DioHelper.postData(
        url: Register,
        query: {'lang':'ar'},
        data:
        {
          'full_name': '$fullName',
          'code':'$code',
          'email': '$email',
          'phone': '$phone',
          'password': '$password',
          'Specialization_ar' : '$specialization_ar',
        'Specialization_en' : '$specialization_en'
        }).then((value) {
      registerModel = RegisterModel.fromJson(value.data);
      print('${registerModel!.message}');

      emit(SignUpSuccessState(registerModel!));
    }).catchError((error) {
      print(error.toString());
      emit(SignUpErrorState(registerModel!));
    });
  }

  bool showPasswordR = true;
  IconData suffixIconR = Icons.visibility;
  void changeSuffixIconR(context){
    showPasswordR =! showPasswordR;
    if(showPasswordR==false) {
      suffixIconR = Icons.visibility_off;
    } else {
      suffixIconR = Icons.visibility;
    }
    emit(ChangeSuffixIconState());
  }

  bool showConfirmPasswordR = true;
  IconData confirmSuffixIconR = Icons.visibility;
  void changeConfirmSuffixIconR(context){
    showConfirmPasswordR =! showConfirmPasswordR;
    if(showConfirmPasswordR==false) {
      confirmSuffixIconR = Icons.visibility_off;
    } else {
      confirmSuffixIconR = Icons.visibility;
    }
    emit(ChangeSuffixIconState());
  }


}