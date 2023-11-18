import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/features/auth/cubit/auth_cubit.dart';
import 'package:news_app/features/auth/cubit/auth_state.dart';
import 'package:news_app/features/auth/data/models/login_data.dart';
import 'package:news_app/features/profile/cubit/profile_cubit.dart';
import 'package:news_app/features/profile/cubit/profile_state.dart';
import 'package:news_app/route_manager.dart';
import 'package:news_app/ui/resources/app_colors.dart';
import 'package:news_app/ui/resources/text_styles.dart';
import 'package:news_app/ui/widgets/default_form_field.dart';
import 'package:news_app/ui/widgets/default_password_form_filed.dart';
import 'package:news_app/ui/widgets/default_text_button.dart';
import 'package:news_app/ui/widgets/loading_indicator.dart';
import 'package:news_app/utils/helper_methods.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen();

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authCubit = AuthCubit.get(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: 16.0.w,
            right: 16.w,
            bottom: MediaQuery.of(context).viewInsets.bottom * 1.1,
          ),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100.h,
                ),
                Align(
                  child: Image.asset("assets/images/logo.png"),
                ),
                SizedBox(
                  height: 90.h,
                ),
                Text(
                  "Login",
                  style: openSans24W600(color: AppColors.primary),
                ),
                SizedBox(
                  height: 13.h,
                ),
                DefaultFormField(
                  controller: emailController,
                  type: TextInputType.emailAddress,
                  validate: validateEmail,
                  label: "E-mail",
                ),
                SizedBox(
                  height: 32.h,
                ),
                DefaultPasswordFormField(
                  controller: passwordController,
                  validate: validatePassword,
                  label: "Password",
                ),
                SizedBox(
                  height: 8.h,
                ),
                GestureDetector(
                  onTap: () =>
                      Navigator.pushNamed(context, Routes.resetPassword),
                  child: Row(
                    children: [
                      const Icon(Icons.check_box_outline_blank),
                      SizedBox(
                        width: 8.w,
                      ),
                      const Text(
                        "Forget password",
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 31.h,
                ),
                MultiBlocListener(
                  listeners: [
                    BlocListener<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is AuthLoading) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const LoadingIndicator();
                            },
                          );
                        } else {
                          Navigator.of(context).pop();
                          if (state is AuthSuccess) {
                            ProfileCubit.get(context).getUser();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Successfully login",
                                  style: TextStyle(fontSize: 15),
                                ),
                                backgroundColor: AppColors.primary,
                                duration: Duration(seconds: 3),
                              ),
                            );
                          } else if (state is AuthError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                               SnackBar(
                                content: Text(
                                  state.message,
                                  style: const TextStyle(fontSize: 15),
                                ),
                                backgroundColor: AppColors.error,
                                duration: const Duration(seconds: 3),
                              ),
                            );
                          }
                        }
                      },
                    ),
                    BlocListener<ProfileCubit, ProfileState>(
                      listener: (context, state) {
                        if (state is GetUserSuccess) {
                          Navigator.pushReplacementNamed(
                            context,
                            Routes.layout,
                          );
                        }
                      },
                    ),
                  ],
                  child: DefaultTextButton(
                    function: () {
                      if (formKey.currentState!.validate()) {
                        authCubit.login(
                          LoginData(
                            email: emailController.text,
                            password: passwordController.text,
                          ),
                        );
                      }
                    },
                    text: "Login",
                    textStyle: openSans14W500(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don’t have an Account?",
                      style: openSans12W400(color: Colors.black),
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                          context,
                          Routes.register,
                        );
                      },
                      child: Text(
                        "Create Account",
                        style: openSans12W400(color: const Color(0xFF22C7B6)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
