import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/features/auth/cubit/auth_cubit.dart';
import 'package:news_app/features/auth/cubit/auth_state.dart';
import 'package:news_app/ui/resources/app_colors.dart';
import 'package:news_app/ui/resources/text_styles.dart';
import 'package:news_app/ui/widgets/default_form_field.dart';
import 'package:news_app/ui/widgets/default_text_button.dart';
import 'package:news_app/utils/helper_methods.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen();

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final resetPassword = AuthCubit.get(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              top: 73.h,
              bottom: MediaQuery.of(context).viewInsets.bottom * 1.1,
              left: 16.w,
              right: 16.w),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 44.w,
                    height: 42.h,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11.76.r),
                      ),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x23EA6A58),
                          blurRadius: 20,
                          offset: Offset(0, 4.41),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: Colors.black,
                    ),
                  ),
                ),
                Align(
                  child: Image.asset("assets/images/logo.png"),
                ),
                SizedBox(
                  height: 70.h,
                ),
                Text(
                  "Reset Password",
                  style: openSans24W600(color: AppColors.primary),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  "please enter your mail address to resets your password",
                  style: openSans16W400(
                    color: const Color(0xff1A1A1A).withOpacity(0.6),
                  ).copyWith(
                    letterSpacing: -0.41,
                  ),
                ),
                SizedBox(
                  height: 37.h,
                ),
                DefaultFormField(
                  controller: emailController,
                  type: TextInputType.emailAddress,
                  validate: validateEmail,
                  label: "Email",
                ),
                SizedBox(
                  height: 31.h,
                ),
                BlocListener<AuthCubit, AuthState>(
                  listener: (_, state) {
                    if (state is PasswordResetRequestSent) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'A password reset code has been sent to your email.',
                          ),
                        ),
                      );
                    }
                  },
                  child: DefaultTextButton(
                    function: () {
                      resetPassword.requestPasswordReset(emailController.text);
                    },
                    text: "Send",
                    textStyle: openSans14W500(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
