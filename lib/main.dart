// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
// import 'package:provider/provider.dart';
//
// import 'rmz/Oauth/Ogoogle/googleSignInProvider.dart';
// import 'rmz/Oauth/verifi_auth.dart';
//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//
//   FlutterNativeSplash.removeAfter(initialization);
//   runApp(const MyApp());
// }
//
// Future initialization(BuildContext? context) async {
//   Future.delayed(Duration(seconds: 5));
// }
//
// final navigatorKey = GlobalKey<NavigatorState>();
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => googleSignInProvider(),
//       child: MaterialApp(
//         // debugShowCheckedModeBanner: false,
//         title: 'Flutter Demo',
//         theme: ThemeData(
//           useMaterial3: true,
//           fontFamily: 'oswald',
//           primarySwatch: Colors.blue,
//         ),
//         home: verifi_auth(),
//         // MultiProviderWidget(firebaseServices: firebaseServices),
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dubai/rmz/publicLogged.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:provider/provider.dart';

import 'ik/Estimate.dart';
import 'ik/invoiceList.dart';
import 'main_in.dart';
import 'main_out.dart';
import 'rmz/Oauth/Ogoogle/googleSignInProvider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      //options: DefaultFirebaseOptions.currentPlatform,
      );

  FlutterNativeSplash.removeAfter(initialization);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
      overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
  runApp(Materialclass());
}

Future initialization(BuildContext? context) async {
  Future.delayed(Duration(seconds: 5));
}

final navigatorKey = GlobalKey<NavigatorState>();

/// This is the main application widget.
class Materialclass extends StatelessWidget {
  Materialclass({Key? key}) : super(key: key);

  static const String _title = 'Oran ';
  final GoogleUser2 = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    // final GoogleSignInProvider googleSignInProviderStream =
    //     GoogleSignInProvider();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => googleSignInProvider(),
        ),
        // StreamProvider<SuperHero>(
        //   create: (_) =>
        //       googleSignInProviderStream.streamHero(GoogleUser2!.uid),
        //   initialData: SuperHero(userDisplayName: 'df', userAvatar: 'fd'),
        //   lazy: true,
        // ),
      ],
      child: MaterialApp(
        locale: const Locale('fr', ''),
        //scaffoldMessengerKey: Utils.messengerKey,
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: _title,
        themeMode: ThemeMode.dark,
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: "Oswald",
        ),
        home: const verifi_auth(),
        routes: {
          "/Estimate": (context) => Estimate(),
          "/invoiceList": (context) => invoiceList(),
        },
      ),
    );
  }
}

// class GoogleSignInProvider {
//   Stream<SuperHero> streamHero(id) {
//     final _fireStoreDataBase = FirebaseFirestore.instance;
//     return _fireStoreDataBase
//         .collection('Users')
//         .doc(id)
//         .snapshots()
//         .map((documen) {
//       final dataQ = SuperHero.fromJson(documen.data());
//       return dataQ;
//     });
//   }
// }

class verifi_auth extends StatefulWidget {
  const verifi_auth({Key? key}) : super(key: key);

  @override
  State<verifi_auth> createState() => _verifi_authState();
}

class _verifi_authState extends State<verifi_auth> {
  @override
  Widget build(BuildContext context) => Scaffold(
          body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text('Probleme de Connexion'));
          }
          if (snapshot.hasData) {
            final userD = snapshot.data!.uid;
            return CheckRole(userD); //MultiProviderWidget();
          } else {
            return main_out();
          }
        },
      ));
}

class CheckRole extends StatelessWidget {
  final String documentId;

  CheckRole(this.documentId);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text("${users.id} Document does not exist"),
              centerTitle: true,
            ),
            body: Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 38),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.black54,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      elevation: 4.0,
                      minimumSize: const Size.fromHeight(50)),
                  icon: Icon(
                    Icons.cancel,
                    color: Colors.red,
                  ),
                  label: const Text(
                    'Deconnexion',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                  onPressed: () async {
                    FirebaseAuth.instance.signOut();
                    final provider = Provider.of<googleSignInProvider>(context,
                        listen: false);
                    await provider.logouta();
                    // Navigator.of(context).pop();
                    Navigator.pop(context, true);
                  },
                ),
              ),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> userRole =
              snapshot.data!.data() as Map<String, dynamic>;
          if (userRole['userRole'] == 'admin') {
            return MultiProviderWidget(
              userRole: userRole,
            );
          } else {
            return publicLogged(
              userRole: userRole,
            );
          }
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
