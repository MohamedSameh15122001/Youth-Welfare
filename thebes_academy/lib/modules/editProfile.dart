import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thebes_academy/layouts/layout.dart';
import '../cubit/appCubit.dart';
import '../cubit/states.dart';
import '../shared/component.dart';
import '../shared/constants.dart';

class EditProfile extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController specializationController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController oldPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  TextEditingController confirmNewPassController = TextEditingController();

  var formkey = GlobalKey<FormState>();
  var formkeyP = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    specializationController.text = AppCubit.get(context).profileModel!.student!.specializationAr!;
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state) {
        if(state is UpdateProfileSuccessState)
          {
            showToast(text:'${state.updateUserModel.message}', state: ToastStates.SUCCESS);
            Navigator.pop(context);
          }

        if(state is ChangePassSuccessState)
        {
          showToast(text:'${state.passUserModel.message} \n You must login again', state: ToastStates.SUCCESS);
          AppCubit.get(context).changePassword();
          signOut(context);
          currentPage = 2;
          navigateAndKill(context, const Layout());
          newPassController.clear();
          oldPassController.clear();
        }

        if(state is ChangePassErrorState)
        {
          showToast(text:'${AppCubit.get(context).errorModel!.message}', state: ToastStates.ERROR);
        }
      },
      builder: (context,state)
      {
        AppCubit cubit =  AppCubit.get(context);
        nameController.text = cubit.profileModel!.student!.fullName!;
        phoneController.text = cubit.profileModel!.student!.phone!;
        codeController.text = '${cubit.profileModel!.student!.code!}';


        return  Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            centerTitle: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Thebes ',style: GoogleFonts.poppins()),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    width: 50,
                    'lib/assets/images/logo.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                Text(' Academy',style: GoogleFonts.poppins()),
                const SizedBox(width: 30,),

              ],
            ),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: AnimationLimiter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: AnimationConfiguration.toStaggeredList(
                    duration: const Duration(milliseconds: 500),
                    childAnimationBuilder: (widget) => SlideAnimation(
                      horizontalOffset: 50.0,
                      child: FadeInAnimation(
                        child: widget,
                      ),
                    ),
                    children: [
                      Form(
                        key: formkey,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children :
                            [
                              if(state is UpdateProfileLoadingState)
                                Column(
                                  children: const [
                                    LinearProgressIndicator(),
                                    SizedBox(height: 15,),
                                  ],
                                ),
                              state is UpdateProfileLoadingState ? Container(height: 21,) :  Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    height: 40,
                                    child: TextButton(
                                      // color: primaryColor,
                                      child:  Text(
                                          'SAVE',
                                          style: GoogleFonts.poppins(color: primaryColor,
                                              fontSize: 20,fontWeight: FontWeight.w500)
                                      ),
                                      onPressed: (){
                                        print('${cubit.imageName}');
                                        print('${cubit.profileModel!.student!.image}');

                                        if(formkey.currentState!.validate()) {
                                          cubit.updateProfileData(
                                              name: nameController.text,
                                              image: cubit.imageName,
                                              code: codeController.text,
                                              phone: phoneController.text,
                                              specialization_ar: specializationController
                                                  .text,
                                              specialization_en: specializationController
                                                  .text);
                                        }
                                      },

                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:  [
                                  Stack(
                                    alignment: Alignment.bottomRight,
                                    children: [
                                      CircleAvatar(
                                        radius: 60,
                                        backgroundImage: cubit.imageName==null ?
                                        FileImage(File('${cubit.profileModel!.student!.image}'))
                                            :
                                        FileImage(File('${cubit.imageName}')),

                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                            height: 22,
                                            width: 22,
                                            child: IconButton(padding:EdgeInsets.zero ,color: primaryColor, icon:const Icon(Icons.camera_alt), onPressed: () { cubit.uploadPhoto(); },)),
                                      )
                                    ],
                                  ),
                                  // MaterialButton(onPressed: (){
                                  //   cubit.uploadPhoto();
                                  // },
                                  // color: Colors.red,
                                  // )

                                ],
                              ),
                              const Text('Name',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                              defaultFormField(
                                  keyboardType: TextInputType.text,
                                  controller: nameController,
                                  context: context,
                                  prefix: Icons.person,
                                  validate: (value){
                                    if(value!.isEmpty) {
                                      return 'This field can\'t be Empty';
                                    }
                                  }
                              ),
                              const SizedBox(height: 5,),
                              const Text('Phone',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                              defaultFormField(
                                  keyboardType: TextInputType.phone,
                                  controller: phoneController,
                                  context: context,
                                  prefix: Icons.phone,
                                  validate: (value){
                                    if(value!.isEmpty) {
                                      return 'This field can\'t be Empty';
                                    }
                                  }
                              ),
                              const SizedBox(height: 5,),
                              const Text('Code',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                              defaultFormField(
                                  keyboardType: TextInputType.number,
                                  controller: codeController,
                                  context: context,
                                  prefix: Icons.code,
                                  validate: (value){
                                    if(value!.isEmpty) {
                                      return 'This field can\'t be Empty';
                                    }
                                  }
                              ),
                              const SizedBox(height: 5,),
                              Row(
                                children: [
                                  const Text('Specialization',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                  const Spacer(),
                                  DropdownButton(
                                    items: ["Computer Science", "Accounting",'Engineer','Commerce'].map((valueItem) {
                                      return DropdownMenuItem(
                                        value: valueItem,
                                        child: Text(
                                          valueItem,
                                          style: const TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      specializationController.text=newValue!;
                                      AppCubit.get(context).emit(ChangeDropDownState());
                                    },
                                    value: specializationController.text,
                                    underline: const SizedBox(),
                                  ),
                                ],
                              ),
                              const Divider(
                                thickness: 1,
                                color: Colors.grey,
                              )
                            ]
                        ),
                      ),
                      const SizedBox(height: 15,),
                      Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('SECURITY INFORMATION',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                            state is ChangePassLoadingState ?
                            Column(
                              children: const [
                                SizedBox(height: 10,),
                                LinearProgressIndicator(),
                                SizedBox(height: 10,),

                              ],
                            ):
                            OutlinedButton(
                                onPressed: (){
                                  if(cubit.show==true){
                                    if(formkeyP.currentState!.validate() ){
                                      cubit.updatePassword(context: context, oldPass: oldPassController.text, newPass: newPassController.text);
                                    }}else{
                                    cubit.changePassword();
                                  }
                                },
                                child:  Text(cubit.passButton,style: GoogleFonts.poppins(),)
                            ),
                          ],
                        ),
                      ),
                      if(cubit.show==true)
                        Form(
                          key: formkeyP,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Old Password',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                              defaultFormField(
                                  isPassword:AppCubit.get(context).showOldPassword,
                                  suffix: AppCubit.get(context).suffixIconOld,
                                  suffixPressed: ()
                                  {
                                    AppCubit.get(context).changeSuffixIcon_Old(context);
                                  },
                                  keyboardType: TextInputType.visiblePassword,
                                  controller: oldPassController,
                                  context: context,
                                  prefix: Icons.lock,
                                  validate: (value){
                                    if(value!.isEmpty) {
                                      return 'This field can\'t be Empty';
                                    }
                                  }
                              ),
                              const SizedBox(height: 5,),
                              const Text('New Password',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                              defaultFormField(
                                  isPassword:AppCubit.get(context).showNewPassword,
                                  suffix: AppCubit.get(context).SuffixIconNew,
                                  suffixPressed: ()
                                  {
                                    AppCubit.get(context).changeSuffixIcon_New(context);
                                  },
                                  keyboardType: TextInputType.visiblePassword,
                                  controller: newPassController,
                                  context: context,
                                  prefix: Icons.lock,
                                  validate: (value){
                                    if(value!.isEmpty) {
                                      return 'This field can\'t be Empty';
                                    }
                                  }
                              ),
                              const SizedBox(height: 5,),
                              const Text('Confirm New Password',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                              defaultFormField(
                                  isPassword:AppCubit.get(context).showConfirmNewPassword,
                                  suffix: AppCubit.get(context).confirmSuffixIconNew,
                                  suffixPressed: ()
                                  {
                                    AppCubit.get(context).changeConfirmSuffixIcon_New(context);
                                  },
                                  keyboardType: TextInputType.visiblePassword,
                                  controller: confirmNewPassController,
                                  context: context,
                                  prefix: Icons.lock,
                                  validate: (value){
                                    if(value!.isEmpty) {
                                      return 'This field can\'t be Empty';
                                    }
                                  }
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),


                ),
              ),
            ),
          ),
        );
      },
    );  }
}