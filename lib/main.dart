import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

import 'ik/Dealer.dart';
import 'ik/testjason2firestoreGet.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FlutterNativeSplash.removeAfter(initialization);
  runApp(const MyApp());
}

Future initialization(BuildContext? context) async {
  Future.delayed(Duration(seconds: 5));
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final FirebaseServices firebaseServices = FirebaseServices();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'oswald',
        primarySwatch: Colors.blue,
      ),
      home: MultiProvider(
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
        child: NavigationExample(),
        //child: mainPageFirestoreGetik(),
      ),
    );
  }
}

class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 0;

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
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.accessibility),
            label: 'Customers',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.account_balance_outlined),
            icon: Icon(Icons.account_circle_rounded),
            label: 'Profie',
          ),
        ],
      ),
      body: <Widget>[
        mainPageFirestoreGetik(),
        dealer(),
        //NavRailExample(),
        dealer(),
      ][currentPageIndex],
    );
  }
}

class NavRailExample extends StatefulWidget {
  const NavRailExample({super.key});

  @override
  State<NavRailExample> createState() => _NavRailExampleState();
}

class _NavRailExampleState extends State<NavRailExample> {
  int _selectedIndex = 0;
  NavigationRailLabelType labelType = NavigationRailLabelType.all;
  bool showLeading = false;
  bool showTrailing = false;
  double groupAligment = -1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          NavigationRail(
            selectedIndex: _selectedIndex,
            groupAlignment: groupAligment,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            labelType: labelType,
            leading: showLeading
                ? FloatingActionButton(
                    elevation: 0,
                    onPressed: () {
                      // Add your onPressed code here!
                    },
                    child: const Icon(Icons.add),
                  )
                : const SizedBox(),
            trailing: showTrailing
                ? IconButton(
                    onPressed: () {
                      // Add your onPressed code here!
                    },
                    icon: const Icon(Icons.more_horiz_rounded),
                  )
                : const SizedBox(),
            destinations: const <NavigationRailDestination>[
              NavigationRailDestination(
                icon: Icon(Icons.favorite_border),
                selectedIcon: Icon(Icons.favorite),
                label: Text('First'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.bookmark_border),
                selectedIcon: Icon(Icons.book),
                label: Text('Second'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.star_border),
                selectedIcon: Icon(Icons.star),
                label: Text('Third'),
              ),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          // This is the main content.
          // Expanded(
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: <Widget>[
          //       Text('selectedIndex: $_selectedIndex'),
          //       const SizedBox(height: 20),
          //       Text('Label type: ${labelType.name}'),
          //       const SizedBox(height: 10),
          //       OverflowBar(
          //         spacing: 10.0,
          //         children: <Widget>[
          //           ElevatedButton(
          //             onPressed: () {
          //               setState(() {
          //                 labelType = NavigationRailLabelType.none;
          //               });
          //             },
          //             child: const Text('None'),
          //           ),
          //           ElevatedButton(
          //             onPressed: () {
          //               setState(() {
          //                 labelType = NavigationRailLabelType.selected;
          //               });
          //             },
          //             child: const Text('Selected'),
          //           ),
          //           ElevatedButton(
          //             onPressed: () {
          //               setState(() {
          //                 labelType = NavigationRailLabelType.all;
          //               });
          //             },
          //             child: const Text('All'),
          //           ),
          //         ],
          //       ),
          //       const SizedBox(height: 20),
          //       Text('Group alignment: $groupAligment'),
          //       const SizedBox(height: 10),
          //       OverflowBar(
          //         spacing: 10.0,
          //         children: <Widget>[
          //           ElevatedButton(
          //             onPressed: () {
          //               setState(() {
          //                 groupAligment = -1.0;
          //               });
          //             },
          //             child: const Text('Top'),
          //           ),
          //           ElevatedButton(
          //             onPressed: () {
          //               setState(() {
          //                 groupAligment = 0.0;
          //               });
          //             },
          //             child: const Text('Center'),
          //           ),
          //           ElevatedButton(
          //             onPressed: () {
          //               setState(() {
          //                 groupAligment = 1.0;
          //               });
          //             },
          //             child: const Text('Bottom'),
          //           ),
          //         ],
          //       ),
          //       const SizedBox(height: 20),
          //       OverflowBar(
          //         spacing: 10.0,
          //         children: <Widget>[
          //           ElevatedButton(
          //             onPressed: () {
          //               setState(() {
          //                 showLeading = !showLeading;
          //               });
          //             },
          //             child:
          //                 Text(showLeading ? 'Hide Leading' : 'Show Leading'),
          //           ),
          //           ElevatedButton(
          //             onPressed: () {
          //               setState(() {
          //                 showTrailing = !showTrailing;
          //               });
          //             },
          //             child: Text(
          //                 showTrailing ? 'Hide Trailing' : 'Show Trailing'),
          //           ),
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
          Container(
            color: Colors.orange,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width * 0.5,
          ),
          Container(
            color: Colors.brown,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width * 0.5,
          ),
          Container(
            color: Colors.blueAccent,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width * 0.5,
          )
        ],
      ),
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

class Charges {
  double amount;
  Timestamp createdAt;
  bool credit;
  Timestamp date;
  int deadline;
  String model;
  bool periodic;
  String type;

  Charges.name(this.amount, this.createdAt, this.credit, this.date,
      this.deadline, this.model, this.periodic, this.type);

  Charges.fromJson(Map<String, dynamic> parsedJSON)
      : amount = parsedJSON['amount'],
        createdAt = parsedJSON['createdAt'],
        credit = parsedJSON['credit'],
        date = parsedJSON['date'],
        deadline = parsedJSON['deadline'],
        model = parsedJSON['model'],
        periodic = parsedJSON['periodic'],
        type = parsedJSON['type'];
}

class ItemsA {
  final String category;
  final String code;
  final String codebar;
  //final DateTime createdAt;
  final String description;
  final String model;
  final int oldStock;
  final String origine;
  final double prixAchat;
  final double prixVente;
  final String size;
  final int stock;
  final String user;

  const ItemsA(
      {required this.category,
      required this.code,
      required this.codebar,
      // required this.createdAt,
      required this.description,
      required this.model,
      required this.oldStock,
      required this.origine,
      required this.prixAchat,
      required this.prixVente,
      required this.size,
      required this.stock,
      required this.user});

  static ItemsA fromJson(json) => ItemsA(
        // createdAt: DateTime.parse(json['createdAt']!) as DateTime,
        code: json['code']! as String,
        category: json['category']! as String,
        model: json['model']! as String,
        description: json['description']! as String,
        size: json['size']! as String,
        prixAchat: double.parse(json['prixAchat']!.toString()),
        prixVente: double.parse(json['prixVente']!.toString()),
        stock: json['stock']! as int,
        oldStock: json['oldStock']! as int,
        codebar: json['codebar']!.toString() as String,
        origine: json['origine']! as String,
        user: json['user']! as String,
      );
}

class Invoice {
  final double benef;
  final String customer;
  // final DateTime date;
  final List itemCodeBar;

  const Invoice({
    required this.benef,
    required this.customer,
    //  required this.date,
    required this.itemCodeBar,
  });

  static Invoice fromJson(json) => Invoice(
        benef: json['benef'] as double,
        customer: json['customer']! as String,
        //date: DateTime.parse(json['date']!) as DateTime,
        itemCodeBar: json['item CodeBar']! as List,
      );
}
