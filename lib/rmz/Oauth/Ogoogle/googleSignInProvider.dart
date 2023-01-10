import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class googleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  CollectionReference userRef = FirebaseFirestore.instance.collection('Users');

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;
  final userGoo = FirebaseAuth.instance.currentUser;

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

      print(
          '////////////////////////////////********************/////////////////////////////////////');
      print('userGoo!.uid : ${userGoo!.uid}');
      var userExist = FirebaseFirestore.instance.collection('Users');
      DocumentReference doc = await userExist.doc(userGoo.uid);
      print('doc.id : ' + doc.get().toString());
      print('doc.path : ' + doc.path);
      print('doc.toString : ' + doc.toString());

      //if (userGoo.uid != doc.id){
      //setUserDoc(userGoo);
      print(userGoo.uid);
      print(doc.id);
      print(userGoo.uid == doc.id ? 'makanche' : 'kayen wah');

      //
      // } else {
      //   return;
      // }
      Future<DocumentSnapshot<Map<String, dynamic>>> existDoc =
          FirebaseFirestore.instance.collection('Users').doc(userGoo.uid).get();
      final Map<String, dynamic> doc2 = existDoc as Map<String, dynamic>;
      //doc2.map((key, value) => null)
      print(
          '***********************************************************************');
      print(doc2.toString());

      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  Future logout() async {
    await googleSignIn.disconnect();
    await FirebaseAuth.instance.signOut();
  }

  Future setUserDoc(User userGoo) async {
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
}
