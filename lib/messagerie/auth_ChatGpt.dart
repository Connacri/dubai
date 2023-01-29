// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_database/ui/firebase_animated_list.dart';
//
// void mainChat() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   Firebase.initializeApp();
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const ChatScreen(),
//     );
//   }
// }
//
//
// class ChatScreen extends StatefulWidget {
//   const ChatScreen({Key? key}) : super(key: key);
//
//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }
//
// class _ChatScreenState extends State<ChatScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Flutter Firebase'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             const Image(
//               width: 300,
//               height: 300,
//               image: NetworkImage(
//                   'https://seeklogo.com/images/F/firebase-logo-402F407EE0-seeklogo.com.png'),
//             ),
//             const SizedBox(
//               height: 30,
//             ),
//             const Text(
//               'Firebase Realtime Database Series in Flutter 2022',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.w500,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(
//               height: 30,
//             ),
//             MaterialButton(
//               onPressed: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const InsertData()));
//               },
//               child: const Text('Insert Data'),
//               color: Colors.blue,
//               textColor: Colors.white,
//               minWidth: 300,
//               height: 40,
//             ),
//             const SizedBox(
//               height: 30,
//             ),
//             MaterialButton(
//               onPressed: () {
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => const FetchData()));
//               },
//               child: const Text('Fetch Data'),
//               color: Colors.blue,
//               textColor: Colors.white,
//               minWidth: 300,
//               height: 40,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
// class InsertData extends StatefulWidget {
//   const InsertData({Key? key}) : super(key: key);
//
//   @override
//   State<InsertData> createState() => _InsertDataState();
// }
//
// class _InsertDataState extends State<InsertData> {
//
//   final  userNameController = TextEditingController();
//   final  userAgeController= TextEditingController();
//   final  userSalaryController =TextEditingController();
//
//   late DatabaseReference dbRef;
//
//   @override
//   void initState() {
//     super.initState();
//     dbRef = FirebaseDatabase.instance.ref().child('Students');
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Inserting data'),
//       ),
//       body: Center(
//         child: Padding(
//           padding: EdgeInsets.all(8.0),
//           child: Column(
//             children: [
//               const SizedBox(
//                 height: 50,
//               ),
//               const Text(
//                 'Inserting data in Firebase Realtime Database',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.w500,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               TextField(
//                 controller: userNameController,
//                 keyboardType: TextInputType.text,
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'Name',
//                   hintText: 'Enter Your Name',
//                 ),
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               TextField(
//                 controller: userAgeController,
//                 keyboardType: TextInputType.number,
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'Age',
//                   hintText: 'Enter Your Age',
//                 ),
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               TextField(
//                 controller: userSalaryController,
//                 keyboardType: TextInputType.phone,
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'Salary',
//                   hintText: 'Enter Your Salary',
//                 ),
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               MaterialButton(
//                 onPressed: () {
//                   Map<String, String> students = {
//                     'name': userNameController.text,
//                     'age': userAgeController.text,
//                     'salary': userSalaryController.text
//                   };
//                   print('process to adding');
//                   dbRef.push().set(students).whenComplete(() => print('studemnt added'));
//
//                 },
//                 child: const Text('Insert Data'),
//                 color: Colors.blue,
//                 textColor: Colors.white,
//                 minWidth: 300,
//                 height: 40,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
//
//
//
//
// class FetchData extends StatefulWidget {
//   const FetchData({Key? key}) : super(key: key);
//
//   @override
//   State<FetchData> createState() => _FetchDataState();
// }
//
// class _FetchDataState extends State<FetchData> {
//
//   Query dbRef = FirebaseDatabase.instance.ref().child('items_varicom');
//   DatabaseReference reference = FirebaseDatabase.instance.ref().child('items_varicom');
//
//   Widget listItem({required Map student}) {
//     return Container(
//       margin: const EdgeInsets.all(10),
//       padding: const EdgeInsets.all(10),
//       height: 110,
//       color: Colors.amberAccent,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             student['code'],
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
//           ),
//           const SizedBox(
//             height: 5,
//           ),
//           Text(
//             student['item'],
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
//           ),
//           const SizedBox(
//             height: 5,
//           ),
//           Text(
//             student['price'],
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               GestureDetector(
//                 onTap: () {
//                   Navigator.push(context, MaterialPageRoute(builder: (_) => UpdateRecord(studentKey: student['key'])));
//                 },
//                 child: Row(
//                   children: [
//                     Icon(
//                       Icons.edit,
//                       color: Theme.of(context).primaryColor,
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 width: 6,
//               ),
//               GestureDetector(
//                 onTap: () {
//                   reference.child(student['key']).remove();
//                 },
//                 child: Row(
//                   children: [
//                     Icon(
//                       Icons.delete,
//                       color: Colors.red[700],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Fetching data'),
//         ),
//         body: Container(
//           height: double.infinity,
//           child: FirebaseAnimatedList(
//             query: dbRef,
//             itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
//
//               Map student = snapshot.value as Map;
//               student['key'] = snapshot.key;
//
//               return listItem(student: student);
//
//             },
//           ),
//         )
//     );
//   }
// }
//
// class UpdateRecord extends StatefulWidget {
//
//   const UpdateRecord({Key? key, required this.studentKey}) : super(key: key);
//
//   final String studentKey;
//
//   @override
//   State<UpdateRecord> createState() => _UpdateRecordState();
// }
//
// class _UpdateRecordState extends State<UpdateRecord> {
//
//   final  userNameController = TextEditingController();
//   final  userAgeController= TextEditingController();
//   final  userSalaryController =TextEditingController();
//
//   late DatabaseReference dbRef;
//
//   @override
//   void initState() {
//     super.initState();
//     dbRef = FirebaseDatabase.instance.ref().child('Students');
//     getStudentData();
//   }
//
//   void getStudentData() async {
//     DataSnapshot snapshot = await dbRef.child(widget.studentKey).get();
//
//     Map student = snapshot.value as Map;
//
//     userNameController.text = student['name'];
//     userAgeController.text = student['age'];
//     userSalaryController.text = student['salary'];
//
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Updating record'),
//       ),
//       body:  Center(
//         child: Padding(
//           padding: EdgeInsets.all(8.0),
//           child: Column(
//             children: [
//               const SizedBox(
//                 height: 50,
//               ),
//               const Text(
//                 'Updating data in Firebase Realtime Database',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.w500,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               TextField(
//                 controller: userNameController,
//                 keyboardType: TextInputType.text,
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'Name',
//                   hintText: 'Enter Your Name',
//                 ),
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               TextField(
//                 controller: userAgeController,
//                 keyboardType: TextInputType.number,
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'Age',
//                   hintText: 'Enter Your Age',
//                 ),
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               TextField(
//                 controller: userSalaryController,
//                 keyboardType: TextInputType.phone,
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'Salary',
//                   hintText: 'Enter Your Salary',
//                 ),
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               MaterialButton(
//                 onPressed: () {
//
//                   Map<String, String> students = {
//                     'name': userNameController.text,
//                     'age': userAgeController.text,
//                     'salary': userSalaryController.text
//                   };
//
//                   dbRef.child(widget.studentKey).update(students)
//                       .then((value) => {
//                     Navigator.pop(context)
//                   });
//
//                 },
//                 child: const Text('Update Data'),
//                 color: Colors.blue,
//                 textColor: Colors.white,
//                 minWidth: 300,
//                 height: 40,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
//
// // import 'package:flutter/material.dart';
// // import 'package:google_sign_in/google_sign_in.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:provider/provider.dart';
// // import 'package:firebase_database/firebase_database.dart';
// // import 'package:firebase_core/firebase_core.dart';
// //
// //
// // // class auth_ChatGpt extends StatefulWidget {
// // //   const auth_ChatGpt({Key? key}) : super(key: key);
// // //
// // //   @override
// // //   State<auth_ChatGpt> createState() => _auth_ChatGptState();
// // // }
// // //
// // // class _auth_ChatGptState extends State<auth_ChatGpt> {
// // //   final GoogleSignIn _googleSignIn = GoogleSignIn();
// // //   final FirebaseAuth _auth = FirebaseAuth.instance;
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       body: Center(
// // //         child: ElevatedButton(
// // //           onPressed: _handleSignIn,
// // //           child: Text('Sign in with Google'),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // //
// // //   Future<Scaffold> _handleSignIn() async {
// // //     try {
// // //       await _googleSignIn.signIn();
// // //       final GoogleSignInAccount? googleUser = await _googleSignIn.currentUser;
// // //       final GoogleSignInAuthentication? googleAuth =
// // //       await googleUser?.authentication;
// // //       final AuthCredential credential = GoogleAuthProvider.credential(
// // //         accessToken: googleAuth?.accessToken,
// // //         idToken: googleAuth?.idToken,
// // //       );
// // //       final FirebaseUser user =
// // //           (await _auth.signInWithCredential(credential)).user;
// // //
// // //       // Determine user role based on email address
// // //       if (email.endsWith('@admin.com')) {
// // //         // Show admin-only UI
// // //         return Scaffold(body: Center(child: Text('admin'.toUpperCase()),),);
// // //
// // //       } else if (email.endsWith('@manager.com')) {
// // //         // Show manager-only UI
// // //         return Scaffold(body: Center(child: Text('manager'.toUpperCase()),),);
// // //
// // //       } else if (email.endsWith('@employee.com')) {
// // //         // Show employee-only UI
// // //         return Scaffold(body: Center(child: Text('employee'.toUpperCase()),),);
// // //
// // //       } else if (email.endsWith('@customer.com')) {
// // //         // Show customer-only UI
// // //         return Scaffold(body: Center(child: Text('customer'.toUpperCase()),),);
// // //
// // //       } else {
// // //         // Show guest UI
// // //       }
// // //     } catch (error) {
// // //       print(error);
// // //     }
// // //   }
// // // }
// // //
// // // class User {
// // //   late String email;
// // //   late String role;
// // // }
// // //
// // // class Product {
// // //   late String name;
// // //   late int price;
// // // }
// // //
// // // class UserModel with ChangeNotifier {
// // //   late User _user;
// // //
// // //   User get user => _user;
// // //
// // //   setUser(String email) {
// // //     _user = User();
// // //     _user.email = email;
// // //     // Determine user role based on email address
// // //     if (email.endsWith('@admin.com')) {
// // //       _user.role = 'admin';
// // //     } else if (email.endsWith('@manager.com')) {
// // //       _user.role = 'manager';
// // //     } else if (email.endsWith('@employee.com')) {
// // //       _user.role = 'employee';
// // //     } else if (email.endsWith('@customer.com')) {
// // //       _user.role = 'customer';
// // //     } else {
// // //       _user.role = 'guest';
// // //     }
// // //     notifyListeners();
// // //   }
// // // }
// // //
// // // class ProductsModel with ChangeNotifier {
// // //   List<Product> _products = [
// // //     Product(name: 'Product 1', price: 10),
// // //     Product(name: 'Product 2', price: 20),
// // //     Product(name: 'Product 3', price: 30),
// // //   ];
// // //
// // //   List<Product> get products => _products;
// // //
// // //   addProduct(Product product) {
// // //     _products.add(product);
// // //     notifyListeners();
// // //   }
// // //
// // //   updateProduct(Product product) {
// // //     var index = _products.indexWhere((p) => p.name == product.name);
// // //     _products[index] = product;
// // //     notifyListeners();
// // //   }
// // //
// // //   deleteProduct(Product product) {
// // //     _products.removeWhere((p) => p.name == product.name);
// // //     notifyListeners();
// // //   }
// // // }
// // //
// // // void main() {
// // //   runApp(
// // //     MultiProvider(
// // //       providers: [
// // //         ChangeNotifierProvider(create: (_) => UserModel()),
// // //         ChangeNotifierProvider(create: (_) => ProductsModel()),
// // //       ],
// // //       child: MyApp(),
// // //     ),
// // //   );
// // // }
// // //
// // // class MyApp extends StatelessWidget {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return MaterialApp(
// // //       home: HomePage(),
// // //     );
// // //   }
// // // }
// // //
// // // class HomePage extends StatelessWidget {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //         body: Center(
// // //         child: Column(
// // //         mainAxisAlignment: MainAxisAlignment.center,
// // //         children: <Widget>[
// // //           ElevatedButton(
// // //         onPressed: () {
// // //       Provider.of<UserModel>(context, listen: false).setUser('admin@admin.com');
// // //     },
// // //     child: Text('Set admin user'),
// // //     ),
// // //     ]),),);}}
// //
// // class ChatScreen extends StatefulWidget {
// //   @override
// //   _ChatScreenState createState() => _ChatScreenState();
// // }
// //
// // final _textController = TextEditingController();
// // final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref().child('my_data');
// //
// //
// // @override
// // class _ChatScreenState extends State<ChatScreen> {
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text("Chat App"),
// //       ),
// //       body: Column(
// //         children: <Widget>[
// //           // Expanded(
// //           //   child: StreamBuilder(
// //           //     stream: _databaseReference.onValue,
// //           //     builder: (context, snapshot) {
// //           //       if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
// //           //         Map data = snapshot.data!.snapshot.value as Map;
// //           //         List items = data.values.toList();
// //           //         return ListView.builder(
// //           //           itemCount: items.length,
// //           //           itemBuilder: (context, index) {
// //           //             return ListTile(
// //           //               title: Text(items[index]['message']),
// //           //             );
// //           //           },
// //           //         );
// //           //       } else {
// //           //         return Center(
// //           //           child: CircularProgressIndicator(),
// //           //         );
// //           //       }
// //           //     },
// //           //   ),
// //           // ),
// //           Padding(
// //             padding: const EdgeInsets.all(8.0),
// //             child: TextField(
// //               controller: _textController,
// //               decoration: InputDecoration(
// //                 hintText: "Enter message",
// //               ),
// //             ),
// //           ),
// //           Padding(
// //             padding: const EdgeInsets.all(8.0),
// //             child: ElevatedButton(
// //               child: Text("Send"),
// //               onPressed: () async {
// //                 print('before adding');
// //
// //                 // _databaseReference.push().set({
// //                 //   'message': _textController.text
// //                 // }).then((value) => print('added'));
// //
// //
// //                 await _databaseReference.push().set({
// //                   "name": "John",
// //                   "age": 18,
// //                   "address": {
// //                     "line1": "100 Mountain View"
// //                   }
// //                 });
// //
// //
// //                 _textController.clear();
// //               },
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
