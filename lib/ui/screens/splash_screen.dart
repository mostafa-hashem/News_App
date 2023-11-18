import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/auth/cubit/auth_cubit.dart';
import 'package:news_app/features/profile/cubit/profile_cubit.dart';
import 'package:news_app/features/profile/cubit/profile_state.dart';
import 'package:news_app/route_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen();

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  TextEditingController idController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController secondNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (AuthCubit.get(context).isLoggedIn) {
      ProfileCubit.get(context).getUser();
    } else {
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushReplacementNamed(context, Routes.login);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (_, state) {
        if (state is GetUserSuccess) {
          Navigator.pushReplacementNamed(context, Routes.layout);
        }
      },
      child: Scaffold(
        body: Center(
          child: Image.asset("assets/images/logo.png"),
        ),
      ),
    );
  }
}
