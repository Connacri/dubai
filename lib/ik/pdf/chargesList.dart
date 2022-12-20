import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'AddingCharges.dart';

class chargeList extends StatelessWidget {
  const chargeList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Charges List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.incomplete_circle),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AddingCharges(),
              ));
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Charges')
            .orderBy('date', descending: true)
            .snapshots(),
        // .get(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            final List<DocumentSnapshot> documents = snapshot.data!.docs;

            return ListView(
                shrinkWrap: true,
                children: documents
                    .map(
                      (doc) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.cyan,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: FittedBox(
                                  child: Text(
                                    doc['type'].toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Amount :'),
                                Text(
                                  NumberFormat.currency(symbol: '')
                                      .format(doc['amount']),
                                  style: TextStyle(
                                    color: Colors.cyan,
                                  ),
                                ),
                              ],
                            ),
                            title: Text(
                              'Model : ' +
                                  doc['model'].toString().toUpperCase(),
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    'Deadline: ' +
                                        (doc['deadline'].toString()) +
                                        ' Days',
                                    style: TextStyle(
                                      color: Colors.cyan,
                                    )),
                                Text(
                                  'Date : ' +
                                      doc['date'].toDate().day.toString() +
                                      '/' +
                                      doc['date'].toDate().month.toString() +
                                      '/' +
                                      doc['date'].toDate().year.toString(),
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList());
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
