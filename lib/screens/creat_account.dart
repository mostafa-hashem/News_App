// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:news_app/layout/home_layout.dart';
// import 'package:news_app/provider/app_provider.dart';
// import 'package:news_app/screens/login_screen.dart';
// import 'package:news_app/shared/network/firebase/firebase_functions.dart';
// import 'package:news_app/shared/styles/app_colors.dart';
// import 'package:provider/provider.dart';
//
// class CreatAccount extends StatefulWidget {
//   static const String routName = "CreatAccount";
//
//   @override
//   State<CreatAccount> createState() => _CreatAccountState();
// }
//
// class _CreatAccountState extends State<CreatAccount> {
//   final formKey = GlobalKey<FormState>();
//   final passwordController = TextEditingController();
//   final passwordConfirmController = TextEditingController();
//   final emailController = TextEditingController();
//   final userNameController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<MyAppProvider>(context);
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: Stack(
//         children: [
//           Image.asset(
//             "assets/images/login_bg.png",
//             width: double.infinity,
//             height: double.infinity,
//             fit: BoxFit.cover,
//           ),
//           Padding(
//             padding: const EdgeInsets.all(20),
//             child: Form(
//               key: formKey,
//               child: Column(children: [
//                 SizedBox(height: 0.06.sh),
//                 Text('News App',
//                     style: GoogleFonts.novaSquare(
//                       color: Colors.white,
//                       fontSize: 50.sp,
//                     ),),
//                 SizedBox(height: 0.03.sh),
//                 const Text(
//                   "Just one step you can see what's",
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 const Text(
//                   "happened in the world",
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 SizedBox(height: 0.07.sh),
//                 TextFormField(
//                   validator: (email) {
//                     if (email!.isEmpty) {
//                       return "Enter User Name";
//                     }
//                     final bool emailValid = RegExp(
//                             r"^[a-zA-Z\d]([._](?![._])|[a-zA-Z\d]){1,18}[a-zA-Z\d]$",)
//                         .hasMatch(email);
//                     if (!emailValid) {
//                       "Enter Valid User Name";
//                     }
//                     return null;
//                   },
//                   controller: userNameController,
//                   keyboardType: TextInputType.emailAddress,
//                   decoration: InputDecoration(
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: const BorderSide(color: AppCloros.lightColor),
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(16),
//                       borderSide: const BorderSide(color: AppCloros.lightColor),
//                     ),
//                     label: Text("User Name",
//                         style: GoogleFonts.novaSquare(
//                           color: AppCloros.lightColor,
//                         ),),
//                     border: const OutlineInputBorder(),
//                     prefixIcon: const Icon(
//                       Icons.person,
//                       color: AppCloros.lightColor,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 0.02.sh),
//                 TextFormField(
//                   validator: (email) {
//                     if (email!.isEmpty) {
//                       return "Enter Email";
//                     }
//                     final bool emailValid = RegExp(
//                             r"^[a-zA-Z\d.a-zA-Z\d.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z\d]+\.[a-zA-Z]+",)
//                         .hasMatch(email);
//                     if (!emailValid) {
//                       return "Enter Valid Email";
//                     }
//                     return null;
//                   },
//                   controller: emailController,
//                   keyboardType: TextInputType.emailAddress,
//                   textInputAction: TextInputAction.next,
//                   decoration: InputDecoration(
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: const BorderSide(color: AppCloros.lightColor),
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(16),
//                       borderSide: const BorderSide(color: AppCloros.lightColor),
//                     ),
//                     label: Text("Email",
//                         style: GoogleFonts.novaSquare(
//                           color: AppCloros.lightColor,
//                         ),),
//                     border: const OutlineInputBorder(),
//                     prefixIcon: const Icon(
//                       Icons.email,
//                       color: AppCloros.lightColor,
//                     ),
//                     suffix: const Icon(
//                       Icons.alternate_email,
//                       color: AppCloros.lightColor,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 0.02.sh),
//                 TextFormField(
//                   validator: (password) {
//                     if (password!.isEmpty) {
//                       return "Enter Password";
//                     } else if (password.length < 6) {
//                       return "Password length shouldn't be less than 6 characters";
//                     }
//                     final bool passwordValid = RegExp(
//                             r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?\d)(?=.*?[!@#$&*~]).{8,}$',)
//                         .hasMatch(password);
//                     if (!passwordValid) {
//                       return "Enter Valid Password";
//                     }
//                     return null;
//                   },
//                   obscureText: provider.obscureTextCreate,
//                   controller: passwordController,
//                   textInputAction: TextInputAction.next,
//                   decoration: InputDecoration(
//                       label: Text("Password",
//                           style: GoogleFonts.novaSquare(
//                             color: AppCloros.lightColor,
//                           ),),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide:
//                             const BorderSide(color: AppCloros.lightColor),
//                         borderRadius: BorderRadius.circular(16),
//                       ),
//                       border: const OutlineInputBorder(),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(16),
//                         borderSide:
//                             const BorderSide(color: AppCloros.lightColor),
//                       ),
//                       prefixIcon: const Icon(
//                         Icons.lock_outline_rounded,
//                         color: AppCloros.lightColor,
//                       ),
//                       suffix: InkWell(
//                           onTap: () {
//                             provider.obscureTextCheckCreat();
//                           },
//                           child: provider.obscureTextCreate
//                               ? const Icon(
//                                   Icons.visibility,
//                                   color: AppCloros.lightColor,
//                                 )
//                               : const Icon(
//                                   Icons.visibility_off,
//                                   color: AppCloros.lightColor,
//                                 ),),),
//                 ),
//                 SizedBox(height: 0.02.sh),
//                 TextFormField(
//                   validator: (password) {
//                     if (passwordConfirmController.text !=
//                         passwordController.text) {
//                       return "Password doesn't match.";
//                     }
//                     return null;
//                   },
//                   obscureText: provider.obscureTextCreate,
//                   controller: passwordConfirmController,
//                   textInputAction: TextInputAction.done,
//                   decoration: InputDecoration(
//                       label: Text("Confirm Password",
//                           style: GoogleFonts.novaSquare(
//                             color: AppCloros.lightColor,
//                           ),),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide:
//                             const BorderSide(color: AppCloros.lightColor),
//                         borderRadius: BorderRadius.circular(16),
//                       ),
//                       border: const OutlineInputBorder(),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(16),
//                         borderSide:
//                             const BorderSide(color: AppCloros.lightColor),
//                       ),
//                       prefixIcon: const Icon(
//                         Icons.lock_outline_rounded,
//                         color: AppCloros.lightColor,
//                       ),
//                       suffix: InkWell(
//                           onTap: () {
//                             provider.obscureTextCheckCreat();
//                           },
//                           child: provider.obscureTextCreate
//                               ? const Icon(
//                                   Icons.visibility,
//                                   color: AppCloros.lightColor,
//                                 )
//                               : const Icon(
//                                   Icons.visibility_off,
//                                   color: AppCloros.lightColor,
//                                 ),),),
//                 ),
//                 SizedBox(height: 0.05.sh),
//                 GestureDetector(
//                   onTap: () {
//                     if (formKey.currentState!.validate()) {
//                       FirebaseFunctions.creatAccount(
//                           emailController.text,
//                           userNameController.text,
//                           passwordController.text, () {
//                         provider.initUser();
//                         Navigator.pushReplacementNamed(
//                             context, HomeScreen.routeName,);
//                       }, (){
//                         AwesomeDialog(
//                           dismissOnTouchOutside: false,
//                           context: context,
//                           dialogType: DialogType.WARNING,
//                           title: 'Email Verification',
//                           titleTextStyle: GoogleFonts.novaSquare(
//                               color: Colors.red, fontSize: 22,),
//                           desc:
//                           'Please verify your email address.',
//                           descTextStyle: GoogleFonts.novaSquare(
//                               color: provider.themeMode == ThemeMode.dark ? Colors.white : Colors.black, fontSize: 15,),
//                           btnOkOnPress: () {
//                             Navigator.pushReplacementNamed(
//                                 context, LoginScreen.routName,);
//                           },
//                         ).show();
//                       });
//                     }
//                   },
//                   child: Container(
//                       width: 0.8.sw,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(18),
//                           color: const Color(0xff2C64C6),),
//                       child: const Padding(
//                         padding: EdgeInsets.all(8.0),
//                         child: Center(
//                             child: Text(
//                           "Sign Up",
//                           style: TextStyle(color: Colors.white),
//                         ),),
//                       ),),
//                 ),
//               ],),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
