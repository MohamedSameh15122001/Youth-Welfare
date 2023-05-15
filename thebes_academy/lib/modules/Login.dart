import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thebes_academy/layouts/layout.dart';
import 'package:thebes_academy/modules/register.dart';
import 'package:thebes_academy/modules/restPass.dart';
import 'package:thebes_academy/shared/applocale.dart';

import '../cubit/appCubit.dart';
import '../cubit/states.dart';
import '../remoteNetwork/cacheHelper.dart';
import '../shared/component.dart';
import '../shared/constants.dart';

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController emailController2 = TextEditingController();

var loginFormKey = GlobalKey<FormState>();
var dialogKey = GlobalKey<FormState>();

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          CacheHelper.saveData(key: 'token', value: state.loginModel.token)
              .then((value) {
            token = state.loginModel.token;
            showToast(
                text: '${state.loginModel.message}',
                state: ToastStates.SUCCESS);
            AppCubit.get(context).getProfileData();
            navigateAndKill(context, const Layout());
            token = state.loginModel.token;
            emailController.clear();
            passwordController.clear();
          });
        }

        if (state is LoginErrorState) {
          showToast(
              text: '${AppCubit.get(context).errorModel!.message}',
              state: ToastStates.ERROR);
        }

        if (state is SetEmailSuccessState) {
          showToast(
              text: '${AppCubit.get(context).setEmailModel!.message}',
              state: ToastStates.SUCCESS);
          Navigator.pop(context);
          navigateTo(context, RestPass(emailController2.text));
          emailController2.clear();
        }

        if (state is SetEmailErrorState) {
          showToast(
              text: '${AppCubit.get(context).errorModel!.message}',
              state: ToastStates.ERROR);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                navigateAndKill(context, const Layout());
              },
              icon: const Icon(Icons.arrow_back),
            ),
            backgroundColor: primaryColor,
            centerTitle: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(getLang(context, "layoutTitle2"),
                    style: GoogleFonts.poppins()),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    width: 50,
                    'lib/assets/images/logo.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                Text(getLang(context, "layoutTitle1"),
                    style: GoogleFonts.poppins()),
                if (lang == 'ar')
                  const SizedBox(
                    width: 76,
                  ),
                if (lang == 'en')
                  const SizedBox(
                    width: 30,
                  ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * .7,
                  child: Form(
                    key: loginFormKey,
                    child: AnimationLimiter(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: AnimationConfiguration.toStaggeredList(
                          duration: const Duration(milliseconds: 600),
                          childAnimationBuilder: (widget) => SlideAnimation(
                            horizontalOffset: 50.0,
                            child: FadeInAnimation(
                              child: widget,
                            ),
                          ),
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              getLang(context, 'loginAhlan'),
                              style: GoogleFonts.poppins(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            defaultFormField(
                                context: context,
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                label: getLang(context, 'loginEmail'),
                                prefix: Icons.email,
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return getLang(
                                            context, 'loginEmailMustFilled')
                                        as String;
                                  } else if (isValidEmail(value.toString()) ==
                                      false) {
                                    return getLang(
                                            context, 'The email is incorrect')
                                        as String;
                                  }
                                }),
                            const SizedBox(
                              height: 40,
                            ),
                            defaultFormField(
                                context: context,
                                controller: passwordController,
                                label: getLang(context, 'loginPassword'),
                                prefix: Icons.lock,
                                isPassword: AppCubit.get(context).showPassword,
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return getLang(
                                            context, 'loginPasswordMustFilled')
                                        as String;
                                  } else if (isValidPass(value) == false) {
                                    return getLang(context, 'Invalid password')
                                        as String;
                                  }
                                },
                                onSubmit: (value) {
                                  if (loginFormKey.currentState!.validate()) {
                                    AppCubit.get(context).signIn(
                                        email: emailController.text,
                                        password: passwordController.text);
                                  }
                                },
                                suffix: AppCubit.get(context).suffixIcon,
                                suffixPressed: () {
                                  AppCubit.get(context)
                                      .changeSuffixIcon(context);
                                }),
                            Container(
                              width: double.infinity,
                              alignment: AlignmentDirectional.centerStart,
                              child: TextButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) => Form(
                                              key: dialogKey,
                                              child: AlertDialog(
                                                insetPadding: EdgeInsets.zero,
                                                contentPadding:
                                                    const EdgeInsets.all(30),
                                                title: Text(
                                                  getLang(context,
                                                      'Enter your email'),
                                                  style: GoogleFonts.poppins(
                                                      color: primaryColor,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                content: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    defaultFormField(
                                                        context: context,
                                                        controller:
                                                            emailController2,
                                                        keyboardType:
                                                            TextInputType
                                                                .emailAddress,
                                                        label: getLang(context,
                                                            'loginEmail'),
                                                        prefix: Icons.email,
                                                        validate: (value) {
                                                          if (value!.isEmpty) {
                                                            return getLang(
                                                                    context,
                                                                    'loginEmailMustFilled')
                                                                as String;
                                                          } else if (isValidEmail(
                                                                  value
                                                                      .toString()) ==
                                                              false) {
                                                            return getLang(
                                                                    context,
                                                                    'The email is incorrect')
                                                                as String;
                                                          }
                                                        }),
                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        OutlinedButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                              emailController2
                                                                  .clear();
                                                            },
                                                            child: Text(
                                                                getLang(context,
                                                                    'activityRateCancelButton'),
                                                                style: GoogleFonts.poppins(
                                                                    color:
                                                                        primaryColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500))),
                                                        OutlinedButton(
                                                            onPressed: () {
                                                              if (dialogKey
                                                                  .currentState!
                                                                  .validate()) {
                                                                AppCubit.get(
                                                                        context)
                                                                    .setEmail(
                                                                        email: emailController2
                                                                            .text);
                                                              }
                                                            },
                                                            child: Text(
                                                                getLang(context,
                                                                    'activityRateDoneButton'),
                                                                style: GoogleFonts.poppins(
                                                                    color:
                                                                        primaryColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500)))
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ));
                                  },
                                  child: Text(
                                    getLang(context, 'loginForgetPassword'),
                                    style: const TextStyle(color: primaryColor),
                                  )),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            state is LoginLoadingState
                                ? const Center(
                                    child: CircularProgressIndicator(
                                    color: primaryColor,
                                  ))
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: MaterialButton(
                                      onPressed: () {
                                        if (loginFormKey.currentState!
                                            .validate()) {
                                          AppCubit.get(context).signIn(
                                            email: emailController.text,
                                            password: passwordController.text,
                                          );
                                          // token = CacheHelper.getData('token');
                                        }
                                      },
                                      minWidth:
                                          MediaQuery.of(context).size.width,
                                      height: 50,
                                      color: primaryColor,
                                      child: Text(
                                          getLang(context, 'loginSendButton'),
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontSize: 20,
                                          )),
                                    ),
                                  ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(getLang(context, 'loginNotAMember')),
                                TextButton(
                                    onPressed: () {
                                      navigateTo(context, const Register());
                                    },
                                    child: Text(
                                      getLang(context, 'loginRegisterNow'),
                                      style:
                                          const TextStyle(color: primaryColor),
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
