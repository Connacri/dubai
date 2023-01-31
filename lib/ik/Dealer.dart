import 'package:cached_network_image/cached_network_image.dart';
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
