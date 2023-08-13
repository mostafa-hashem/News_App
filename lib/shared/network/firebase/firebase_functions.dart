import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app/models/user_model.dart';

class FirebaseFunctions {
  static CollectionReference<UserModel> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(UserModel.COLLECTIN_NAME)
        .withConverter<UserModel>(
          fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
          toFirestore: (user, options) => user.toJson(),
        );
  }

  static Future<void> addUserToFirestore(UserModel user) {
    var collection = getUsersCollection();
    var docRef = collection.doc(user.id);
    return docRef.set(user);
  }

  static Future<UserModel?> readUser(String id) async {
    DocumentSnapshot<UserModel> userSnap =
        await getUsersCollection().doc(id).get();
    return userSnap.data();
  }

  static void creatAccount(String email, String name, String password,
      Function created, Function isVerified) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await credential.user!.sendEmailVerification();
      bool isEmailVerified = credential.user!.emailVerified;

      UserModel userModel = UserModel(
        id: credential.user!.uid,
        name: name,
        email: email,
      );
      await addUserToFirestore(userModel);
      if (isEmailVerified) {

        created();
      } else {
        isVerified();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print(e.message);
      } else if (e.code == 'email-already-in-use') {
        print(e.message);
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  static void login(
      String email, String password, Function onError, Function logged) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      logged();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        onError(e.message);
      } else if (e.code == 'wrong-password') {
        onError(e.message);
      }
    }
  }
}
