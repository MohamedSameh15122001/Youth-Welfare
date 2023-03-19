import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thebes_academy/modules/register.dart';

import '../cubit/appCubit.dart';
import '../cubit/states.dart';
import '../remoteNetwork/cacheHelper.dart';
import '../shared/component.dart';
import '../shared/constants.dart';


TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
var loginFormKey = GlobalKey<FormState>();

class Login extends StatelessWidget {
  const Login({super.key});



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates> (
      listener: (context,state) {
        if(state is LoginSuccessState)
           {
             CacheHelper.saveData(
                key: 'token',
                value: state.loginModel!.token
            ).then((value) {
              showToast(text: '${state.loginModel.message}', state: ToastStates.SUCCESS);
              Navigator.pop(context);
              token = state.loginModel.token;
              emailController.clear();
              passwordController.clear();
            });
          }

        if(state is LoginErrorState){
          showToast(text: 'incorrect email or password', state: ToastStates.ERROR);
        }
      },
      builder:(context,state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: defaultColor,
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
                          duration: Duration(milliseconds: 600),
                          childAnimationBuilder: (widget) => SlideAnimation(
                            horizontalOffset: 50.0,
                            child: FadeInAnimation(
                              child: widget,
                            ),
                          ),
                          children: [

                            const SizedBox(height: 20,),
                            Text('Ahlan! Welcome back!',style: GoogleFonts.poppins(fontSize: 25,fontWeight: FontWeight.bold,color: defaultColor),),
                            const SizedBox(height: 30,),
                            defaultFormField(
                                context: context,
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                label: 'Email Address',
                                prefix: Icons.email,
                                validate: (value)
                                {
                                  if(value!.isEmpty)
                                    return 'Email Address must be filled';
                                }
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            defaultFormField(
                                context: context,
                                controller: passwordController,
                                label: 'Password',
                                prefix: Icons.lock,
                                isPassword: AppCubit.get(context).showPassword,
                                validate: (value)
                                {
                                  if(value!.isEmpty)
                                    return'Password must be filled';
                                },
                                onSubmit: (value)
                                {
                                  if (loginFormKey.currentState!.validate()) {
                                    AppCubit.get(context).signIn(
                                        email: emailController.text,
                                        password: passwordController.text);
                                  }
                                },
                                suffix: AppCubit.get(context).suffixIcon,
                                suffixPressed: ()
                                {
                                  AppCubit.get(context).changeSuffixIcon(context);
                                }
                            ),
                            Container(
                              width: double.infinity,
                              alignment: AlignmentDirectional.centerStart,
                              child: TextButton(
                                  onPressed: (){},
                                  child: Text('Forget Your Password ?',
                                    style: TextStyle(
                                        color: defaultColor),
                                  )
                              ),
                            ),
                            const SizedBox(height: 25,),
                            state is LoginLoadingState ?
                            Center(child: CircularProgressIndicator(
                              color: defaultColor,
                            ))
                                :
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: MaterialButton(
                                onPressed: () {
                                  if (loginFormKey.currentState!.validate()) {
                                    AppCubit.get(context).signIn(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                    // token = CacheHelper.getData('token');
                                  };
                                },
                                minWidth: MediaQuery.of(context).size.width,
                                height: 50,
                                color: defaultColor,
                                child:  Text(
                                    'LOGIN',
                                    style: GoogleFonts.poppins( color: Colors.white,
                                      fontSize: 20,)
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                    'Don\'t have an account?'
                                ),
                                TextButton(
                                    onPressed: () {
                                      navigateTo(context, const Register());
                                    },
                                    child:  Text('Register Now',style: TextStyle(color: defaultColor),)
                                ),
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
        ) ;
      } ,
    );
  }
}
