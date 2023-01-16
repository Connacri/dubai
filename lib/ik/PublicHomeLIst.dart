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
        title: Text('Call AdventureGG'),
        actions: [
          IconButton(
              icon: Icon(
                Icons.call,
                color: Colors.green,
              ),
              onPressed: () async {
                final Uri launchUrlR =
                    Uri(scheme: 'Tel', path: ' +971566129156');
                if (await canLaunchUrl(launchUrlR)) {
                  await launchUrl(launchUrlR);
                } else {
                  print('This Call Cant execute');
                }
              }),
          IconButton(
              icon: Icon(
                Icons.whatsapp,
                color: Colors.green,
              ),
              onPressed: () async {
                // final Uri whatsapp = Uri(scheme: 'Tel', path: ' +971566129156');
                // final Uri whatsappURl_android = Uri(
                //     scheme: 'Tel',
                //     path: 'whatsapp://send?phone=+${whatsapp}+&text=hello');
                //
                // if (await canLaunchUrl(whatsappURl_android)) {
                //   await launchUrl(whatsappURl_android);
                // } else {
                //   ScaffoldMessenger.of(context).showSnackBar(
                //       SnackBar(content: new Text("whatsapp no installed")));
                // }

                var phone = 00971566129156;
                String msg = 'Hello AdventureGG';
                var whatsappUrl = "whatsapp://send?phone=${phone}" +
                    "&text=${Uri.encodeComponent(msg)}";

                final Uri launchUrlRW = Uri(
                    scheme: 'Tel',
                    path: "whatsapp://send?phone=${phone}" +
                        "&text=${Uri.encodeComponent(msg)}");
                try {
                  launch(whatsappUrl);
                } catch (e) {
                  //To handle error and display error message
                  print("Unable to open whatsapp");
                }
              }),
        ],
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

              return GestureDetector(
                onTap: () async {
                  await showDetailPublic(data, int);
                },
                child: Card(
                  child: GridTile(
                    // header section
                    // header: GridTileBar(
                    //   backgroundColor: Colors.white,
                    //   leading: const CircleAvatar(
                    //     backgroundColor: Colors.deepOrange,
                    //     child: Text(
                    //       'K',
                    //       style: TextStyle(color: Colors.white, fontSize: 30),
                    //     ),
                    //   ),
                    //   title: const Text(
                    //     'KindaCode.com',
                    //     style: TextStyle(color: Colors.black),
                    //   ),
                    //   subtitle: const Text('5 minutes ago',
                    //       style: TextStyle(color: Colors.grey)),
                    //   trailing: IconButton(
                    //       onPressed: () {},
                    //       icon: const Icon(
                    //         Icons.more_vert_rounded,
                    //         color: Colors.black54,
                    //       )),
                    // ),
                    // footer section
                    footer: GridTileBar(
                      backgroundColor: Colors.black54,
                      title: Text(
                        NumberFormat.currency(symbol: 'AED ', decimalDigits: 0)
                            .format(data!['prixVente']),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            //backgroundColor: Colors.black45,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.amberAccent,
                            fontFamily: 'oswald'),
                      ),
                      trailing: Text(
                        data['code'],
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    // main child
                    child: CachedNetworkImage(
                      imageUrl:
                          'https://firebasestorage.googleapis.com/v0/b/adventure-eb4ca.appspot.com/o/tyres%2Ftyres%20(${int + 1}).jpg?alt=media&token=b3c6a2c0-c5ad-4433-95f2-60c42ebbc092',
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => Image.network(
                          'https://img1.wsimg.com/isteam/ip/d48b4882-6d43-4aed-ac22-2834c9891797/4.jpg/:/rs=w:1300,h:800'),
                    ),
                  ),
                ),
              );

              //   Container(
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Stack(
              //         // alignment: Alignment.center,
              //         fit: StackFit.expand,
              //         children: [
              //           CachedNetworkImage(
              //             imageUrl:
              //                 'https://firebasestorage.googleapis.com/v0/b/adventure-eb4ca.appspot.com/o/tyres%2Ftyres%20(${int + 1}).jpg?alt=media&token=b3c6a2c0-c5ad-4433-95f2-60c42ebbc092',
              //             fit: BoxFit.cover,
              //             errorWidget: (context, url, error) => Image.network(
              //                 'https://img1.wsimg.com/isteam/ip/d48b4882-6d43-4aed-ac22-2834c9891797/4.jpg/:/rs=w:1300,h:800'),
              //           ),
              //           Column(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             //crossAxisAlignment: CrossAxisAlignment.center,
              //             children: [
              //               Text(
              //                 data!['code'],
              //                 style: TextStyle(
              //                     backgroundColor: Colors.indigo,
              //                     color: Colors.white,
              //                     fontSize: 16,
              //                     fontWeight: FontWeight.w500),
              //               ),
              //
              //               Text(
              //                 NumberFormat.currency(
              //                         symbol: 'AED ', decimalDigits: 0)
              //                     .format(data['prixVente']),
              //                 overflow: TextOverflow.ellipsis,
              //                 style: TextStyle(
              //                     backgroundColor: Colors.black45,
              //                     fontSize: 18,
              //                     fontWeight: FontWeight.w500,
              //                     color: Colors.greenAccent),
              //               ),
              //               // GridTile(
              //               //   header: Text(
              //               //     data!['code'],
              //               //     style: TextStyle(
              //               //         fontSize: 16, fontWeight: FontWeight.w500),
              //               //   ),
              //               //
              //               //   // child: Column(
              //               //   //   mainAxisAlignment: MainAxisAlignment.start,
              //               //   //   crossAxisAlignment: CrossAxisAlignment.start,
              //               //   //   children: [
              //               //   //     SizedBox(
              //               //   //       height: 25,
              //               //   //     ),
              //               //   //     Text(
              //               //   //       data['model'].toString().toUpperCase(),
              //               //   //       //overflow: TextOverflow.ellipsis,
              //               //   //     ),
              //               //   //     Text(
              //               //   //       data['size'].toString(),
              //               //   //       style: TextStyle(color: Colors.blueGrey),
              //               //   //       // overflow: TextOverflow.ellipsis,
              //               //   //     ),
              //               //   //   ],
              //               //   // ),
              //               //   footer: Text(
              //               //     NumberFormat.currency(symbol: 'AED ', decimalDigits: 0)
              //               //         .format(data['prixVente']),
              //               //     overflow: TextOverflow.ellipsis,
              //               //     style: TextStyle(
              //               //         fontSize: 18,
              //               //         fontWeight: FontWeight.w500,
              //               //         color: Colors.green),
              //               //   ),
              //               //   child: CachedNetworkImage(
              //               //     imageUrl:
              //               //         'https://firebasestorage.googleapis.com/v0/b/adventure-eb4ca.appspot.com/o/tyres%2Ftyres%20(${int + 1}).jpg?alt=media&token=b3c6a2c0-c5ad-4433-95f2-60c42ebbc092',
              //               //     fit: BoxFit.cover,
              //               //     errorWidget: (context, url, error) => Image.network(
              //               //         'https://img1.wsimg.com/isteam/ip/d48b4882-6d43-4aed-ac22-2834c9891797/4.jpg/:/rs=w:1300,h:800'),
              //               //   ),
              //               // ),
              //             ],
              //           ),
              //         ],
              //       ),
              //       Text(
              //         data['model'].toString().toUpperCase(),
              //         //overflow: TextOverflow.ellipsis,
              //       ),
              //       Text(
              //         data['size'].toString(),
              //         style: TextStyle(color: Colors.blueGrey),
              //         // overflow: TextOverflow.ellipsis,
              //       ),
              //     ],
              //   ),
              // );
            }),
      ),
    );
  }

  openwhatsapp() async {
    var whatsapp = "+919144040888";
    var whatsappURl_android =
        "whatsapp://send?phone=" + whatsapp + "&text=hello";

    // android , web
    if (await canLaunch(whatsappURl_android)) {
      await launch(whatsappURl_android);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
    }
  }

  Future showDetailPublic(data, int) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Center(
            child: Text(
              'Item : ${data['model'].toString()}'.toUpperCase(),
              style: TextStyle(
                fontSize: 15,
                color: colorBlue, // Colors.orange,
              ),
            ),
          ),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'codebar : ${data['codebar'].toString()}'.toUpperCase(),
              ),
              CachedNetworkImage(
                imageUrl:
                    'https://firebasestorage.googleapis.com/v0/b/adventure-eb4ca.appspot.com/o/tyres%2Ftyres%20(${int + 1}).jpg?alt=media&token=b3c6a2c0-c5ad-4433-95f2-60c42ebbc092',
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => Image.network(
                    'https://img1.wsimg.com/isteam/ip/d48b4882-6d43-4aed-ac22-2834c9891797/4.jpg/:/rs=w:1300,h:800'),
              ),
              Text(
                'size : ${data['size'].toString()}'.toUpperCase(),
              ),
              Text(
                'origine : ${data['origine'].toString()}'.toUpperCase(),
              ),
              Text(
                NumberFormat.currency(symbol: 'AED ', decimalDigits: 2)
                    .format(data!['prixVente']),
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    //backgroundColor: Colors.black45,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.green,
                    fontFamily: 'oswald'),
              ),
              Text(
                'Description : ${data['description'].toString()}'.toUpperCase(),
              ),
            ],
          ),
          actions: [
            Center(
              child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(colorRed),
                    foregroundColor: MaterialStateProperty.all(colorGreen),
                    minimumSize: MaterialStateProperty.all(const Size(200, 50)),
                    shape: MaterialStateProperty.all(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero, //.circular(30),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: Text(
                    'Leave'.toUpperCase(),
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.red.shade100,
                    ),
                  )),
            )
          ],
        ),
      );
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
