import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

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
                      return Column(
                        children: [
                          ListTile(
                            leading: Container(
                              width: 40.0,
                              height: 40.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: CachedNetworkImage(
                                imageUrl:
                                    'https://img1.wsimg.com/isteam/ip/d48b4882-6d43-4aed-ac22-2834c9891797/4.jpg/:/rs=w:1300,h:800',
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),

                            // Icon(
                            //   Icons.account_circle,
                            //   size: 40,
                            // ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(Data['name'].toUpperCase()),
                                Text(
                                  Data.id.toUpperCase(),
                                  style: TextStyle(fontSize: 12),
                                ),
                                // Text(Data['idcustomer'].toUpperCase(),
                                //     style: TextStyle(
                                //         fontSize: 12,
                                //         fontStyle: FontStyle.italic,
                                //         color: Colors.blue)),
                                Text(
                                    DateFormat(
                                      "EEEEEE : dd-MM-yyyy",
                                    ).format(Data['date'].toDate()),

                                    //.toDate()
                                    // .toString()
                                    // .toUpperCase(),
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontStyle: FontStyle.italic,
                                        color: Colors.black45)),
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
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount:
                                              orderSnapshot.data!.docs.length,
                                          itemBuilder: (context, index) {
                                            DocumentSnapshot Datasub =
                                                orderSnapshot.data!.docs[index];
                                            return ListTile(
                                              dense: true,
                                              title: Row(
                                                children: [
                                                  Datasub['state'] == true
                                                      ? Icon(
                                                          Icons.verified_user,
                                                          color: Colors.green,
                                                          size: 14,
                                                        )
                                                      : Icon(
                                                          Icons.cancel,
                                                          color: Colors.red,
                                                          size: 14,
                                                        ),
                                                  Text(
                                                      'Code : ${Datasub.id.toUpperCase()}',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color:
                                                              Colors.black54)),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Text(
                                                      'Qty : ${Datasub['qty'].toString().toUpperCase()}',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          // fontStyle:
                                                          //     FontStyle.italic,
                                                          color: Colors.green)),
                                                ],
                                              ),
                                            );
                                          },
                                        )
                                      : Container();
                                }),
                          ),
                          Divider()
                        ],
                      );
                    },
                  )
                : CircularProgressIndicator();
          }),
    );
  }
}

class dealersCredits extends StatelessWidget {
  const dealersCredits({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).copyWith(dividerColor: Colors.transparent);
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

                      return Column(
                        children: [
                          Card(
                            child: Theme(
                              data: theme,
                              child: ExpansionTile(
                                  leading: Container(
                                    width: 40.0,
                                    height: 40.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          'https://picsum.photos/200/300?random=${index}',
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Icon(FontAwesomeIcons.anchor),
                                    ),
                                  ),

                                  // Icon(
                                  //   Icons.account_circle,
                                  //   size: 40,
                                  // ),
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Text(Data['name'].toUpperCase()),
                                      Text(
                                        Data.id.toUpperCase(),
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      // Text(Data['idcustomer'].toUpperCase(),
                                      //     style: TextStyle(
                                      //         fontSize: 12,
                                      //         fontStyle: FontStyle.italic,
                                      //         color: Colors.blue)),
                                      Text(
                                          DateFormat(
                                            "EEEEEE : dd-MM-yyyy",
                                          ).format(Data['date'].toDate()),

                                          //.toDate()
                                          // .toString()
                                          // .toUpperCase(),
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontStyle: FontStyle.italic,
                                              color: Colors.black45)),
                                    ],
                                  ),
                                  children: [
                                    StreamBuilder(
                                        stream: FirebaseFirestore.instance
                                            .collection('Dealers')
                                            .doc(Data.id)
                                            .collection('productsList')
                                            .snapshots(),
                                        builder: (context, orderSnapshot) {
                                          return orderSnapshot.hasData
                                              ? ListView.builder(
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount: orderSnapshot
                                                      .data!.docs.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    DocumentSnapshot Datasub =
                                                        orderSnapshot
                                                            .data!.docs[index];
                                                    return ListTile(
                                                      dense: true,
                                                      title: Row(
                                                        children: [
                                                          Datasub['state'] ==
                                                                  true
                                                              ? Icon(
                                                                  Icons
                                                                      .verified_user,
                                                                  color: Colors
                                                                      .green,
                                                                  size: 14,
                                                                )
                                                              : Icon(
                                                                  Icons.cancel,
                                                                  color: Colors
                                                                      .red,
                                                                  size: 14,
                                                                ),
                                                          Text(
                                                              'ID : ${Datasub.id.toUpperCase()}',
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .black54)),
                                                          Spacer(),
                                                          Text(
                                                              'Qty : ${Datasub['qty'].toString().toUpperCase()}',
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  // fontStyle:
                                                                  //     FontStyle.italic,
                                                                  color: Colors
                                                                      .green)),
                                                          Spacer(),
                                                          Text(
                                                              'U : ${NumberFormat.currency(symbol: 'AED ', decimalDigits: 2).format(Datasub['prixVente'])}',
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .black54)),
                                                          Spacer(),
                                                          Text(
                                                              '=  ${NumberFormat.currency(symbol: 'AED ', decimalDigits: 2).format(Datasub['prixVente'] * Datasub['qty'])}',
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .black54)),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                )
                                              : Container();
                                        }),
                                  ]),
                            ),
                          ),
                        ],
                      );
                    },
                  )
                : CircularProgressIndicator();
          }),
    );
  }
}
