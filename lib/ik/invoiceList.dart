import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import 'invoiceDetail.dart';

class invoiceList extends StatelessWidget {
  invoiceList({
    Key? key,
    //required this.sumInvoices,
  }) : super(key: key);

  //final double sumInvoices;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invoices List'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Invoice')
            .orderBy('date', descending: true)
            .snapshots(),
        //.get(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          }
          if (snapshot.hasData) {
            List<QueryDocumentSnapshot<Map<String, dynamic>>> documents =
                snapshot.data!.docs;
            //  print(documents[0]['item CodeBar'][0]['size']);

            if (documents.isEmpty) {
              return Center(
                child: Lottie.asset(
                  'assets/lotties/112136-empty-red.json',
                  fit: BoxFit.contain,
                ),
              );
            } else {
              return ListView(
                shrinkWrap: true,
                children: documents
                    .map(
                      (doc) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => InvoiceDetail(
                                doc: doc,
                              ),
                            ));
                          },
                          child: Card(
                            child: ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      'Customer :  ${doc['customer'].toUpperCase()}'),
                                  Text('Invoice ID : ${doc.id.toUpperCase()}'),
                                ],
                              ),
                              subtitle: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          'Total Without Tax: ' +
                                              NumberFormat.currency(symbol: '')
                                                  .format(doc['total']),
                                          style: TextStyle(color: Colors.blue)),
                                      Text(
                                        'Benef : ' +
                                            NumberFormat.currency(symbol: '')
                                                .format(doc['benef']),
                                        style: TextStyle(color: Colors.green),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      'Date : ' +
                                          doc['date'].toDate().toString(),
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              );
            }
          } else if (snapshot.hasError) {
            return Text('Its Error!');
          }
          return Center(
            child: CircularProgressIndicator(
              color: Colors.black45,
            ),
          );
        },
      ),
    );
  }
}

// StreamBuilder<QuerySnapshot>(
//   stream: FirebaseFirestore.instance.collection('Invoice').snapshots(),
//   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//     if (snapshot.hasData) {
//       return ListView.builder(
//         itemCount: snapshot.data!.docs.length,
//         itemBuilder: (BuildContext context, int index) {
//           DocumentSnapshot document = snapshot.data!.docs[index];
//           return ListTile(
//             title: Text(document['customer']),
//             subtitle: Text(document['total'].toString()),
//           );
//         },
//       );
//     } else {
//       return CircularProgressIndicator();
//     }
//   },
// ),
