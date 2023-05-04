import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thebes_academy/cubit/states.dart';
import 'package:thebes_academy/models/categoriesModel.dart';
import 'package:thebes_academy/models/errorModel.dart';
import 'package:thebes_academy/models/loginModel.dart';
import 'package:thebes_academy/remoteNetwork/cacheHelper.dart';
import 'package:thebes_academy/remoteNetwork/endPoints.dart';
import 'package:thebes_academy/shared/applocale.dart';
import '../models/activitiesModel.dart';
import '../models/activityDetailModel.dart';
import '../models/categoryDetailModel.dart';
import '../models/enrollModel.dart';
import '../models/homeModel.dart';
import '../models/profileModel.dart';
import '../models/registerModel.dart';
import '../models/tripsModel.dart';
import '../modules/activityDetail.dart';
import '../remoteNetwork/dioHelper.dart';
import '../shared/constants.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  List<String> RA = [];
  List<String> RT = [];

  ErrorModel? errorModel;
  /////////////////////////////////////////////////////////////////////

  HomeModel? homeModel;
  void getHomeData() {
    emit(HomeLoadingState());
    Dio().get('https://actitvityv1.onrender.com',
        queryParameters: {'lang': lang}).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      // print(value.data);
      emit(HomeSuccessState());
    }).catchError((error) {
      emit(HomeErrorState());
      print(error.toString());
    });
  }

/////////////////////////////////////////////////////////////////////

  CategoriesModel? categoriesModel;
  void getCategoryData() {
    emit(CategoriesLoadingState());
    DioHelper.getData(url: Categories, query: {'lang': lang}).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      // print(categoriesModel!.result![0].titleAr);
      emit(CategoriesSuccessState());
    }).catchError((error) {
      emit(CategoriesErrorState());
      print(error.toString());
    });
  }

  /////////////////////////////////////////////////////////////////////

  CategoryDetailModel? categoriesDetailModel;
  void getCategoriesDetailData(String? categoryID) {
    categoriesDetailModel = null;
    emit(CategoryDetailsLoadingState());
    DioHelper.getData(url: '$Categories/$categoryID', query: {'lang': lang})
        .then((value) {
      categoriesDetailModel = CategoryDetailModel.fromJson(value.data);
      // print('${categoriesDetailModel!.result!.titleAr}');
      emit(CategoryDetailsSuccessState());
    }).catchError((error) {
      emit(CategoryDetailsErrorState());
      print(error.toString());
    });
  }

  /////////////////////////////////////////////////////////////////////

  ActivitiesModel? activitiesModel;
  void getActivityData(String? categoryID) {
    emit(ActivitiesLoadingState());
    DioHelper.getData(
        url: '$Categories/$categoryID/$Activities',
        query: {'lang': lang}).then((value) {
      activitiesModel = ActivitiesModel.fromJson(value.data);
      // print(activitiesModel!.result![0].titleAr);
      emit(ActivitiesSuccessState());
    }).catchError((error) {
      emit(ActivitiesErrorState());
      print(error.toString());
    });
  }

  /////////////////////////////////////////////////////////////////////

  ActivityDetailModel? activitiesDetailModel;
  void getActivitiesDetailData(
    String? categoryID,
    String? activityID,
  ) {
    activitiesDetailModel = null;
    emit(ActivitiesDetailsLoadingState());
    DioHelper.getData(
        url: '$Categories/$categoryID/$Activities/$activityID',
        query: {'lang': lang}).then((value) {
      activitiesDetailModel = ActivityDetailModel.fromJson(value.data);
      // print('${activitiesDetailModel!.result!.titleAr}');

      emit(ActivitiesDetailsSuccessState());
    }).catchError((error) {
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
        query: {'lang': lang},
        url: Login,
        data: {
          'email': email,
          'password': password,
        }).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      // print('${loginModel!.message}');
      emit(LoginSuccessState(loginModel!));
    }).catchError((error) {
      if (error is DioError) if (error.response!.statusCode == 401) {
        errorModel = ErrorModel.fromJson(error.response!.data);
      }
      emit(LoginErrorState());
    });
  }

  bool showPassword = true;
  IconData suffixIcon = Icons.visibility;
  void changeSuffixIcon(context) {
    showPassword = !showPassword;
    if (showPassword == false) {
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
    DioHelper.postData(url: Register, query: {
      'lang': lang
    }, data: {
      'fullName': fullName,
      'code': code,
      'email': email,
      'phone': phone,
      'password': password,
      'Specialization_ar': specialization_ar,
      'Specialization_en': specialization_en
    }).then((value) {
      registerModel = RegisterModel.fromJson(value.data);
      // print('${registerModel!.message}');

      emit(SignUpSuccessState(registerModel!));
    }).catchError((error) {
      print('$error');
      if (error is DioError) if (error.response!.statusCode == 401) {
        errorModel = ErrorModel.fromJson(error.response!.data);
        print('${errorModel!.message}');
      }
      emit(SignUpErrorState());
    });
  }

  bool showPasswordR = true;
  IconData suffixIconR = Icons.visibility;
  void changeSuffixIconR(context) {
    showPasswordR = !showPasswordR;
    if (showPasswordR == false) {
      suffixIconR = Icons.visibility_off;
    } else {
      suffixIconR = Icons.visibility;
    }
    emit(ChangeSuffixIconState());
  }

  bool showConfirmPasswordR = true;
  IconData confirmSuffixIconR = Icons.visibility;
  void changeConfirmSuffixIconR(context) {
    showConfirmPasswordR = !showConfirmPasswordR;
    if (showConfirmPasswordR == false) {
      confirmSuffixIconR = Icons.visibility_off;
    } else {
      confirmSuffixIconR = Icons.visibility;
    }
    emit(ChangeSuffixIconState());
  }

  /////////////////////////////////////////////////////////////////////

  ProfileModel? profileModel;
  void getProfileData() {
    emit(ProfileLoadingState());
    DioHelper.getData(
      query: {'lang': lang},
      token: '$token',
      url: Profile,
    ).then((value) {
      profileModel = ProfileModel.fromJson(value.data);

      RT= [];
      RA= [];

      var num = profileModel!.student!.activity!.length;
      for (var l = 0; l < num; l++) {
        if(lang=='ar')
        RA.add('${profileModel!.student!.activity![l].titleAr}');
        else
          RA.add('${profileModel!.student!.activity![l].titleEn}');
      }

      var num1 = profileModel!.student!.trip!.length;
      for (var l = 0; l < num1; l++) {
          RT.add(profileModel!.student!.trip![l]);
      }
      emit(ProfileSuccessState());
    }).catchError((error) {
      emit(ProfileErrorState());
      print(error.toString());
    });
  }

/////////////////////////////////////////////////////////////////////

  EnrollModel? enrollModel;
  void addActivity({String? categoryID, String? activityID}) {
    emit(AddActivityLoadingState());
    DioHelper.postData(
      query: {'lang': lang},
      url: '$Categories/$categoryID/$Activities/$activityID/$Enroll',
      token: token,
    ).then((value) {
      enrollModel = EnrollModel.fromJson(value.data);
      getProfileData();
      emit(AddActivitySuccessState(enrollModel!));
    }).catchError((error) {
      if (error is DioError) if (error.response!.statusCode == 401) {
        errorModel = ErrorModel.fromJson(error.response!.data);
      }
      emit(AddActivityErrorState());
      print(error.toString());
    });
  }

/////////////////////////////////////////////////////////////////////

  EnrollModel? cancelModel;
  void cancelActivity({String? categoryID, String? activityID}) {
    emit(CancelActivityLoadingState());
    DioHelper.postData(
      url: '$Categories/$categoryID/$Activities/$activityID/$Cancel',
      token: token,
        query: {'lang': lang}
    ).then((value) {
      cancelModel = EnrollModel.fromJson(value.data);
      getProfileData();
      emit(CancelActivitySuccessState(cancelModel!));
    }).catchError((error) {
      emit(CancelActivityErrorState());
      print(error.toString());
    });
  }

/////////////////////////////////////////////////////////////////////

  EnrollModel? updateUserModel;
  void updateProfileData({
    required String name,
    required String? image,
    required String code,
    required String phone,
    required String specialization_ar,
    required String specialization_en,
  }) {
    emit(UpdateProfileLoadingState());
    DioHelper.putData(
        query: {'lang': lang},
        url: UpdateProfile, token: token, data: {
      'fullName': name,
      'image': image ?? profileModel!.student!.image,
      'code': code,
      'phone': phone,
      'Specialization_ar': specialization_ar,
      'Specialization_en': specialization_en
    }).then((value) {
      updateUserModel = EnrollModel.fromJson(value.data);
      getProfileData();
      emit(UpdateProfileSuccessState(updateUserModel!));
    }).catchError((error) {
      emit(UpdateProfileErrorState());
      print(error.toString());
    });
  }

  /////////////////////////////////////////////////////////////////////

  File? file;
  String? imageName;
  Future uploadPhoto() async {
    final myfile = await ImagePicker().getImage(source: ImageSource.gallery);
    file = File(myfile!.path);
    imageName = file!.path.split(':').last;
    emit(UploadPhotoState());
  }

/////////////////////////////////////////////////////////////////////

  EnrollModel? passwordModel;
  void updatePassword(
      {required context,
      required String oldPass,
      required String newPass}) async {
    emit(ChangePassLoadingState());
    DioHelper.putData(url: UpdatePass, token: token, data: {
      'oldPassword': oldPass,
      'newPassword': newPass,
    },
        query: {'lang': lang}
    ).then((value) {
      passwordModel = EnrollModel.fromJson(value.data);
      emit(ChangePassSuccessState(passwordModel!));
    }).catchError((error) {
      if (error is DioError) if (error.response!.statusCode == 401) {
        errorModel = ErrorModel.fromJson(error.response!.data);
      }
      emit(ChangePassErrorState());
      print(error.toString());
    });
  }

  bool show = false;
  String passButton = CacheHelper.getData('lang') == 'en'
      ? 'Change Password'
      : 'تغيير كلمة المرور';
  void changePassword(context) {
    show = !show;
    if (show == false) {
      passButton = getLang(context, 'editProfileChangePasswordButton');
    } else {
      passButton = getLang(context, 'editProfileChangeSavePassword');
    }
    emit(ChangePassState());
  }

  bool showOldPassword = true;
  IconData suffixIconOld = Icons.visibility;
  void changeSuffixIcon_Old(context) {
    showOldPassword = !showOldPassword;
    if (showOldPassword == false) {
      suffixIconOld = Icons.visibility_off;
    } else {
      suffixIconOld = Icons.visibility;
    }
    emit(ChangeSuffixIconState());
  }

  bool showNewPassword = true;
  IconData SuffixIconNew = Icons.visibility;
  void changeSuffixIcon_New(context) {
    showNewPassword = !showNewPassword;
    if (showNewPassword == false) {
      SuffixIconNew = Icons.visibility_off;
    } else {
      SuffixIconNew = Icons.visibility;
    }
    emit(ChangeSuffixIconState());
  }

  bool showConfirmNewPassword = true;
  IconData confirmSuffixIconNew = Icons.visibility;
  void changeConfirmSuffixIcon_New(context) {
    showConfirmNewPassword = !showConfirmNewPassword;
    if (showConfirmNewPassword == false) {
      confirmSuffixIconNew = Icons.visibility_off;
    } else {
      confirmSuffixIconNew = Icons.visibility;
    }
    emit(ChangeSuffixIconState());
  }

/////////////////////////////////////////////////////////////////////

  EnrollModel? rateModel;
  void setRate({String? categoryID, String? activityID, double? rate}) {
    emit(RateLoadingState());
    DioHelper.postData(
        query: {'lang': lang},
        url: '$Categories/$categoryID/$Activities/$activityID/$Rate',
        token: token,
        data: {'rate': rate ?? Rating}).then((value) {
      rateModel = EnrollModel.fromJson(value.data);
      emit(RateSuccessState(rateModel!));
    }).catchError((error) {
      if (error is DioError) if (error.response!.statusCode == 401 || error.response!.statusCode == 400 || error.response!.statusCode == 404) {
        errorModel = ErrorModel.fromJson(error.response!.data);
      }

      emit(RateErrorState());
      print(error.toString());
    });
  }

  /////////////////////////////////////////////////////////////////////


  //language
  late String currentValue;
  checkCurrentValue() {
    if (CacheHelper.getData('lang') == 'en') {
      currentValue = 'English';
    } else {
      currentValue = 'العربية';
    }
  }

  changelanguage(newValue) {
    currentValue = newValue;
    if (currentValue == 'English') {
      CacheHelper.saveData(key: 'lang', value: 'en');
    } else {
      CacheHelper.saveData(key: 'lang', value: 'ar');
    }
    lang = CacheHelper.getData('lang');
    passButton = CacheHelper.getData('lang') == 'en'
        ? 'Change Password'
        : 'تغيير كلمة المرور';
    getHomeData();
    getCategoryData();
    getProfileData();
    getTripsData();
    emit(ChangeLanguage());
  }


/////////////////////////////////////////////////////////////////////

TripsModel? tripsModel;
void getTripsData() {

  emit(TripsLoadingState());
  DioHelper.getData(
    query: {'lang': lang},
    url: Trips,
  ).then((value) {
    tripsModel = TripsModel.fromJson(value.data);
    emit(TripsSuccessState());

  }).catchError((error) {
    emit(TripsErrorState());
    print(error.toString());
  });
}

/////////////////////////////////////////////////////////////////////

EnrollModel? setEmailModel;
  void setEmail({String? email}) {
    emit(SetEmailLoadingState());
    DioHelper.postData(
        query: {'lang': lang},
        url: SetEmailEnd,
        data: {'email': email}).then((value) {
      setEmailModel = EnrollModel.fromJson(value.data);
      emit(SetEmailSuccessState(setEmailModel!));
    }).catchError((error) {
      if (error is DioError)
        if (error.response!.statusCode == 401 || error.response!.statusCode == 400  || error.response!.statusCode == 404) {
        errorModel = ErrorModel.fromJson(error.response!.data);
      }
      emit(SetEmailErrorState());
      print(error.toString());
    });
  }

/////////////////////////////////////////////////////////////////////

  EnrollModel? restPassModel;
  void restPass({String? code,String? pass,String? email}) {
    emit(RestLoadingState());
    DioHelper.postData(
        query: {'lang': lang},
        url: RestPass,
        data: {'email': email,'code': code,'password': pass}).then((value) {
      restPassModel = EnrollModel.fromJson(value.data);
      emit(RestSuccessState(restPassModel!));
    }).catchError((error) {
      if (error is DioError)
        if (error.response!.statusCode == 401 || error.response!.statusCode == 400  || error.response!.statusCode == 404) {
          errorModel = ErrorModel.fromJson(error.response!.data);
        }
      emit(RestErrorState());
      print(error.toString());
    });
  }

  /////////////////////////////////////////////////////////////////////

  EnrollModel? enrollTripModel;
  void addTrip({String? token,String? tripID}) {
    emit(AddTripLoadingState());
    DioHelper.postData(
        query: {'lang': lang},
        url: '$Trips/$tripID/$EnrollTrip',
      token: token
        ).then((value) {
      enrollTripModel = EnrollModel.fromJson(value.data);
      getProfileData();
      emit(AddTripSuccessState(enrollTripModel!));
    }).catchError((error) {
      if (error is DioError)
        if (error.response!.statusCode == 401 || error.response!.statusCode == 400  || error.response!.statusCode == 404) {
          errorModel = ErrorModel.fromJson(error.response!.data);
        }
      emit(AddTripErrorState());
      print(error.toString());
    });
  }

  /////////////////////////////////////////////////////////////////////

  EnrollModel? contantModel;
  void setContant({String? token,String? message}) {
    emit(ContantLoadingState());
    DioHelper.postData(
        query: {'lang': lang},
        url: Contact,
        token: token,
      data: {'message':message}
    ).then((value) {
      contantModel = EnrollModel.fromJson(value.data);
      emit(ContantSuccessState(contantModel!));
    }).catchError((error) {
      if (error is DioError)
        if (error.response!.statusCode == 401 || error.response!.statusCode == 400  || error.response!.statusCode == 404) {
          errorModel = ErrorModel.fromJson(error.response!.data);
        }
      emit(ContantErrorState());
      print(error.toString());
    });
  }
}