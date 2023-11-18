import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/features/auth/cubit/auth_cubit.dart';
import 'package:news_app/features/auth/cubit/auth_state.dart';
import 'package:news_app/features/auth/data/models/register_data.dart';
import 'package:news_app/route_manager.dart';
import 'package:news_app/ui/resources/app_colors.dart';
import 'package:news_app/ui/resources/text_styles.dart';
import 'package:news_app/ui/widgets/default_form_field.dart';
import 'package:news_app/ui/widgets/default_password_form_filed.dart';
import 'package:news_app/ui/widgets/default_text_button.dart';
import 'package:news_app/ui/widgets/loading_indicator.dart';
import 'package:news_app/utils/helper_methods.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen();

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
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
                  height: 73.h,
                ),
                Align(
                  child: Image.asset("assets/images/logo.png"),
                ),
                SizedBox(
                  height: 70.h,
                ),
                Text(
                  "Create account",
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
                SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: DefaultFormField(
                          controller: firstNameController,
                          type: TextInputType.name,
                          validate: (value) =>
                              validateGeneral(value, 'First Name'),
                          label: "First Name",
                        ),
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                      Expanded(
                        child: DefaultFormField(
                          controller: lastNameController,
                          type: TextInputType.name,
                          validate: (value) =>
                              validateGeneral(value, 'Last Name'),
                          label: "Last Name",
                        ),
                      ),
                    ],
                  ),
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
                  height: 32.h,
                ),
                DefaultPasswordFormField(
                  controller: confirmPasswordController,
                  validate: validatePassword,
                  label: "Confirm Password",
                ),
                SizedBox(
                  height: 18.h,
                ),
                BlocListener<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is EmailVerifyRequestSentLoading) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const LoadingIndicator();
                        },
                      );
                    } else {
                      Navigator.pop(context);
                      if (state is EmailVerifyRequestSentSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "A verification link has been sent to your email address. Please check your email to complete the registration process.",
                              style: TextStyle(fontSize: 15),
                            ),
                            backgroundColor: AppColors.primary,
                            duration: Duration(
                              seconds: 6,
                            ), // You can adjust the duration as per your preference
                          ),
                        );
                        Navigator.pushReplacementNamed(
                          context,
                          Routes.login,
                        );
                      } else if (state is EmailVerifyRequestSentError) {
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
                  child: DefaultTextButton(
                    function: () {
                      if (passwordController.text ==
                          confirmPasswordController.text) {
                        if (formKey.currentState!.validate()) {
                          authCubit.register(
                            RegisterData(
                              email: emailController.text,
                              password: passwordController.text,
                              firstName: firstNameController.text,
                              lastName: lastNameController.text,
                            ),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Password dose not match, please try again",
                              style: TextStyle(fontSize: 15),
                            ),
                            backgroundColor: AppColors.error,
                            duration: Duration(seconds: 3),
                          ),
                        );
                      }
                    },
                    text: "Create account",
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
                      "Already have account ?",
                      style: openSans12W400(color: Colors.black),
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                          context,
                          Routes.login,
                        );
                      },
                      child: Text(
                        "login",
                        style: openSans12W400(
                          color: const Color(0xFF22C7B6),
                        ),
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
