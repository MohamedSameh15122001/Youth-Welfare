import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thebes_academy/cubit/states.dart';
import 'package:thebes_academy/models/categoriesModel.dart';
import 'package:thebes_academy/remoteNetwork/endPoints.dart';

import '../models/activitiesModel.dart';
import '../models/activityDetailModel.dart';
import '../models/categoryDetailModel.dart';
import '../models/homeModel.dart';
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
}