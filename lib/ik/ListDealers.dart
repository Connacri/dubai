import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListDealers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Users').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Something is wrong"),
              );
            }
            try {
              if (snapshot.data!.docs.length == 0) {
                return Scaffold(
                    backgroundColor: Colors.white,
                    body: Center(
                      // child: Lottie.asset(
                      //     'assets/lotties/89832-empty-list.json',
                      //     fit: BoxFit.contain),
                      child: Text(
                        'Users List Is Empty',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                      ),
                    ));
              }
            } catch (exception) {}

            return Scaffold(
              appBar: AppBar(
                toolbarHeight: 90.0,
                title: Text('Users List'),
              ),
              body: ListView(
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data == null
                          ? 0
                          : snapshot.data!.docs.length,
                      itemBuilder: (_, index) {
                        DocumentSnapshot _documentSnapshot =
                            snapshot.data!.docs[index];

                        return ListTile(
                          leading: Container(
                            width: 50.0,
                            height: 50.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: CachedNetworkImage(
                              imageUrl:
                                  _documentSnapshot['userAvatar'].toString(),
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.cover),
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                          title: Row(
                            children: [
                              Text(
                                _documentSnapshot['userRole']
                                        .toString()
                                        .toUpperCase() ??
                                    'unknow',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Colors.red),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                _documentSnapshot['userDisplayName']
                                    .toString()
                                    .toUpperCase(),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ID : ' +
                                    _documentSnapshot['userID']
                                        .toString()
                                        .toUpperCase(),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                'Phone : ' +
                                    _documentSnapshot['userPhone'].toString(),
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        );
                      }),
                ],
              ),
            );
          }),
    );
  }
}
