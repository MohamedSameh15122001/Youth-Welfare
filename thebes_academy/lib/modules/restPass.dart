import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thebes_academy/modules/Login.dart';
import 'package:thebes_academy/shared/applocale.dart';
import 'package:thebes_academy/shared/constants.dart';

import '../cubit/appCubit.dart';
import '../cubit/states.dart';
import '../shared/component.dart';

TextEditingController password = TextEditingController();
TextEditingController code = TextEditingController();
TextEditingController confirmPassword = TextEditingController();


var FormKey = GlobalKey<FormState>();

class RestPass extends StatelessWidget {
String email;
RestPass(this.email);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is RestSuccessState)
          {
            showToast(text: '${AppCubit.get(context).restPassModel!.message}', state: ToastStates.SUCCESS);
            Navigator.pop(context);
            code.clear();
            password.clear();
            confirmPassword.clear();
          }

          if (state is RestErrorState)
          {
            showToast(
                text: '${AppCubit.get(context).errorModel!.message}',
                state: ToastStates.ERROR);
          }
    },
        builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: () {
            Navigator.pop(context);
            code.clear();
            password.clear();
            confirmPassword.clear();
            }, icon: Icon(Icons.arrow_back),),
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
          child: SizedBox(
            height: MediaQuery.of(context).size.height * .7,
            child: Form(
              key: FormKey,
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
                          getLang(context, 'rest password'),
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
                            keyboardType: TextInputType.number,
                            controller: code,
                            label: getLang(context, 'registerID'),
                            prefix: Icons.code,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return getLang(context, 'registerCodeMustFilled')
                                as String;
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
                        state is RestLoadingState
                            ? const Center(child: CircularProgressIndicator())
                            : ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: MaterialButton(
                            onPressed: () {
                              if (FormKey.currentState!.validate()) {
                                AppCubit.get(context).restPass(code: code.text,pass: password.text,email:email );
                              }
                            },
                            minWidth: MediaQuery.of(context).size.width,
                            height: 50,
                            color: primaryColor,
                            child:
                            Text(getLang(context, 'Password Register'),
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
        ),
      );
    });
  }
}
