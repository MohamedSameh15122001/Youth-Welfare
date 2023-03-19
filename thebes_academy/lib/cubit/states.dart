

import 'package:thebes_academy/modules/register.dart';

import '../models/loginModel.dart';
import '../models/registerModel.dart';

abstract class AppStates {}

///General States
class InitialState extends AppStates{}
class ChangeDropDownState extends AppStates{}
class ChangeSuffixIconState extends AppStates{}
class GetTokenSuccessState extends AppStates{}

///End of General states

///Login State
class LoginLoadingState extends AppStates{}
class LoginSuccessState extends AppStates{
  final LoginModel loginModel;
  LoginSuccessState(this.loginModel);
}
class LoginErrorState extends AppStates{
  final LoginModel loginModel;
  LoginErrorState(this.loginModel);
}
///End of Login State

//FCM State


///LogOut State
class LogOutLoadingState extends AppStates{}
class LogOutSuccessState extends AppStates{
  // final LogOutModel logOutUserModel;
  // LogOutSuccessState(this.logOutUserModel);
}
class LogOutErrorState extends AppStates{}
///End of LogOut State

///SignUp State
class SignUpLoadingState extends AppStates{}
class SignUpSuccessState extends AppStates{
  final RegisterModel registerModel;
  SignUpSuccessState(this.registerModel);
}
class SignUpErrorState extends AppStates{
  final RegisterModel registerModel;
  SignUpErrorState(this.registerModel);
}

///Home State
class HomeLoadingState extends AppStates{}
class HomeSuccessState extends AppStates{}
class HomeErrorState extends AppStates{}
///End of Home State




///Categories State
class CategoriesLoadingState extends AppStates{}
class CategoriesSuccessState extends AppStates{}
class CategoriesErrorState extends AppStates{}
///End of Categories State


///Activities State
class ActivitiesLoadingState extends AppStates{}
class ActivitiesSuccessState extends AppStates{}
class ActivitiesErrorState extends AppStates{}
///End of Activities State


///CategoriesDetails State
class CategoryDetailsLoadingState extends AppStates{}
class CategoryDetailsSuccessState extends AppStates{}
class CategoryDetailsErrorState extends AppStates{}
///End of CategoriesDetails State




///ActivitiesDetails State
class ActivitiesDetailsLoadingState extends AppStates{}
class ActivitiesDetailsSuccessState extends AppStates{}
class ActivitiesDetailsErrorState extends AppStates{}
///End of ActivitiesDetails State







///Profile State
class ProfileLoadingState extends AppStates{}
class ProfileSuccessState extends AppStates {}
class ProfileErrorState extends AppStates{}
///End of Profile State


///Update Profile State
class UpdateProfileLoadingState extends AppStates{}
class UpdateProfileSuccessState extends AppStates {
//   final UserModel updateUserModel;
//   UpdateProfileSuccessState(this.updateUserModel);
 }
class UpdateProfileErrorState extends AppStates{}
///End of Update Profile State

///ChangePassword State
class ChangePassLoadingState extends AppStates{}
class ChangePassSuccessState extends AppStates {
  // final UserModel passUserModel;
  // ChangePassSuccessState(this.passUserModel);
}
class ChangePassErrorState extends AppStates{}
///End of ChangePassword State

///Notification State
class NotificationLoadingState extends AppStates{}
class NotificationSuccessState extends AppStates {}
class NotificationErrorState extends AppStates{}
///End of Notification State
