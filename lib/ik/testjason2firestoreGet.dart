import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:paginate_firestore/widgets/bottom_loader.dart';
import 'package:paginate_firestore/widgets/empty_display.dart';
import 'package:paginate_firestore/widgets/empty_separator.dart';
import 'package:paginate_firestore/widgets/initial_loader.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'Estimate.dart';
import 'QrScanner.dart';
import 'invoiceList.dart';
import 'pdf/chargesList.dart';

class mainPageFirestoreGetik extends StatefulWidget {
  const mainPageFirestoreGetik({Key? key}) : super(key: key);

  @override
  State<mainPageFirestoreGetik> createState() => _mainPageFirestoreGetikState();
}

class _mainPageFirestoreGetikState extends State<mainPageFirestoreGetik> {
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _sizeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  final TextEditingController _prixAchatController = TextEditingController();
  final TextEditingController _prixVenteController = TextEditingController();
  final TextEditingController _origineController = TextEditingController();

  final TextEditingController _userController = TextEditingController();
  final TextEditingController _codeController = new TextEditingController()
    ..text; // = data{'code'};
  final TextEditingController _oldStockController = TextEditingController();
  final TextEditingController _codebarController = TextEditingController();

  late TextTheme textTheme;
  final navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<FormState> _formKeyQty = GlobalKey<FormState>();
  final TextEditingController _qtyController =
      TextEditingController(text: '01');

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
        leading: IconButton(
          icon: const Icon(Icons.qr_code),
          onPressed: () {
            // int itemcount = code.length;
            // uploadItems(itemcount);
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  // MainPageik(),
                  qrScannerik(),
            ));
          },
        ),
        actions: [
          // IconButton(
          //   icon: const Icon(Icons.home),
          //   onPressed: () {
          //     // int itemcount = code.length;
          //     // uploadItems(itemcount);
          //     Navigator.of(context).push(MaterialPageRoute(
          //       builder: (context) => MainPageik(),
          //     ));
          //   },
          // ),
          IconButton(
            icon: const Icon(Icons.incomplete_circle),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => chargeList(),
              ));
            },
          ),
          IconButton(
            icon: const Icon(Icons.face),
            onPressed: () {
              // int itemcount = code.length;
              // uploadItems(itemcount);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => invoiceList(),
              ));
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const estimateik(),
                  ));
                },
                icon: const Icon(Icons.add_shopping_cart)),
          ),
        ],
      ),
      body: PaginateFirestore(
          header: SLiverHeader(
              colorGreen: colorGreen,
              colorOrange: colorOrange,
              colorRed: colorRed),
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
            return GestureDetector(
              onTap: () async {
                if (data['stock'] == 0) {
                  await AlertD();
                } else {
                  await addToDevisDialog(dataid, data);
                }
              },
              child: Slidable(
                key: const Key('keyslidable'),
                startActionPane: ActionPane(
                  // A motion is a widget used to control how the pane animates.
                  motion: const StretchMotion(),

                  // A pane can dismiss the Slidable.
                  //dismissible: DismissiblePane(onDismissed: () {}),//******************* */

                  // All actions are defined in the children parameter.
                  children: [
                    // A SlidableAction can have an icon and/or a label.
                    SlidableAction(
                      onPressed: (Context) => _upDate(dataid, data!),
                      backgroundColor: color3,
                      // Colors.orange,
                      foregroundColor: Colors.white,
                      icon: Icons.edit,
                      label: 'Edit',
                    ),
                  ],
                ),
                endActionPane: ActionPane(
                  motion: const StretchMotion(),
                  children: [
                    SlidableAction(
                      // An action can be bigger than the others.
                      flex: 2,
                      onPressed: (Context) async {
                        await showAlertDialog(context, data, dataid);
                      },
                      backgroundColor: colorRed,
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                  ],
                ),
                child: Center(
                  child: Card(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                            child: Stack(
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
                                        data['stock'].toString().toUpperCase(),
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
                                  percent: data['stock'] > data['oldStock']
                                      ? 1
                                      : data['stock'] / data['oldStock'],
                                  progressColor: colorGreen,
                                  backgroundColor: colorRed,
                                  radius: 26.0,
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
                                    percent: data['stock'] > data['oldStock']
                                        ? 1
                                        : data['stock'] / data['oldStock'],
                                    // center: Text(
                                    //   NumberFormat.currency(
                                    //               symbol: '', decimalDigits: 0)
                                    //           .format((data['stock'] *
                                    //               100 /
                                    //               data['oldStock'])) +
                                    //       '%',
                                    //   style: TextStyle(),
                                    // ),
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
                                  NumberFormat.currency(symbol: '')
                                      .format(data['prixVente']),
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  NumberFormat.currency(symbol: '')
                                      .format(data['prixVente'] * 0.8),
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: colorGreen),
                                ),
                                Text(
                                  NumberFormat.currency(symbol: '')
                                      .format(data['prixAchat']),
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: colorRed),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  Future addToEstimateDialog(String dataid, Map data) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Center(
            child: FittedBox(
              child: Text(
                'Item : ${data['model'].toString()}'.toUpperCase(),
                style: TextStyle(
                  color: Colors.blue, // Colors.orange,
                ),
              ),
            ),
          ),
          actions: [
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (!_formKeyQty.currentState!.validate()) {
                      return;
                    } else {
                      //  setState(() {
                      addItemsToDevis2(
                        dataid,
                        data,
                        _qtyController.text,
                      );
                      //_qtyController.clear();
                      // });
                    }

                    Navigator.pop(context, false);
                  },
                  child: Text(
                    'Add to Estimate'.toUpperCase(),
                    style: const TextStyle(fontSize: 15, color: Colors.black54),
                  )),
            )
          ],
          content: Form(
            key: _formKeyQty,
            child: TextFormField(
              autofocus: true,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 25,
              ),
              keyboardType: TextInputType.number,
              controller: _qtyController,
              validator: (valueQty) => valueQty!.isEmpty ||
                      valueQty == null ||
                      int.tryParse(valueQty.toString()) == 0
                  ? 'Cant be 0 or Empty'
                  : null,
              decoration: const InputDecoration(
                border: InputBorder.none,
                filled: true,
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),

                hintText: 'Quantity',
                fillColor: Colors.white,
                //filled: true,
              ),
            ),
          ), // availibility,
        ),
      );

  Future addToDevisDialog(dataid, data) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Center(
            child: FittedBox(
              child: data['stock'] <= 5
                  ? data['stock'] != 0
                      ? Text(
                          'Item : ${data['model'].toString()}\n Left-Over : ${data['stock'].toString()}'
                              .toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: colorOrange, // Colors.orange,
                          ),
                        )
                      : Text(
                          'Item : ${data['model'].toString()}'.toUpperCase(),
                          style: TextStyle(
                            color: colorRed, // Colors.orange,
                          ),
                        )
                  : Text(
                      'Item : ${data['model'].toString()}'.toUpperCase(),
                      style: TextStyle(
                        color: colorBlue, // Colors.orange,
                      ),
                    ),
            ),
          ),
          actions: [
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (!_formKeyQty.currentState!.validate()) {
                      return;
                    } else if (data['stock'] >=
                        int.parse(_qtyController.text)) {
                      // FirebaseFirestore.instance
                      //     .collection('Market')
                      //     .doc(dataid)
                      //     .update({
                      //   'stock': FieldValue.increment(
                      //       -int.parse(_qtyController.text))
                      // });
                      // setState(() {
                      addItemsToDevis2(dataid, data, _qtyController.text);
                      _qtyController.clear();
                      // });
                    } else {
                      return;
                    }
                    Navigator.pop(context, false);
                  },
                  child: Text(
                    'Add to Estimate'.toUpperCase(),
                    style: const TextStyle(fontSize: 15, color: Colors.black54),
                  )),
            )
          ],
          content: Form(
            key: _formKeyQty,
            child: TextFormField(
              autofocus: true,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 25,
              ),
              keyboardType: TextInputType.number,
              controller: _qtyController,
              validator: (valueQty) => valueQty!.isEmpty ||
                      valueQty == null ||
                      int.tryParse(valueQty.toString()) == 0
                  ? 'Cant be 0 or Empty'
                  : null,
              decoration: const InputDecoration(
                border: InputBorder.none,
                filled: true,
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),

                hintText: 'Quantity',
                fillColor: Colors.white,
                //filled: true,
              ),
            ),
          ),
        ),
      );

  Future AlertD() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            backgroundColor: Colors.red.shade200,
            title: Center(
              child: Text(
                'alert!!!'.toUpperCase(),
                style: TextStyle(
                  color: colorRed,
                ),
              ),
            ),
            actions: [
              Center(
                child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(colorRed),
                      foregroundColor: MaterialStateProperty.all(colorGreen),
                      minimumSize:
                          MaterialStateProperty.all(const Size(200, 50)),
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
                      'Cancel'.toUpperCase(),
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.red.shade100,
                      ),
                    )),
              )
            ],
            content: Text(
              'out of stock'.toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, color: colorRed),
            ),
          ));

  Future<void> addItemsToDevis2(dataid, data, qty) async {
    CollectionReference devisitem =
        FirebaseFirestore.instance.collection('Estimate');

    CollectionReference incrementQty =
        FirebaseFirestore.instance.collection('Adventure');

    DocumentSnapshot<Map<String?, dynamic>> document = await FirebaseFirestore
        .instance
        .collection('Estimate')
        .doc(dataid)
        .get();

    if (!document.exists) {
      return devisitem
          .doc(dataid)
          .set({
            'createdAt': Timestamp.now().toDate(),
            'category': data['category'],
            'model': data['model'],
            'description': data['description'],
            'size': data['size'],
            'prixAchat': data['prixAchat'],
            'prixVente': data['prixVente'],
            'prixDealer': data['prixDealer'],
            'stock': data['stock'],
            'codebar': data['codebar'],
            'oldStock': data['oldStock'],
            'origine': data['origine'],
            'user': data['user'],
            'qty': int.parse(qty),
          }, SetOptions(merge: true))
          .then((value) => print("Item Added to Devis"))
          .catchError((error) => print("Failed to add Item to Devis: $error"))
          .whenComplete(() => incrementQty
              .doc(dataid)
              .update({'stock': FieldValue.increment(-int.parse(qty))}));
    } else {
      print('kayen deja/////////////////////');
      return devisitem
          .doc(dataid)
          .update({'qty': FieldValue.increment(int.parse(qty))})
          .then((value) => print("Item update to Estimate"))
          .catchError(
              (error) => print("Failed to update Item to Estimate: $error"))
          .whenComplete(() => incrementQty
              .doc(dataid)
              .update({'stock': FieldValue.increment(-int.parse(qty))}))
          .then((value) =>
              print('**********************************update c bon'));
    }
  }

  Future<void> _upDate(String dataid, Map data) async {
    if (data != null) {
      _codeController.text = data['code'];
      _codebarController.text = data['codebar'];
      _categoryController.text = data['category'];
      _modelController.text = data['model'];
      _descriptionController.text = data['description'];
      _sizeController.text = data['size'];
      _stockController.text = data['stock'].toString();
      _prixAchatController.text = data['prixAchat'].toString();
      _prixVenteController.text = data['prixVente'].toString();
      _origineController.text = data['origine'].toString();
      _oldStockController.text = data['oldStock'].toString();
      _userController.text = data['user']; //.toString();
    }
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: ListView(
              children: [
                Container(
                    height: MediaQuery.of(context).size.width * .7,
                    child: Lottie.asset('assets/123750-creepy-cat.json')),
                Center(
                  child: Text(
                    dataid.toUpperCase().toString(),
                  ),
                ),
                TextField(
                  scribbleEnabled: true,
                  controller: _codeController,
                  decoration: const InputDecoration(
                    label: Text('code'),
                  ),
                ),
                TextField(
                  controller: _codebarController,
                  decoration: const InputDecoration(
                    label: Text('CodeBar'),
                  ),
                ),
                TextField(
                  controller: _categoryController,
                  decoration: const InputDecoration(
                    label: Text('Category'),
                  ),
                ),
                TextField(
                  controller: _modelController,
                  decoration: const InputDecoration(
                    label: Text('Model'),
                  ),
                ),
                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    label: Text('Description'),
                  ),
                ),
                TextField(
                  controller: _sizeController,
                  decoration: const InputDecoration(
                    label: Text('Size'),
                  ),
                ),
                TextField(
                  controller: _stockController,
                  decoration: const InputDecoration(
                    label: Text('Stock'),
                  ),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _prixAchatController,
                  decoration: const InputDecoration(
                    label: Text('Factory Price'),
                  ),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _prixVenteController,
                  decoration: const InputDecoration(
                    label: Text('Retail Price'),
                  ),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _origineController,
                  decoration: const InputDecoration(
                    label: Text('Origine'),
                  ),
                ),
                TextField(
                  controller: _oldStockController,
                  decoration: const InputDecoration(
                    label: Text('oldStock'),
                  ),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _userController,
                  decoration: const InputDecoration(
                    label: Text('User'),
                  ),
                  keyboardType: TextInputType.text,
                ),
                ElevatedButton(
                    onPressed: () async {
                      final String _code = _codeController.text;
                      final String _codebar = _codebarController.text;
                      final String _category = _categoryController.text;
                      final String _model = _modelController.text;
                      final String _description = _descriptionController.text;
                      final String _size = _sizeController.text;
                      final int _stock = int.parse(_stockController.text);
                      final double _prixAchat =
                          double.parse(_prixAchatController.text);

                      final double _prixVente =
                          double.parse(_prixVenteController.text);
                      final int _oldStock = int.parse(_oldStockController.text);
                      final String _user = _userController.text;
                      final String _origine = _origineController.text;

                      //final double _price =  double.tryParse(_priceController.text);
                      //if (dealer != null) {
                      await FirebaseFirestore.instance
                          .collection('Adventure')
                          .doc(dataid)
                          .update({
                        'code': _code,
                        'codebar': _codebar,
                        'category': _category,
                        'model': _model,
                        'description': _description,
                        'size': _size,
                        'stock': _stock,
                        'prixAchat': _prixAchat,
                        'prixVente': _prixVente,
                        'oldStock': _oldStock,
                        'user': _user,
                        'origine': _origine,
                      });
                      // _codeController.text = '';
                      // _codebarController.text = '';
                      // _categoryController.text = '';
                      // _modelController.text = '';
                      // _descriptionController.text = '';
                      // _sizeController.text = '';
                      // _stockController.text = '';
                      // _prixAchatController.text = '';
                      // _prixVenteController.text = '';
                      // _oldStockController.text = '';
                      // _userController.text = '';
                      // _origineController.text = '';
                      //}

                      // Navigator.of(context).pop();
                      Navigator.of(context, rootNavigator: true).pop();
                      // setState(() {
                      //   data.clear();
                      // });
                    },
                    child: Text(
                      'Update'.toUpperCase(),
                    )),
              ],
            ),
          );
        });
  }
}

class SLiverHeader extends StatelessWidget {
  const SLiverHeader({
    Key? key,
    required this.colorGreen,
    required this.colorOrange,
    required this.colorRed,
  }) : super(key: key);

  final Color colorGreen;
  final Color colorOrange;
  final Color colorRed;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 10,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Adventure') //.get(),
                      .snapshots(),
                  builder: (BuildContext context, snapshot) {
                    // if (snapshot.connectionState == ConnectionState.waiting) {
                    //   return Container(); //CircularProgressIndicator();
                    // } else
                    // if (snapshot.connectionState == ConnectionState.active ||
                    //     snapshot.connectionState == ConnectionState.done)
                    {
                      if (snapshot.hasError) {
                        return const Text('Error');
                      } else if (snapshot.hasData) {
                        var data = snapshot.data!.docs;

                        final List<DocumentSnapshot> min5 = data
                            .where((DocumentSnapshot documentSnapshot) =>
                                documentSnapshot['stock'] <= 5 &&
                                documentSnapshot['stock'] > 0)
                            .toList();
                        final int count5 = min5.length;
                        print(count5);
                        final List<DocumentSnapshot> min0 = data
                            .where((DocumentSnapshot documentSnapshot) =>
                                documentSnapshot['stock'] == 0)
                            .toList();
                        final int count0 = min0.length;
                        print(count0);
                        return ListView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      'Total'.toUpperCase().trim(),
                                    ),
                                    Text(
                                      data.length.toString(),
                                      style: TextStyle(
                                        fontSize: 30.0,
                                      ),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => StockPage(
                                          pageQuery: FirebaseFirestore.instance
                                              .collection('Adventure')
                                              .where('stock',
                                                  isGreaterThan: 0)),
                                    ));
                                  },
                                  child: Column(
                                    children: [
                                      Text(
                                        'Stock'.toUpperCase().trim(),
                                        style: TextStyle(color: colorGreen),
                                      ),
                                      Text(
                                        (data.length - count0).toString(),
                                        style: TextStyle(
                                            color: colorGreen, fontSize: 30),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => StockPage(
                                          pageQuery: FirebaseFirestore.instance
                                              .collection('Adventure')
                                              .where('stock', isGreaterThan: 0)
                                              .where('stock',
                                                  isLessThanOrEqualTo: 5)),
                                    ));
                                  },
                                  child: Column(
                                    children: [
                                      Text(
                                        'Alert'.toUpperCase().trim(),
                                        style: TextStyle(color: colorOrange),
                                      ),
                                      Text(
                                        count5.toString(),
                                        style: TextStyle(
                                            color: colorOrange, fontSize: 30),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => StockPage(
                                          pageQuery: FirebaseFirestore.instance
                                              .collection('Adventure')
                                              .where('stock',
                                                  isLessThanOrEqualTo: 0)),
                                    ));
                                  },
                                  child: Column(
                                    children: [
                                      Text(
                                        'Out'.toUpperCase().trim(),
                                        style: TextStyle(color: colorRed),
                                      ),
                                      Text(
                                        count0.toString(),
                                        style: TextStyle(
                                            color: colorRed, fontSize: 30),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      } else {
                        return const Text('Empty data');
                      }
                    }
                    // else {
                    //   return Text('State: ${snapshot.connectionState}');
                    // }
                  }),
            ),
          ),
        ],
      ),
    );
  }
}

showAlertDialog(BuildContext context, data, dataid) {
  // set up the buttons
  Widget cancelButton = ElevatedButton(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Colors.white),
    ),
    child: Text(
      "Cancel",
      style: TextStyle(color: Colors.red),
    ),
    onPressed: () => Navigator.pop(context, false),
  );
  Widget continueButton = TextButton(
    child: Text(
      "I'm Sure to Remove it",
      style: TextStyle(color: Colors.white, fontSize: 10),
    ),
    //child: Text("Delete"),
    onPressed: () {
      FirebaseFirestore.instance.collection('Adventure').doc(dataid).delete();
      // .update({'stock': FieldValue.increment(data['qty'])}).whenComplete(
      //     () => FirebaseFirestore.instance
      //         .collection('Estimate') //.collection('cart')
      //         .doc(data.id)
      //         .delete());

      Navigator.pop(context, true);
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    actionsAlignment: MainAxisAlignment.spaceAround,
    backgroundColor: Colors.red,
    title: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          FittedBox(
            child: Text(
              'Code : ' + dataid,
              style: TextStyle(fontFamily: 'Oswald', color: Colors.white),
            ),
          ),
          Text(
            data['model'],
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'Oswald', color: Colors.white, fontSize: 15),
          ),
        ],
      ),
    ),
    content: Text(
      "Would you like to continue\nto deleting this item?".toUpperCase(),
      textAlign: TextAlign.center,
      style: TextStyle(fontFamily: 'Oswald', color: Colors.white, fontSize: 18),
    ),
    actions: [
      cancelButton,
      continueButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  ).then((exit) {
    if (exit == null) return;

    if (exit) {
      // user pressed Yes button
    } else {
      // user pressed No button
    }
  });
}

class StockPage extends StatelessWidget {
  StockPage({
    Key? key,
    required this.pageQuery,
  }) : super(key: key);

  final pageQuery;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PaginateFirestore(
        itemsPerPage: 10000,
        onEmpty: const EmptyDisplay(),
        separator: const EmptySeparator(),
        initialLoader: const InitialLoader(),
        // bottomLoader: const BottomLoader(),
        shrinkWrap: true,
        isLive: true,

        itemBuilderType: PaginateBuilderType.listView,
        query: pageQuery,
        itemBuilder: (BuildContext, DocumentSnapshot, int) {
          var data = DocumentSnapshot[int].data() as Map?;
          String dataid = DocumentSnapshot[int].id;
          return Card(
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: data!['stock'] <= 5
                              ? data['stock'] != 0
                                  ? Colors.green
                                  : Colors.red
                              : null,
                          radius: 25,
                          child: FittedBox(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                data['stock'].toString().toUpperCase(),
                                style: TextStyle(
                                    color: data['stock'] <= 5
                                        ? data['stock'] != 0
                                            ? Colors.red
                                            : Colors.white
                                        : Colors.white,
                                    fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                        CircularPercentIndicator(
                          animation: true,
                          animationDuration: 1000,
                          percent: data['stock'] > data['oldStock']
                              ? 1
                              : data['stock'] / data['oldStock'],
                          progressColor: Colors.greenAccent,
                          backgroundColor: Colors.red,
                          radius: 26.0,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Padding(
                    padding: EdgeInsets.all(10), //.fromLTRB(15, 10, 0, 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data['model'].toString(),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          data['size'].toString(),
                          overflow: TextOverflow.ellipsis,
                        ),
                        FittedBox(
                          child: LinearPercentIndicator(
                            trailing: Text(
                              (data['stock'] * 100 / data['oldStock'])
                                      .toString() +
                                  '%',
                              style: TextStyle(fontSize: 25),
                            ),
                            width: MediaQuery.of(context).size.width,
                            animation: true,
                            lineHeight: 25.0,
                            animationDuration: 1000,
                            percent: data['stock'] > data['oldStock']
                                ? 1
                                : data['stock'] / data['oldStock'],
                            center: Text(
                              (data['stock'] * 100 / data['oldStock'])
                                      .toString() +
                                  '%',
                              style: TextStyle(),
                            ),
                            barRadius: Radius.circular(20.0),
                            progressColor: Colors.greenAccent,
                            backgroundColor: Colors.red,
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
                          NumberFormat.currency(symbol: '')
                              .format(data['prixVente']),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          NumberFormat.currency(symbol: '')
                              .format(data['prixVente'] * 0.8),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.blueGrey),
                        ),
                        Text(
                          NumberFormat.currency(symbol: '')
                              .format(data['prixAchat'] * 3.68),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.blueGrey),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        //footer: Text('finish'),
      ),
    );
  }
}
