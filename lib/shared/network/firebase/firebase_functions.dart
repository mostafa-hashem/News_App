// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart' hide User;
// import 'package:news_app/constants.dart';
// import 'package:news_app/models/user_model.dart';
//
// class FirebaseFunctions {
//   final _usersCollection =
//   FirebaseFirestore.instance.collection(FirebasePath.users);
//
//
//   static CollectionReference<UserModel> getUsersCollection() {
//     return FirebaseFirestore.instance
//         .collection(FirebasePath.users)
//         .withConverter<UserModel>(
//           fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
//           toFirestore: (user, options) => user.toJson(),
//         );
//   }
//
//   static Future<void> addUserToFirestore(UserModel user) {
//     final collection = getUsersCollection();
//     final docRef = collection.doc(user.id);
//     return docRef.set(user);
//   }
//
//   static Future<UserModel?> readUser(String id) async {
//     final DocumentSnapshot<UserModel> userSnap =
//         await getUsersCollection().doc(id).get();
//     return userSnap.data();
//   }
//
//   static Future<void> creatAccount(String email, String name, String password,
//       Function created, Function isVerified,) async {
//     try {
//       final credential =
//           await FirebaseAuth.instance.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       await credential.user!.sendEmailVerification();
//       final bool isEmailVerified = credential.user!.emailVerified;
//
//       final UserModel userModel = UserModel(
//         id: credential.user!.uid,
//         name: name,
//         email: email,
//       );
//       await addUserToFirestore(userModel);
//       if (isEmailVerified) {
//
//         created();
//       } else {
//         isVerified();
//       }
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'weak-password') {
//         print(e.message);
//       } else if (e.code == 'email-already-in-use') {
//         print(e.message);
//         print('The account already exists for that email.');
//       }
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   static Future<void> login(
//       String email, String password, Function onError, Function logged,) async {
//     try {
//       final credential = await FirebaseAuth.instance
//           .signInWithEmailAndPassword(email: email, password: password);
//       logged();
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'user-not-found') {
//         onError(e.message);
//       } else if (e.code == 'wrong-password') {
//         onError(e.message);
//       }
//     }
//   }
// }
