import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class home extends StatelessWidget {
  const home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      // body: StreamBuilder<QuerySnapshot>(
      //   stream: FirebaseFirestore.instance.collection('Adventure').snapshots(),
      //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      //     if (snapshot.hasError) {
      //       return Text('Something went wrong');
      //     }
      //
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return Text("Loading");
      //     }
      //
      //     return ListView(
      //       children: snapshot.data!.docs.map((DocumentSnapshot document) {
      //         Map<String, dynamic> data =
      //             document.data()! as Map<String, dynamic>;
      //         return ListTile(
      //           title: Text(data['code']),
      //           subtitle: Text(data['model']),
      //         );
      //       }).toList(),
      //     );
      //   },
      // ),
      body: FutureBuilder(
          future: getposts(),
          //future: FirebaseFirestore.instance.collection('Adventure').get(),
          builder: (BuildContext, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.none) {
              return Text(
                'Error!!!',
                style: Theme.of(context).textTheme.headline5,
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.black45,
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (_, index) {
                    return Center(
                      child: Text(snapshot.data[index].id.toString()),
                    );
                  },
                );
              }
            }
            return Center(child: Text('no data'));
          }),
    );
  }

  Future getposts() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore.collection('Dealers').get();
    return qn.docs;
  }
}

class dealersDetail extends StatelessWidget {
  const dealersDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        // body: StreamBuilder<QuerySnapshot>(
        //   stream: FirebaseFirestore.instance.collection('Adventure').snapshots(),
        //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        //     if (snapshot.hasError) {
        //       return Text('Something went wrong');
        //     }
        //
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return Text("Loading");
        //     }
        //
        //     return ListView(
        //       children: snapshot.data!.docs.map((DocumentSnapshot document) {
        //         Map<String, dynamic> data =
        //             document.data()! as Map<String, dynamic>;
        //         return ListTile(
        //           title: Text(data['code']),
        //           subtitle: Text(data['model']),
        //         );
        //       }).toList(),
        //     );
        //   },
        // ),
        body: FutureBuilder(
            future: getposts(),
            //future: FirebaseFirestore.instance.collection('Adventure').get(),
            builder: (BuildContext, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.none) {
                return Text(
                  'Error!!!',
                  style: Theme.of(context).textTheme.headline5,
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Padding(
                  padding: const EdgeInsets.all(60.0),
                  child: CircularProgressIndicator(
                    color: Colors.black45,
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (_, index) {
                      return Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(snapshot.data[index].id.toString()),
                            Text(snapshot.data[index]
                                .data()["prixVente"]
                                .toString()),
                            Text(snapshot.data[index].data()["qty"].toString()),
                          ],
                        ),
                      );
                    },
                  );
                }
              }
              return Text('');
            }));
  }

  Future getposts() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore
        .collection('Dealers')
        .doc('4lvmvj4T46E0F1zD4ITE')
        .collection('gu')
        .get();
    return qn.docs;
  }
}