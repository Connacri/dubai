import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class AddingCharges extends StatefulWidget {
  AddingCharges({
    Key? key,
    // required this.code,
  }) : super(key: key);

  @override
  State<AddingCharges> createState() => _AddingChargesState();
}

class _AddingChargesState extends State<AddingCharges> {
  // final String code;
  final TextEditingController _typeController = TextEditingController();

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _deadlineController =
      TextEditingController(text: 'null');
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController dateinput = TextEditingController();
  final _formKeyPneux = GlobalKey<FormState>();
  late String dropdownValue;

  bool isVisible = false;
  @override
  void initState() {
    _dateController.text = DateFormat('yyyy-MM-dd')
        .format(DateTime.now()); //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //leading: Icon(Icons.add_box_outlined),
        title: Text('Adding Product'),
      ),
      body: Form(
        key: _formKeyPneux,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: ListView(
            children: [
              Lottie.asset('assets/lotties/54355-motorcycle-loading.json'),
              TextFormField(
                autofocus: true,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25,
                ),
                keyboardType: TextInputType.text,
                controller: _modelController,
                validator: (value) => value!.isEmpty ||
                        value == null ||
                        int.tryParse(value.toString()) == 0
                    ? 'Cant be Empty'
                    : null,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),

                  hintText: 'Description Charge',
                  fillColor: Colors.white,
                  //filled: true,
                ),
              ),
              Divider(),
              TextFormField(
                controller: _dateController,
                //editing controller of this TextField
                style: const TextStyle(
                  fontSize: 25,
                ),
                autofocus: true,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),

                  hintText: 'Select Date',
                  fillColor: Colors.white,
                  //filled: true,
                ),
                readOnly: true,
                //set it true, so that user will not able to edit text
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101));

                  if (pickedDate != null) {
                    print(
                        pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    print(
                        formattedDate); //formatted date output using intl package =>  2021-03-16

                    setState(() {
                      var datepass = pickedDate;
                      _dateController.text =
                          formattedDate; //set output date to TextField value.
                    });
                  } else {
                    print("Date is not selected");
                  }
                },
              ),
              Divider(),
              TextFormField(
                autofocus: true,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25,
                ),
                keyboardType: TextInputType.number,
                controller: _amountController,
                validator: (value) => value!.isEmpty ||
                        value == null ||
                        int.tryParse(value.toString()) == 0
                    ? 'Cant be Empty'
                    : null,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  hintText: 'Amount',
                  fillColor: Colors.white,
                ),
              ),
              Divider(),
              DropdownButtonFormField(
                isDense: false,
                // itemHeight: 60,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  hintText: 'Amount',
                  fillColor: Colors.white,
                ),
                isExpanded: true,
                validator: (value) => value!.isEmpty ||
                        value == null ||
                        int.tryParse(value.toString()) == 0
                    ? 'Cant be Empty'
                    : null,
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.black54,
                    fontFamily: 'oswald',
                    fontWeight: FontWeight.w500),

                hint: Text(
                  'Charge Type',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.black54,
                    fontFamily: 'oswald',
                  ),
                ),
                alignment: Alignment.center,
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                  dropdownValue == 'One Time'
                      ? isVisible = true
                      : isVisible = false;
                },
                items: <String>[
                  'One Time',
                  'Daily',
                  'Monthly',
                  'Annual',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    alignment: Alignment.center,
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 20),
                    ),
                  );
                }).toList(),
              ),
              Divider(),
              Visibility(
                visible: isVisible,
                child: TextFormField(
                  autofocus: true,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 25,
                  ),
                  keyboardType: TextInputType.number,
                  controller: _deadlineController,
                  validator: (value) => value!.isEmpty ||
                          value == null ||
                          int.tryParse(value.toString()) == 0
                      ? 'Cant be Empty'
                      : null,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    filled: true,
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    hintText: 'Deadline (Days)',
                    fillColor: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black45),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    fixedSize: MaterialStateProperty.all(Size.fromWidth(30)),
                  ),
                  onPressed: () async {
                    if (_formKeyPneux.currentState!.validate()) {
                      await AddCharges().whenComplete(() {
                        Navigator.pop(context);
                        //Navigator.of(context, rootNavigator: true).pop();
                      });
                    }
                  },
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> AddCharges() async {
    CollectionReference ItemDetail =
        FirebaseFirestore.instance.collection('Charges');
    return ItemDetail.doc()
        .set({
          'createdAt': Timestamp.now().toDate(),
          'model': _modelController.text,
          'date': DateTime.parse(_dateController.text),
          'amount': double.parse(_amountController.text),
          'deadline': int.parse(_deadlineController.text),
          'type': //_typeController.text,
              dropdownValue,
        }, SetOptions(merge: true))
        .then((value) => print("Item Added"))
        .catchError((error) => print("Failed to Add: $error"));
    // .whenComplete(() => PriceDealer.doc().set({
    //       'price': int.parse(_saleController.text),
    //       'dealerName': _dealerNameController.text,
    //     }, SetOptions(merge: true)));
  }
}
