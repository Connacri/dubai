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

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

import 'main_in.dart';
import 'rmz/Oauth/AuthPage.dart';
import 'rmz/Oauth/Ogoogle/googleSignInProvider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      //options: DefaultFirebaseOptions.currentPlatform,
      );
  FlutterNativeSplash.removeAfter(initialization);
  runApp(const Materialclass());
}

Future initialization(BuildContext? context) async {
  Future.delayed(Duration(seconds: 5));
}

final navigatorKey = GlobalKey<NavigatorState>();

/// This is the main application widget.
class Materialclass extends StatelessWidget {
  const Materialclass({Key? key}) : super(key: key);

  static const String _title = 'Oran ';

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => googleSignInProvider(),
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
            //fontFamily: lang.languageCode == "ar" ? 'ArbFONTS-khalaad-al-arabeh' : "Oswald",
            //   fontFamily:
            //   Localizations.localeOf(context).languageCode == 'ar'?
            //   'ArbFONTS-khalaad-al-arabeh' : 'Oswald'
          ),
//          darkTheme: _darkTheme,

          home: const verifi_auth(),
        ),
      );
}

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
            return Scaffold(
              // body: Profile(),
              body: MultiProviderWidget(),
            );
          } else {
            return AuthPage();
          }
        },
      ));
}
