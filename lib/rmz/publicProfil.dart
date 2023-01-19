import 'package:avatar_glow/avatar_glow.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Oauth/Ogoogle/googleSignInProvider.dart';

class publicProfil extends StatelessWidget {
  const publicProfil({Key? key, required this.userRole}) : super(key: key);
  final userRole;
  @override
  Widget build(BuildContext context) {
    final userGoo = FirebaseAuth.instance.currentUser;
    //
    // final userDoc = Provider.of<SuperHero>(context, listen: false);
    // print(userDoc.userDisplayName);

    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          CarouselSlider.builder(
            itemCount: 19,
            itemBuilder: (BuildContext context, int index, int pageViewIndex) =>
                ShaderMask(
              shaderCallback: (rect) {
                return const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomLeft,
                  colors: [Colors.transparent, Colors.black],
                ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
              },
              blendMode: BlendMode.darken,
              child: CachedNetworkImage(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.cover,
                imageUrl:
                    'https://firebasestorage.googleapis.com/v0/b/adventure-eb4ca.appspot.com/o/mob%2Fmob%20(${index + 1}).jpg?alt=media&token=9d17aa6e-0622-4d1f-bf78-97c0fe87da77',
                errorWidget: (context, url, error) => const Icon(
                  Icons.error,
                  color: Colors.red,
                ),
              ),
            ),
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height,
              aspectRatio: 16 / 9,
              viewportFraction: 1,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              enlargeFactor: 0,
              //onPageChanged: callbackFunction,
              scrollDirection: Axis.horizontal,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Lottie.asset(
              //   'assets/lotties/132349-business-woman.json',
              //   repeat: true,
              //   // reverse: true,
              //   animate: true,
              // ),
              Stack(
                children: [
                  AvatarGlow(
                    glowColor: Colors.white,
                    endRadius: 60.0,
                    child: Material(
                      // Replace this child with your own
                      elevation: 8.0,
                      shape: CircleBorder(),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(userRole['userAvatar']),
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
              Text(
                userGoo!.displayName.toString().toUpperCase(),
                style: TextStyle(color: Colors.white),
              ),
              // Center(
              //   child: Text('ID : ${userGoo.uid.toString().toUpperCase()}'),
              // ),
              ////////////////////// a verifi
              Center(
                  //  child: Text('Age : ${userDoc.userDisplayName}'),
                  ),
              ////////////////////// fin a verifi
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
                  Text(
                    userGoo.email.toString().toUpperCase(),
                    style: TextStyle(color: Colors.white),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Text(userGoo.emailVerified != true
                  //       ? 'Email Not Verified'
                  //       : 'Verified'),
                  // ),
                ],
              ),
              Text(
                userGoo.phoneNumber != null
                    ? userGoo.phoneNumber.toString()
                    : ' '.toUpperCase(),
                style: TextStyle(color: Colors.white),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 100),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.blueGrey,
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
                    final provider = Provider.of<googleSignInProvider>(context,
                        listen: false);
                    await provider.logouta();

                    Navigator.pop(context, true);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
