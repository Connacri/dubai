import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

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
        child: mainPageFirestoreGetik(),
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
