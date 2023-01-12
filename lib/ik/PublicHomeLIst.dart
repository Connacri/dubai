import 'dart:core';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:paginate_firestore/widgets/bottom_loader.dart';
import 'package:paginate_firestore/widgets/empty_display.dart';
import 'package:paginate_firestore/widgets/empty_separator.dart';
import 'package:paginate_firestore/widgets/initial_loader.dart';
import 'package:url_launcher/url_launcher.dart';

class publicHomeList extends StatefulWidget {
  const publicHomeList({Key? key}) : super(key: key);

  @override
  State<publicHomeList> createState() => _publicHomeListState();
}

class _publicHomeListState extends State<publicHomeList> {
  late TextTheme textTheme;
  final navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<FormState> _formKeyQty = GlobalKey<FormState>();

  Color colorRed = Color.fromARGB(255, 213, 2, 2); //Colors.deepPurple;
  Color colorOrange =
      Color.fromARGB(255, 255, 95, 0); //Colors.deepOrangeAccent;
  Color colorGreen = Color.fromARGB(255, 139, 169, 2); //Colors.greenAccent;
  Color colorBlue = Color.fromARGB(255, 66, 58, 41); //Colors.blueAccent;

  Color color1 = const Color.fromARGB(255, 243, 236, 216);
  Color color2 = const Color.fromARGB(255, 127, 136, 106);
  Color color3 = const Color.fromARGB(255, 62, 80, 60);

  @override
  void initState() {
    // getdatata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Call AdventureGG'),
            IconButton(
                icon: Icon(
                  Icons.call,
                  color: Colors.green,
                ),
                onPressed: () async {
                  final Uri launchUrlR =
                      Uri(scheme: 'Tel', path: ' +971566129156');
                  if (await canLaunch(launchUrlR.toString())) {
                    await launch(launchUrlR.toString());
                  } else {
                    print('This Call Cant execute');
                  }
                }),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PaginateFirestore(
            header: SliverToBoxAdapter(
              child: Container(
                height: 200.0,
                child: ListView(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: [
                    UnsplashCard(
                        UnsplashUrl:
                            'https://img1.wsimg.com/isteam/ip/d48b4882-6d43-4aed-ac22-2834c9891797/ADV%20TYRES%20MOTOZ.jpg/:/cr=t:0%25,l:0%25,w:100%25,h:100%25/rs=w:1300,h:800'),
                    UnsplashCard(
                        UnsplashUrl:
                            'https://source.unsplash.com/random/250×200/?motocycle'),
                    UnsplashCard(
                        UnsplashUrl:
                            'https://source.unsplash.com/random/400×300/?motocycle'),
                    UnsplashCard(
                        UnsplashUrl:
                            'https://source.unsplash.com/random/300×200/?motos'),
                    UnsplashCard(
                        UnsplashUrl:
                            'https://source.unsplash.com/random/300×300/?moto'),
                    UnsplashCard(
                        UnsplashUrl:
                            'https://source.unsplash.com/random/300×200/?motor'),
                    UnsplashCard(
                        UnsplashUrl:
                            'https://img1.wsimg.com/isteam/ip/d48b4882-6d43-4aed-ac22-2834c9891797/Motoz_edits-8402-resized.jpg/:/rs=w:1300,h:800'),
                    UnsplashCard(
                        UnsplashUrl:
                            'https://img1.wsimg.com/isteam/ip/d48b4882-6d43-4aed-ac22-2834c9891797/4.jpg/:/rs=w:1300,h:800'),
                    UnsplashCard(
                        UnsplashUrl:
                            'https://img1.wsimg.com/isteam/ip/d48b4882-6d43-4aed-ac22-2834c9891797/motoz-505.jpg/:/rs=w:1300,h:800'),
                  ],
                ),
              ),
            ),
            itemsPerPage: 10000,
            onEmpty: const EmptyDisplay(),
            separator: const EmptySeparator(),
            initialLoader: const InitialLoader(),
            bottomLoader: const BottomLoader(),
            shrinkWrap: true,
            isLive: true,
            itemBuilderType: PaginateBuilderType.gridView,
            query: FirebaseFirestore.instance.collection('Adventure'),
            //.orderBy('createdAt', descending: true),
            itemBuilder: (BuildContext, DocumentSnapshot, int) {
              var data = DocumentSnapshot[int].data() as Map?;
              String dataid = DocumentSnapshot[int].id;

              return Card(
                color: Colors.grey.shade300,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: GridTile(
                    header: Text(
                      data!['code'],
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          data['model'].toString().toUpperCase(),
                          //overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          data['size'].toString(),
                          style: TextStyle(color: Colors.blueGrey),
                          // overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    footer: Text(
                      NumberFormat.currency(symbol: 'AED ', decimalDigits: 0)
                          .format(data['prixVente']),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.green),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}

class UnsplashCard extends StatelessWidget {
  const UnsplashCard({
    Key? key,
    required this.UnsplashUrl,
  }) : super(key: key);

  final String UnsplashUrl;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      semanticContainer: true,
      child: ShaderMask(
        shaderCallback: (rect) {
          return const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomLeft,
            colors: [Colors.transparent, Colors.black],
          ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
        },
        blendMode: BlendMode.darken,
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: UnsplashUrl,
          errorWidget: (context, url, error) => const Icon(
            Icons.error,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
