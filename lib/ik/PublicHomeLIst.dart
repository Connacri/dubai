import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:paginate_firestore/widgets/bottom_loader.dart';
import 'package:paginate_firestore/widgets/empty_display.dart';
import 'package:paginate_firestore/widgets/empty_separator.dart';
import 'package:paginate_firestore/widgets/initial_loader.dart';
import 'package:percent_indicator/percent_indicator.dart';

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
      body: PaginateFirestore(
          header: SliverToBoxAdapter(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  height: 30,
                  width: 20,
                  color: Colors.deepOrangeAccent,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  height: 30,
                  width: 20,
                  color: Colors.blueGrey,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  height: 30,
                  width: 20,
                  color: Colors.green,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  height: 30,
                  width: 20,
                  color: Colors.red,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  height: 30,
                  width: 20,
                  color: Colors.black,
                ),
              ],
            ),
          ),
          itemsPerPage: 10000,
          onEmpty: const EmptyDisplay(),
          separator: const EmptySeparator(),
          initialLoader: const InitialLoader(),
          bottomLoader: const BottomLoader(),
          shrinkWrap: true,
          isLive: true,
          itemBuilderType: PaginateBuilderType.listView,
          query: FirebaseFirestore.instance.collection('Adventure'),
          //.orderBy('createdAt', descending: true),
          itemBuilder: (BuildContext, DocumentSnapshot, int) {
            var data = DocumentSnapshot[int].data() as Map?;
            String dataid = DocumentSnapshot[int].id;

            return Column(
              children: [
                Center(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                          child: Column(
                            children: [
                              Stack(
                                alignment: AlignmentDirectional.center,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: data!['stock'] <= 5
                                        ? data['stock'] != 0
                                            ? colorOrange
                                            : colorRed
                                        : colorBlue,
                                    radius: 25,
                                    child: FittedBox(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          data['stock']
                                              .toString()
                                              .toUpperCase(),
                                          style: TextStyle(
                                              color: data['stock'] <= 5
                                                  ? data['stock'] != 0
                                                      ? Colors.black54
                                                      : Colors.white
                                                  : Colors.white,
                                              fontSize: 20),
                                        ),
                                      ),
                                    ),
                                  ),
                                  CircularPercentIndicator(
                                    circularStrokeCap: CircularStrokeCap.round,
                                    lineWidth: 6.0,
                                    backgroundWidth: 3.0,
                                    animation: true,
                                    animationDuration: 1000,
                                    percent: data['stock'] > data['oldStock'] ||
                                            data['stock'] < 0
                                        ? 1
                                        : data['stock'] / data['oldStock'],
                                    progressColor: colorGreen,
                                    backgroundColor: colorRed,
                                    radius: 26.0,
                                  ),
                                ],
                              ),
                              Text(
                                data['code'],
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 8,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          //.fromLTRB(15, 10, 0, 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data['model'].toString().toUpperCase(),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                data['size'].toString(),
                                overflow: TextOverflow.ellipsis,
                              ),
                              FittedBox(
                                child: LinearPercentIndicator(
                                  trailing: Text(
                                    NumberFormat.currency(
                                                symbol: '', decimalDigits: 0)
                                            .format((data['stock'] *
                                                100 /
                                                data['oldStock'])) +
                                        '%',
                                    style: TextStyle(fontSize: 25),
                                  ),
                                  width: MediaQuery.of(context).size.width,
                                  animation: true,
                                  lineHeight: 25.0,
                                  animationDuration: 1000,
                                  percent: data['stock'] > data['oldStock'] ||
                                          data['stock'] < 0
                                      ? 1
                                      : data['stock'] / data['oldStock'],
                                  barRadius: Radius.circular(20.0),
                                  progressColor: colorGreen,
                                  backgroundColor: colorRed,
                                  restartAnimation: false,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                NumberFormat.currency(symbol: ' ')
                                    .format(data['prixVente']),
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),
              ],
            );
          }),
    );
  }
}
