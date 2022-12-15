import 'package:barcode_widget/barcode_widget.dart';
import 'package:dubai/ik/pdf/pdf_printing/pdfTa3List.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InvoiceDetail extends StatefulWidget {
  const InvoiceDetail({
    Key? key,
    required this.doc,
  }) : super(key: key);
  final doc;
  @override
  State<InvoiceDetail> createState() => _InvoiceDetailState();
}

class _InvoiceDetailState extends State<InvoiceDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Processing Data')),
              );
              Navigator.of(context)
                  .push(MaterialPageRoute(
                    builder: (context) => PdfPageTa3List(
                      array: widget.doc['item CodeBar'],
                      //dataDevis: widget.doc,
                      customer: widget.doc['customer'],
                      date: widget.doc['date'].toDate() ?? DateTime.now(),
                      codeDevis: widget.doc.id,
                    ),
                  ))
                  .whenComplete(() =>
                      debugPrint('is fiiiiiiiiiiiiiiiiiiiiiiiinishhhhhhhhhh'));
              //print(widget.doc['item CodeBar']);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Center(
          child: ListView(children: [
            Center(
              child: Text(
                'Invoice'.toUpperCase(),
                style: TextStyle(fontSize: 50),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: BarcodeWidget(
                  height: 50,
                  drawText: false,
                  data: widget.doc.id.toString(),
                  barcode: Barcode.code128()),
            ),
            Center(child: Text('Invoice N° : ' + widget.doc.id.toUpperCase())),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'HT ' +
                      NumberFormat.currency(symbol: '')
                          .format(widget.doc['total']),
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'B ' +
                      NumberFormat.currency(symbol: '')
                          .format(widget.doc['benef']),
                  style: TextStyle(color: Colors.green, fontSize: 20),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Text('Customer : ' +
                widget.doc['customer'].toString().toUpperCase()),
            Text('Date : ' +
                widget.doc['date'].toDate().toString().toUpperCase()),
            Divider(
              thickness: 1,
            ),
            ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.doc['item CodeBar'].length,
              itemBuilder: (BuildContext context, int index) {
                var array = widget.doc['item CodeBar'];
                return Center(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Center(
                            child: Text(
                              array[index]['qty'].toString(),
                              style: TextStyle(fontSize: 32),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 12,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.doc['item CodeBar'][index]['codebar']
                                    .toString(),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(array[index]['model'].toString(),
                                  overflow: TextOverflow.ellipsis),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Unit Price : ' +
                                      NumberFormat.currency(symbol: '')
                                          .format(array[index]['prixVente'])),
                                  Text('Amount : ' +
                                      NumberFormat.currency(symbol: '').format(
                                          (array[index]['prixVente'] *
                                              array[index]['qty']))),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(
                thickness: 1,
              ),
            ),
            Divider(
              thickness: 1,
            ),
            Container(
              alignment: Alignment.centerRight,
              child: Text(
                'Total : ' +
                    NumberFormat.currency(symbol: '')
                        .format(widget.doc['total']),
                style: TextStyle(fontSize: 18),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              child: Text(
                'Vat 20% : ' +
                    NumberFormat.currency(symbol: '')
                        .format((widget.doc['total'] * 0.2))
                        .toString(),
                style: TextStyle(fontSize: 12),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              child: Text('TTC : ' +
                  NumberFormat.currency(symbol: '')
                      .format(widget.doc['total'] * 1.2)),
            ),
            Container(
              alignment: Alignment.centerRight,
              child: Text(
                'Benef : ' +
                    NumberFormat.currency(symbol: '')
                        .format(widget.doc['benef']),
                style: TextStyle(color: Colors.green),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
