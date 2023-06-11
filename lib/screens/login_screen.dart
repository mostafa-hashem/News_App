import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/layout/home.dart';
import 'package:news_app/screens/creat_account.dart';
import 'package:news_app/screens/widgets/animation_enum.dart';
import 'package:news_app/shared/network/firebase/firebase_functions.dart';
import 'package:news_app/shared/styles/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import '../provider/app_provider.dart';

class LoginScreen extends StatefulWidget {
  static const String routName = "LoginScreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  Artboard? riveArtboard;
  late RiveAnimationController controllerIdle;
  late RiveAnimationController controllerHandsUp;
  late RiveAnimationController controllerHandsDown;
  late RiveAnimationController controllerSuccess;
  late RiveAnimationController controllerFail;
  late RiveAnimationController controllerLookDownRight;
  late RiveAnimationController controllerLookDownLeft;

  @override
  void initState() {
    super.initState();

    controllerIdle = SimpleAnimation(AnimationEnum.idle.name);
    controllerHandsUp = SimpleAnimation(AnimationEnum.Hands_up.name);
    controllerHandsDown = SimpleAnimation(AnimationEnum.hands_down.name);
    controllerSuccess = SimpleAnimation(AnimationEnum.success.name);
    controllerFail = SimpleAnimation(AnimationEnum.fail.name);
    controllerLookDownRight =
        SimpleAnimation(AnimationEnum.Look_down_right.name);
    controllerLookDownLeft = SimpleAnimation(AnimationEnum.Look_down_left.name);

    rootBundle.load('assets/animation/login_animation.riv').then((data) async {
      final file = RiveFile.import(data);
      final artBoard = file.mainArtboard;
      artBoard.addController(controllerIdle);
      setState(() {
        riveArtboard = artBoard;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyAppProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Image.asset(
            "assets/images/login_bg.png",
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 0.06.sh,
                  ),
                  Text('News App',
                      style: GoogleFonts.novaSquare(
                        color: Colors.white,
                        fontSize: 50.sp,
                      )),
                  SizedBox(
                    height: 0.2.sh,
                  ),
                  TextFormField(
                    validator: (email) {
                      if (email!.isEmpty) {
                        return "Enter Email";
                      }
                      bool emailValid = RegExp(
                              r"^[a-zA-Z\d.a-zA-Z\d.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z\d]+\.[a-zA-Z]+")
                          .hasMatch(email);
                      if (!emailValid) {
                        return "Enter Valid Email";
                      }
                      return null;
                    },
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: AppCloros.lightColor),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide:
                            const BorderSide(color: AppCloros.lightColor),
                      ),
                      label: Text("Email",
                          style: GoogleFonts.novaSquare(
                            color: AppCloros.lightColor,
                          )),
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(
                        Icons.email,
                        color: AppCloros.lightColor,
                      ),
                      suffix: const Icon(
                        Icons.alternate_email,
                        color: AppCloros.lightColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 0.03.sh,
                  ),
                  TextFormField(
                    validator: (password) {
                      if (password!.isEmpty) {
                        return "Enter Password";
                      }
                      return null;
                    },
                    obscureText: provider.obscureTextLogin,
                    controller: passwordController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        label: Text("Password",
                            style: GoogleFonts.novaSquare(
                              color: AppCloros.lightColor,
                            )),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: AppCloros.lightColor),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        border: const OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                              const BorderSide(color: AppCloros.lightColor),
                        ),
                        prefixIcon: const Icon(
                          Icons.lock_outline_rounded,
                          color: AppCloros.lightColor,
                        ),
                        suffix: InkWell(
                            onTap: () {
                              provider.obscureTextCheckLogin();
                            },
                            child: provider.obscureTextLogin
                                ? const Icon(
                                    Icons.visibility,
                                    color: AppCloros.lightColor,
                                  )
                                : const Icon(
                                    Icons.visibility_off,
                                    color: AppCloros.lightColor,
                                  ))),
                  ),
                  SizedBox(
                    height: 0.03.sh,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        FirebaseFunctions.login(
                            emailController.text, passwordController.text,
                            (value) {
                          AwesomeDialog(
                            dismissOnTouchOutside: false,
                            context: context,
                            animType: AnimType.SCALE,
                            dialogType: DialogType.ERROR,
                            title: 'Email or Password is incorrect',
                            titleTextStyle: GoogleFonts.novaSquare(
                                color: Colors.red, fontSize: 22),
                            desc:
                                'This email may not have been registered before, do you want to create a new account ?',
                            descTextStyle: GoogleFonts.novaSquare(
                                color: Colors.white, fontSize: 15),
                            btnOkOnPress: () {
                              Navigator.pushReplacementNamed(
                                  context, CreatAccount.routName);
                            },
                            btnCancelOnPress: () {},
                          ).show();
                        }, () {
                          provider.initUser();
                          Navigator.pushReplacementNamed(
                              context, HomeScreen.routeName);
                        });
                      }
                    },
                    child: Container(
                        width: 0.8.sw,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: const Color(0xff2C64C6)),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                              child: Text(
                            "Log in",
                            style: TextStyle(color: Colors.white),
                          )),
                        )),
                  ),
                  SizedBox(
                    height: 0.02.sh,
                  ),
                  MaterialButton(
                    minWidth: 1.w,
                    onPressed: () {
                      // Navigator.pushNamed(context, ForgotPassword.routName);
                    },
                    child: Text('Forgot Password ?',
                        style: GoogleFonts.novaSquare(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w900,
                        )),
                  ),
                  SizedBox(
                    height: 0.1.sh,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?",
                          style: GoogleFonts.novaCut(
                              fontSize: 15, color: Colors.white)),
                      SizedBox(
                        width: 0.01.sw,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, CreatAccount.routName);
                          },
                          child: Text("SIGNUP",
                              style: GoogleFonts.actor(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)))
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
