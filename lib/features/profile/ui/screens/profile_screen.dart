import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/features/auth/cubit/auth_cubit.dart';
import 'package:news_app/features/auth/cubit/auth_state.dart';
import 'package:news_app/features/profile/cubit/profile_cubit.dart';
import 'package:news_app/features/profile/cubit/profile_state.dart';
import 'package:news_app/features/profile/ui/widgets/custom_profile_container.dart';
import 'package:news_app/route_manager.dart';
import 'package:news_app/ui/resources/app_colors.dart';
import 'package:news_app/ui/resources/text_styles.dart';
import 'package:news_app/ui/widgets/default_button.dart';
import 'package:news_app/ui/widgets/default_text_button.dart';
import 'package:news_app/utils/data/models/user.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen();

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

TextEditingController idNumberController = TextEditingController();
TextEditingController firstNameController = TextEditingController();
TextEditingController lastNameController = TextEditingController();
TextEditingController emailController = TextEditingController();

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    final profile = ProfileCubit.get(context).user;
    firstNameController.text = profile.firstName!;
    lastNameController.text = profile.lastName!;
    emailController.text = profile.email!;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 29.h),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Text(
                  "Profile",
                  style: openSans16W500(color: const Color(0xff1E1E1E)),
                ),
                SizedBox(
                  width: 135.h,
                ),
                BlocListener<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthLoading) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      );
                    } else {
                      Navigator.pop(context);
                      if (state is LoggedOut) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Successfully logout",
                              style: TextStyle(fontSize: 15),
                            ),
                            backgroundColor: AppColors.primary,
                            duration: Duration(seconds: 3),
                          ),
                        );
                      } else if (state is AuthError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "There is an error",
                              style: TextStyle(fontSize: 15),
                            ),
                            backgroundColor: AppColors.primary,
                            duration: Duration(seconds: 3),
                          ),
                        );
                      }
                    }
                  },
                  child: DefaultButton(
                    width: 40,
                    height: 50,
                    function: () {
                      AuthCubit.get(context).logout();
                      Navigator.pushReplacementNamed(context, Routes.login);
                    },
                    icon: Icons.logout_outlined,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 22.h,
            ),
            CustomProfileContainer(
              labelText: "ID Number",
              textInputType: TextInputType.number,
              controller: idNumberController,
            ),
            SizedBox(
              height: 21.h,
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width,
              child: Row(
                children: [
                  Expanded(
                    child: CustomProfileContainer(
                      labelText: "First Name",
                      textInputType: TextInputType.name,
                      controller: firstNameController,
                    ),
                  ),
                  SizedBox(
                    width: 20.h,
                  ),
                  Expanded(
                    child: CustomProfileContainer(
                      labelText: "Last Name",
                      textInputType: TextInputType.name,
                      controller: lastNameController,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 21.h,
            ),
            CustomProfileContainer(
              labelText: "Email",
              textInputType: TextInputType.emailAddress,
              controller: emailController,
            ),
            SizedBox(
              height: 39.h,
            ),
            BlocListener<ProfileCubit, ProfileState>(
              listener: (_, state) {
                if (state is UpdateUserSuccess) {
                  ProfileCubit.get(context).getUser();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Successfully Updated",
                        style: TextStyle(fontSize: 15),
                      ),
                      backgroundColor: AppColors.primary,
                      duration: Duration(seconds: 3),
                    ),
                  );
                }
              },
              child: DefaultTextButton(
                function: () {
                  ProfileCubit.get(context).updateUser(
                    User(
                      id: ProfileCubit.get(context).user.id,
                      firstName: firstNameController.text,
                      lastName: lastNameController.text,
                      email: emailController.text,
                    ),
                  );
                },
                text: "Save changes",
              ),
            ),
            SizedBox(
              height: 110.h,
            ),
          ],
        ),
      ),
    );
  }
}
