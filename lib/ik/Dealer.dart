import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'Estimate.dart';

class dealer extends StatefulWidget {
  const dealer({Key? key}) : super(key: key);

  @override
  State<dealer> createState() => _dealerState();
}

class _dealerState extends State<dealer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Dealers').snapshots(),
          builder: (context, orderSnapshot) {
            return orderSnapshot.hasData
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: orderSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot Data = orderSnapshot.data!.docs[index];
                      return ListTile(
                        leading: Icon(
                          Icons.account_circle,
                          size: 40,
                        ),
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(Data['name'].toUpperCase()),
                            Text(
                              Data.id.toUpperCase(),
                              style: TextStyle(fontSize: 12),
                            ),
                            Text(Data['idcustomer'].toUpperCase(),
                                style: TextStyle(
                                    fontSize: 12,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.blue)),
                          ],
                        ),
                        subtitle: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('Dealers')
                                .doc(Data.id)
                                .collection('productsList')
                                .snapshots(),
                            builder: (context, orderSnapshot) {
                              return orderSnapshot.hasData
                                  ? ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount:
                                          orderSnapshot.data!.docs.length,
                                      itemBuilder: (context, index) {
                                        DocumentSnapshot Datasub =
                                            orderSnapshot.data!.docs[index];
                                        return ListTile(
                                          title: Row(
                                            children: [
                                              Datasub['state'] == true
                                                  ? Icon(Icons.verified_user,
                                                      color: Colors.green)
                                                  : Icon(
                                                      Icons.cancel,
                                                      color: Colors.red,
                                                    ),
                                              Text(
                                                  'Code : ${Datasub.id.toUpperCase()}'),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Text(
                                                  'Qty : ${Datasub['qty'].toString().toUpperCase()}'),
                                            ],
                                          ),
                                        );
                                      },
                                    )
                                  : Container();
                            }),
                      );
                    },
                  )
                : CircularProgressIndicator();
          }),
    );
  }
}
