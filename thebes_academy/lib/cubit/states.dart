import 'package:thebes_academy/models/enrollModel.dart';

import '../models/loginModel.dart';
import '../models/registerModel.dart';

abstract class AppStates {}

///General States
class InitialState extends AppStates {}

class ChangeDropDownState extends AppStates {}

class ChangeSuffixIconState extends AppStates {}

class RemoveTokenState extends AppStates {}

class CheckInternetState extends AppStates {}

class ChangePassState extends AppStates {}

class UploadPhotoState extends AppStates {}

///End of General states

///Login State
class LoginLoadingState extends AppStates {}

class LoginSuccessState extends AppStates {
  final LoginModel loginModel;
  LoginSuccessState(this.loginModel);
}

class LoginErrorState extends AppStates {}

///End of Login State

//FCM State

///SignUp State
class SignUpLoadingState extends AppStates {}

class SignUpSuccessState extends AppStates {
  final RegisterModel registerModel;
  SignUpSuccessState(this.registerModel);
}

class SignUpErrorState extends AppStates {}

///Home State
class HomeLoadingState extends AppStates {}

class HomeSuccessState extends AppStates {}

class HomeErrorState extends AppStates {}

///End of Home State

///Categories State
class CategoriesLoadingState extends AppStates {}

class CategoriesSuccessState extends AppStates {}

class CategoriesErrorState extends AppStates {}

///End of Categories State

///Activities State
class ActivitiesLoadingState extends AppStates {}

class ActivitiesSuccessState extends AppStates {}

class ActivitiesErrorState extends AppStates {}

///End of Activities State

///CategoriesDetails State
class CategoryDetailsLoadingState extends AppStates {}

class CategoryDetailsSuccessState extends AppStates {}

class CategoryDetailsErrorState extends AppStates {}

///End of CategoriesDetails State

///ActivitiesDetails State
class ActivitiesDetailsLoadingState extends AppStates {}

class ActivitiesDetailsSuccessState extends AppStates {}

class ActivitiesDetailsErrorState extends AppStates {}

///End of ActivitiesDetails State

///Profile State
class ProfileLoadingState extends AppStates {}

class ProfileSuccessState extends AppStates {}

class ProfileErrorState extends AppStates {}

///End of Profile State

///Update Profile State
class UpdateProfileLoadingState extends AppStates {}

class UpdateProfileSuccessState extends AppStates {
  final EnrollModel updateUserModel;
  UpdateProfileSuccessState(this.updateUserModel);
}

class UpdateProfileErrorState extends AppStates {}

///End of Update Profile State

///ChangePassword State
class ChangePassLoadingState extends AppStates {}

class ChangePassSuccessState extends AppStates {
  final EnrollModel passUserModel;
  ChangePassSuccessState(this.passUserModel);
}

class ChangePassErrorState extends AppStates {}

///End of ChangePassword State

///Notification State
class NotificationLoadingState extends AppStates {}

class NotificationSuccessState extends AppStates {}

class NotificationErrorState extends AppStates {}

///End of Notification State

///Add Activity State
class AddActivityLoadingState extends AppStates {}

class AddActivitySuccessState extends AppStates {
  final EnrollModel enrollModel;
  AddActivitySuccessState(this.enrollModel);
}

class AddActivityErrorState extends AppStates {}

///End of Add Activity State

///Cancel Activity State
class CancelActivityLoadingState extends AppStates {}

class CancelActivitySuccessState extends AppStates {
  final EnrollModel cancelModel;
  CancelActivitySuccessState(this.cancelModel);
}

class CancelActivityErrorState extends AppStates {}

///End of Cancel Activity State

///Rate State
class RateLoadingState extends AppStates {}

class RateSuccessState extends AppStates {
  final EnrollModel rateModel;
  RateSuccessState(this.rateModel);
}

class RateErrorState extends AppStates {}

///End of Rate State

///Trips State
class TripsLoadingState extends AppStates {}

class TripsSuccessState extends AppStates {}

class TripsErrorState extends AppStates {}

///End of Trips State

///Rest State
class SetEmailLoadingState extends AppStates {}

class SetEmailSuccessState extends AppStates {
  final EnrollModel setEmailModel;
  SetEmailSuccessState(this.setEmailModel);
}

class SetEmailErrorState extends AppStates {}

///End of Rest State


///Rest State
class RestLoadingState extends AppStates {}

class RestSuccessState extends AppStates {
  final EnrollModel restPassModel;
  RestSuccessState(this.restPassModel);
}

class RestErrorState extends AppStates {}

///End of Rest State

///change language
class ChangeLanguage extends AppStates {}
