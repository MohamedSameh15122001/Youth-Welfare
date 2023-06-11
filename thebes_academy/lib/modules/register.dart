import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thebes_academy/shared/applocale.dart';
import 'package:thebes_academy/shared/constants.dart';

import '../cubit/appCubit.dart';
import '../cubit/states.dart';
import '../shared/component.dart';

TextEditingController email = TextEditingController();
TextEditingController password = TextEditingController();
TextEditingController name = TextEditingController();
TextEditingController code = TextEditingController();
TextEditingController phone = TextEditingController();
TextEditingController confirmPassword = TextEditingController();

var signUpFormKey = GlobalKey<FormState>();

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(listener: (context, state) {
      if (state is SignUpSuccessState) {
        showToast(
            text: '${state.registerModel.message}...Then login',
            state: ToastStates.WARNING,
            time: 7);
        Navigator.pop(context);
        email.clear();
        password.clear();
        code.clear();
        name.clear();
        phone.clear();
        confirmPassword.clear();
      }
      if (state is SignUpErrorState) {
        showToast(
            text: '${AppCubit.get(context).errorModel!.message}',
            state: ToastStates.ERROR);
      }
    }, builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(getLang(context, 'layoutTitle2'),
                  style: GoogleFonts.poppins()),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  width: 50,
                  'lib/assets/images/logo.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              Text(getLang(context, 'layoutTitle1'),
                  style: GoogleFonts.poppins()),
              if(lang =='ar')
                const SizedBox(
                  width: 76,
                ),
              if(lang =='en')
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
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: AnimationLimiter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: AnimationConfiguration.toStaggeredList(
                    duration: const Duration(milliseconds: 500),
                    childAnimationBuilder: (widget) => SlideAnimation(
                      horizontalOffset: 50.0,
                      child: FadeInAnimation(
                        child: widget,
                      ),
                    ),
                    children: [
                      Text(
                        getLang(context, 'registerCreateAnAccount'),
                        style: GoogleFonts.poppins(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: primaryColor),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                          context: context,
                          keyboardType: TextInputType.text,
                          controller: name,
                          label: getLang(context, 'registerFullName'),
                          prefix: Icons.person,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return getLang(context, 'registerEmailMustFilled')
                                  as String;
                            }
                            else if(value.toString().length < 4 || value.toString().length > 50){
                              return getLang(context, 'The short name') as String;
                            }

                          }),
                      const SizedBox(
                        height: 30,
                      ),
                      defaultFormField(
                          context: context,
                          keyboardType: TextInputType.number,
                          controller: code,
                          label: getLang(context, 'registerID'),
                          prefix: Icons.code,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return getLang(context, 'registerCodeMustFilled')
                                  as String;
                            }
                            else if(value.toString().length < 9 || value.toString().length > 9){
                              return getLang(context, 'The code must') as String;
                            }
                            else if(int.parse(value) < 200000000 || int.parse(value) > 209999999){
                              return getLang(context, 'code should be') as String;
                            }
                          }),
                      const SizedBox(
                        height: 30,
                      ),
                      defaultFormField(
                          context: context,
                          controller: phone,
                          label: getLang(context, 'registerPhoneNumber'),
                          keyboardType: TextInputType.phone,
                          prefix: Icons.phone,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return getLang(context, 'registerPhoneMustFilled')
                                  as String;
                            }
                          }),
                      const SizedBox(
                        height: 30,
                      ),
                      defaultFormField(
                          context: context,
                          controller: email,
                          keyboardType: TextInputType.emailAddress,
                          label: getLang(context, 'registerEmail'),
                          prefix: Icons.email,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return getLang(context, 'registerEmailMustFilled')
                                  as String;
                            }
                            else if(isValidEmail(value.toString()) == false ){
                              return getLang(context, 'The email is incorrect') as String;
                            }
                          }),
                      const SizedBox(
                        height: 30,
                      ),
                      defaultFormField(
                          context: context,
                          controller: password,
                          label: getLang(context, 'registerPassword'),
                          prefix: Icons.lock,
                          isPassword: AppCubit.get(context).showPasswordR,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return getLang(
                                      context, 'registerPasswordMustFilled')
                                  as String;
                            }
                            else if(isValidPass(value) == false){
                              return getLang(context, 'Invalid password') as String;
                            }
                          },
                          onSubmit: (value) {},
                          suffix: AppCubit.get(context).suffixIconR,
                          suffixPressed: () {
                            AppCubit.get(context).changeSuffixIconR(context);
                          }),
                      const SizedBox(
                        height: 30,
                      ),
                      defaultFormField(
                          context: context,
                          controller: confirmPassword,
                          label: getLang(context, 'registerConfirmPassword'),
                          prefix: Icons.lock,
                          isPassword:
                              AppCubit.get(context).showConfirmPasswordR,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return getLang(context,
                                      'registerConfirmPasswordMustFilled')
                                  as String;
                            } else if (value != password.text) {
                              return getLang(context,
                                      'registerConfirmPasswordMatchMustFilled')
                                  as String;
                            }
                          },
                          suffix: AppCubit.get(context).confirmSuffixIconR,
                          suffixPressed: () {
                            AppCubit.get(context)
                                .changeConfirmSuffixIconR(context);
                          }),
                      const SizedBox(
                        height: 30,
                      ),
                      ListTile(
                        onTap: () {},
                        leading: const Icon(
                          Icons.bookmark_added_rounded,
                        ),
                        title: Row(
                          children: [
                            Text(
                              getLang(context, 'registerSpecialization'),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            const Spacer(),
                            // const SizedBox(width: 50),
                            DropdownButton(
                              items: items.map((valueItem) {
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
                                specialization = newValue!;
                                AppCubit.get(context)
                                    .emit(ChangeDropDownState());
                              },
                              value: specialization,
                              underline: const SizedBox(),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      state is SignUpLoadingState
                          ? const Center(child: CircularProgressIndicator())
                          : ClipRRect(
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
                                      specialization: specialization,
                                      repassword:confirmPassword.text
                                    );
                                  }
                                },
                                minWidth: MediaQuery.of(context).size.width,
                                height: 50,
                                color: primaryColor,
                                child:
                                    Text(getLang(context, 'registerSendButton'),
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 20,
                                        )),
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
    });
  }
}
