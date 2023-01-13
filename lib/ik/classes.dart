import 'package:cloud_firestore/cloud_firestore.dart';

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