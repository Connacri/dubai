import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../ik/PublicHomeLIst.dart';
import '../ik/classes.dart';
import 'publicProfil.dart';

class publicLogged extends StatefulWidget {
  @override
  _publicLoggedState createState() {
    return _publicLoggedState();
  }
}

class _publicLoggedState extends State<publicLogged> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    final currentuser = FirebaseAuth.instance.currentUser;
    late final prov = Provider.of<SuperHero>(context, listen: false);
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        height: 60,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: <Widget>[
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.account_circle_rounded),
            icon: ClipRRect(
              clipBehavior: Clip.hardEdge,
              borderRadius: BorderRadius.circular(50),
              child: currentuser == null
                  ? const Icon(Icons.account_circle)
                  : ClipRRect(
                      clipBehavior: Clip.hardEdge,
                      borderRadius: BorderRadius.circular(50),
                      child: CachedNetworkImage(
                        imageUrl: currentuser.photoURL.toString(),
                        fit: BoxFit.cover,
                        height: 30,
                        width: 30,
                      ),
                    ),
            ),
            //Icon(Icons.account_circle_rounded),
            label: currentuser == null
                ? 'Account'
                : currentuser.displayName.toString().toUpperCase(),
          ),
        ],
      ),
      body: <Widget>[
        publicHomeList(),
        publicProfil(),

        //estimateik(),
      ][currentPageIndex],
    );
  }
}
