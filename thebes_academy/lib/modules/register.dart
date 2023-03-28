import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thebes_academy/shared/constants.dart';

import '../cubit/appCubit.dart';
import '../cubit/states.dart';
import '../shared/component.dart';
import 'Login.dart';



TextEditingController email = TextEditingController();
TextEditingController password = TextEditingController();
TextEditingController name = TextEditingController();
TextEditingController code = TextEditingController();
TextEditingController phone = TextEditingController();
TextEditingController confirmPassword = TextEditingController();
TextEditingController specialization_ar = TextEditingController();
TextEditingController specialization_en = TextEditingController();

var signUpFormKey = GlobalKey<FormState>();


class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AppCubit,AppStates>(
        listener:(context,state){
          if(state is SignUpSuccessState) {
            showToast(text: '${state.registerModel.message}...Then login',
                state: ToastStates.WARNING,
                time: 7);
            Navigator.pop(context);
            email.clear();
            password.clear();
            code.clear();
            name.clear();
            specialization_ar.clear();
            specialization_en.clear();
            phone.clear();
            confirmPassword.clear();
          }
          if(state is SignUpErrorState) {
            showToast(text: '${AppCubit.get(context).errorModel!.message}', state: ToastStates.ERROR);
          }
         },
        builder:(context,state)
        {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: primaryColor,
              centerTitle: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Thebes ', style: GoogleFonts.poppins()),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      width: 50,
                      'lib/assets/images/logo.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(' Academy', style: GoogleFonts.poppins()),
                  const SizedBox(
                    width: 30,
                  ),
                ],
              ),
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: signUpFormKey,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
                  child: AnimationLimiter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: AnimationConfiguration.toStaggeredList(
                        duration: Duration(milliseconds: 500),
                        childAnimationBuilder: (widget) => SlideAnimation(
                          horizontalOffset: 50.0,
                          child: FadeInAnimation(
                            child: widget,
                          ),
                        ),
                        children: [
                          Text('Create An Account',style: GoogleFonts.poppins(fontSize: 25,fontWeight: FontWeight.bold,color: primaryColor),),
                          const SizedBox(height: 20,),
                          defaultFormField(
                              context: context,
                              keyboardType: TextInputType.text,
                              controller: name,
                              label: 'Name',
                              prefix: Icons.person,
                              validate: (value)
                              {
                                if(value!.isEmpty) {
                                  return 'Name field is required';
                                }
                              }
                          ),
                          const SizedBox(height: 30,),
                          defaultFormField(
                              context: context,
                              keyboardType: TextInputType.number,
                              controller: code,
                              label: 'Code',
                              prefix: Icons.code,
                              validate: (value)
                              {
                                if(value!.isEmpty) {
                                  return 'Code field is required';
                                }
                              }
                          ),
                          const SizedBox(height: 30,),
                          defaultFormField(
                              context: context,
                              controller: phone,
                              label: 'Phone',
                              keyboardType: TextInputType.phone,
                              prefix: Icons.phone,
                              validate: (value)
                              {
                                if(value!.isEmpty) {
                                  return 'Phone field is required';
                                }
                              }
                          ),
                          const SizedBox(height: 30,),
                          defaultFormField(
                              context: context,
                              controller: email,
                              keyboardType: TextInputType.emailAddress,
                              label: 'Email Address',
                              prefix: Icons.email,
                              validate: (value)
                              {
                                if(value!.isEmpty) {
                                  return 'Email Address must be filled';
                                }
                              }
                          ),
                          const SizedBox(height: 30,),
                          defaultFormField(
                              context: context,
                              controller: password,
                              label: 'Password',
                              prefix: Icons.lock,
                              isPassword:AppCubit.get(context).showPasswordR,
                              validate: (value)
                              {
                                if(value!.isEmpty) {
                                  return'Password must be filled';
                                }
                              },
                              onSubmit: (value) {},
                              suffix: AppCubit.get(context).suffixIconR,
                              suffixPressed: ()
                              {
                                AppCubit.get(context).changeSuffixIconR(context);
                              }
                          ),
                          const SizedBox(height: 30,),
                          defaultFormField(
                              context: context,
                              controller: confirmPassword,
                              label: 'Confirm Password',
                              prefix: Icons.lock,
                              isPassword:AppCubit.get(context).showConfirmPasswordR,
                              validate: (value)
                              {
                                if(value!.isEmpty) {
                                  return 'Password field is required';
                                } else if(value != password.text) {
                                  return 'Password Don\'t Match';
                                }
                              },
                              suffix: AppCubit.get(context).confirmSuffixIconR,
                              suffixPressed: ()
                              {
                                AppCubit.get(context).changeConfirmSuffixIconR(context);
                              }
                          ),
                          const SizedBox(height: 30,),
                          ListTile(
                            onTap: () {},
                            leading: const Icon(
                              Icons.bookmark_added_rounded,
                            ),
                            title: Row(
                              children: [
                                const Text(
                                  'Specialization',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 50),
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
                                    specialization=newValue!;
                                    AppCubit.get(context).emit(ChangeDropDownState());
                                  },
                                  value: specialization,
                                  underline: const SizedBox(),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 30,),
                          state is SignUpLoadingState ?
                          const Center(child: CircularProgressIndicator())
                              :ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: MaterialButton(
                              onPressed: () {
                                if (signUpFormKey.currentState!.validate()) {
                                  AppCubit.get(context).signUp(
                                    email: email.text,
                                    password: password.text,
                                    fullName: name.text,
                                    code: code.text,
                                    phone: phone.text,
                                    specialization_ar: specialization,
                                    specialization_en: specialization,
                                  );

                                };
                              },
                              minWidth: MediaQuery.of(context).size.width,
                              height: 50,
                              color: primaryColor,
                              child:  Text(
                                  'REGISTER',
                                  style: GoogleFonts.poppins( color: Colors.white,
                                    fontSize: 20,)
                              ),
                            ),
                          ),
                        ],
                      ),




                    ),
                  ),
                ),
              ),
            ),
          );
        }
    );
  }
}
