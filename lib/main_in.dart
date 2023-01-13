import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ik/classes.dart';
import 'ik/testjason2firestoreGet.dart';
import 'rmz/Profile.dart';
import 'rmz/home.dart';

class MultiProviderWidget extends StatelessWidget {
  const MultiProviderWidget({
    Key? key,
    // required this.firebaseServices,
  }) : super(key: key);

  // final FirebaseServices firebaseServices;

  @override
  Widget build(BuildContext context) {
    final FirebaseServices firebaseServices = FirebaseServices();
    return MultiProvider(
      providers: [
        StreamProvider<List<Charges>>(
          create: (_) => firebaseServices.getCostsTaxesList(),
          initialData: [],
        ),
        StreamProvider<List<ItemsA>>(
          create: (_) => firebaseServices.getItemsList(),
          initialData: [],
        ),
        StreamProvider<List<Invoice>>(
          create: (_) => firebaseServices.getInvoiceList(),
          initialData: [],
        ),
      ],
      // child: logIn(),
      child: NavigationExample(),
      //**************************************
      //child: mainPageFirestoreGetik(),
    );
  }
}

class FirebaseServices {
  FirebaseFirestore _fireStoreDataBase = FirebaseFirestore.instance;

  //recieve the data

  Stream<List<Charges>> getCostsTaxesList() {
    return _fireStoreDataBase.collection('Charges').snapshots().map(
        (snapShot) => snapShot.docs
            .map((document) => Charges.fromJson(document.data()))
            .toList());
  }

  Stream<List<ItemsA>> getItemsList() {
    return _fireStoreDataBase.collection('Adventure').snapshots().map(
        (snapShot) => snapShot.docs
            .map((document) => ItemsA.fromJson(document.data()))
            .toList());
  }

  Stream<List<Invoice>> getInvoiceList() {
    return _fireStoreDataBase.collection('Invoice').snapshots().map(
        (snapShot) => snapShot.docs
            .map((document) => Invoice.fromJson(document.data()))
            .toList());
  }
}

class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 0;
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
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
            icon: Icon(Icons.accessibility),
            label: 'Customers',
          ),
          // NavigationDestination(
          //   selectedIcon: Icon(Icons.account_circle_rounded),
          //   icon: ClipRRect(
          //     clipBehavior: Clip.hardEdge,
          //     borderRadius: BorderRadius.circular(50),
          //     child: ClipRRect(
          //       clipBehavior: Clip.hardEdge,
          //       borderRadius: BorderRadius.circular(50),
          //       child: user!.photoURL == null
          //           ? const Icon(Icons.account_circle)
          //           : FutureBuilder(
          //         future: readUser(),
          //         builder: (BuildContext context,
          //             AsyncSnapshot<dynamic> snapshot) {
          //           if (snapshot.hasData) {
          //             final user1 = snapshot.data;
          //             return user1 != null
          //                 ? CachedNetworkImage(
          //               imageUrl: user1['userAvatar'],
          //               width: 30,
          //               height: 30,
          //               fit: BoxFit.cover,
          //             )
          //                 : Icon(Icons.account_circle_rounded);
          //           } else {
          //             return Center(
          //               child: CircularProgressIndicator(),
          //             );
          //           }
          //         },
          //       ),
          //     ),
          //   ),
          //
          //   //Icon(Icons.account_circle_rounded),
          //   label: user!.displayName.toString(),
          // ),
          FutureBuilder(
            future: readUser(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                final user1 = snapshot.data;
                return NavigationDestination(
                  selectedIcon: Icon(Icons.account_circle_rounded),
                  icon: ClipRRect(
                    clipBehavior: Clip.hardEdge,
                    borderRadius: BorderRadius.circular(50),
                    child: ClipRRect(
                      clipBehavior: Clip.hardEdge,
                      borderRadius: BorderRadius.circular(50),
                      child: user!.photoURL == null
                          ? const Icon(Icons.account_circle)
                          : CachedNetworkImage(
                              imageUrl: user1['userAvatar'],
                              width: 30,
                              height: 30,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),

                  //Icon(Icons.account_circle_rounded),
                  label: user1['userDisplayName'],
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
      body: <Widget>[
        mainPageFirestoreGetik(),
        //estimateik(),
        home(),
        //NavRailExample(),
        // dealer(),
        Profile(),
      ][currentPageIndex],
    );
  }

  Future<Map<String, dynamic>?> readUser() async {
    final _docUser =
        FirebaseFirestore.instance.collection('Users').doc(user!.uid);
    final snapshot = await _docUser.get();
    if (snapshot.exists) {
      return snapshot.data();
    }
  }
}
