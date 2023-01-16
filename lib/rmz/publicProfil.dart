import 'package:avatar_glow/avatar_glow.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import 'Oauth/Ogoogle/googleSignInProvider.dart';

class publicProfil extends StatelessWidget {
  const publicProfil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userGoo = FirebaseAuth.instance.currentUser;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Lottie.asset(
            'assets/lotties/132349-business-woman.json',
            repeat: true,
            // reverse: true,
            animate: true,
          ),
          Stack(
            children: [
              AvatarGlow(
                glowColor: Colors.black54,
                endRadius: 60.0,
                child: Material(
                  // Replace this child with your own
                  elevation: 8.0,
                  shape: CircleBorder(),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(userGoo!.photoURL.toString()),
                    radius: 30.0,
                  ),
                ),
              ),
              Positioned(
                right: 27,
                bottom: 27,
                child: Icon(
                  Icons.check_circle,
                  color: Colors.blue,
                ),
              )
            ],
          ),
          Text(userGoo.displayName.toString().toUpperCase()),
          // Center(
          //   child: Text('ID : ${userGoo.uid.toString().toUpperCase()}'),
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              userGoo.emailVerified == true
                  ? Icon(
                      Icons.check_circle,
                      color: Colors.blue,
                    )
                  : Icon(
                      Icons.not_interested_outlined,
                      color: Colors.red,
                    ),
              Text(userGoo.email.toString().toUpperCase()),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Text(userGoo.emailVerified != true
              //       ? 'Email Not Verified'
              //       : 'Verified'),
              // ),
            ],
          ),
          Text(userGoo.phoneNumber != null
              ? userGoo.phoneNumber.toString()
              : ' '.toUpperCase()),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 100),
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
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              onPressed: () async {
                FirebaseAuth.instance.signOut();
                final provider =
                    Provider.of<googleSignInProvider>(context, listen: false);
                await provider.logouta();

                Navigator.pop(context, true);
              },
            ),
          ),
        ],
      ),

      // body: Column(
      //   children: [
      //     Stack(
      //       alignment: Alignment.bottomCenter,
      //       children: [
      //         Lottie.asset(
      //           'assets/lotties/132349-business-woman.json',
      //           repeat: true,
      //           // reverse: true,
      //           animate: true,
      //         ),
      //         Column(
      //           children: [
      //             AvatarGlow(
      //               glowColor: Colors.purple,
      //               endRadius: 60.0,
      //               child: Material(
      //                 // Replace this child with your own
      //                 elevation: 8.0,
      //                 shape: CircleBorder(),
      //                 child: CircleAvatar(
      //                   backgroundImage:
      //                       NetworkImage(userGoo!.photoURL.toString()),
      //                   radius: 30.0,
      //                 ),
      //               ),
      //             ),
      //             Text(userGoo.displayName.toString().toUpperCase()),
      //             //Text(authInfo.user.email),
      //             Row(
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               crossAxisAlignment: CrossAxisAlignment.center,
      //               children: [
      //                 userGoo.emailVerified == true
      //                     ? Icon(
      //                         Icons.check_circle,
      //                         color: Colors.blue,
      //                       )
      //                     : Icon(
      //                         Icons.not_interested_outlined,
      //                         color: Colors.red,
      //                       ),
      //                 Text(userGoo.email.toString().toUpperCase()),
      //               ],
      //             ),
      //           ],
      //         ),
      //       ],
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child:
      //           Text(userGoo.emailVerified != true ? 'Email Not Verified' : ''),
      //     ),
      //     Text(userGoo.phoneNumber != null
      //         ? userGoo.phoneNumber.toString()
      //         : ' '.toUpperCase()),
      //     Padding(
      //       padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 38),
      //       child: ElevatedButton.icon(
      //         style: ElevatedButton.styleFrom(
      //             primary: Colors.black54,
      //             shape: RoundedRectangleBorder(
      //                 borderRadius: BorderRadius.circular(15)),
      //             elevation: 4.0,
      //             minimumSize: const Size.fromHeight(50)),
      //         icon: Icon(
      //           Icons.cancel,
      //           color: Colors.red,
      //         ),
      //         label: const Text(
      //           'Deconnexion',
      //           style: TextStyle(fontSize: 24, color: Colors.white),
      //         ),
      //         onPressed: () async {
      //           // FirebaseAuth.instance.signOut();
      //           // final provider =
      //           //     Provider.of<googleSignInProvider>(context, listen: false);
      //           // await provider.logouta();
      //           //
      //           // Navigator.pop(context, true);
      //         },
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
