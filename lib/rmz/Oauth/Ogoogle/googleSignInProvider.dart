import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class googleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  @override
  void dispose() {
    googleLogin();
    super.dispose();
  }

  Future googleLogin() async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      _user = googleUser;
      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      final userGoo = FirebaseAuth.instance.currentUser;

      checkIfDocExists(userGoo!.uid);

      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  // Future readUserX() async {
  //   final user = await FirebaseAuth.instance.currentUser;
  //   final _docUser =
  //       await FirebaseFirestore.instance.collection('Users').doc(user!.uid);
  //   final snapshot = await _docUser.get();
  //   if (snapshot.exists) {
  //     print(snapshot.data()!['userDisplayName']);
  //     return snapshot.data()!['userDisplayName'].toString();
  //   }
  // }
//
//   late String _name;
//   late String _productId;
//   late double _price;
//
// //getters:
//   String get getName => _name;
//   double get getPrice => _price;
//
// //Setters:
//
//   void changeProductName(String val) {
//     _name = val;
//     notifyListeners();
//   }
//
//   void changeProductPrice(String val) {
//     _price = double.parse(val);
//     notifyListeners();
//   }

  Future logouta() async {
    await googleSignIn.disconnect();
    await FirebaseAuth.instance.signOut();
  }
}

Future<bool> checkIfDocExists(String uid) async {
  try {
    final userGoo = FirebaseAuth.instance.currentUser;
    var collectionRef = FirebaseFirestore.instance.collection('Users');
    var doc = await collectionRef.doc(uid).get();
    print(doc.exists);
    doc.exists ? null : setUserDoc(userGoo!);
    return doc.exists;
  } catch (e) {
    throw e;
  }
}

Future setUserDoc(User userGoo) async {
  CollectionReference userRef = FirebaseFirestore.instance.collection('Users');

  int i = 1;
  String userID = userGoo.uid;
  String? userEmail = userGoo.email;
  String? userAvatar = userGoo.photoURL;
  String? userDisplayName = userGoo.displayName;
  List usersLike = ['sans'];
  int userAge = 20;
  int userItemsNbr = 0;
  int userPhone = 65498321000; //int.parse(userGoo.phoneNumber.toString());
  String userSex = 'mal';
  bool userState = true;

  var now = DateTime.now().millisecondsSinceEpoch;

  userRef.doc(userGoo.uid).set({
    'userID': userID,
    'userEmail': userEmail,
    'userAvatar': userAvatar,
    'UcreatedAt': Timestamp.now(), //now.toString(),
    'userDisplayName': userDisplayName,
    'userAge': userAge,
    'userItemsNbr': FieldValue.increment(1),
    'userPhone': userPhone,
    'userSex': userSex,
    'userState': userState,
  }, SetOptions(merge: true));
}
