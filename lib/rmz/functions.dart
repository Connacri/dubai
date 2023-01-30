// import 'package:cloud_firestore/cloud_firestore.dart';
//
// void transact() {
//   var db = FirebaseFirestore.instance;
//   db.runTransaction((transaction) {
//     var userSuhail = db.collection("users").doc("suhail");
//     var userSam = db.collection("users").doc("sam");
//     var userJohn = db.collection("users").doc("john");
//     var userAlfred = db.collection("users").doc("Alfred");
//     var userAlfredDetails = db.collection('userdetails').doc('Alfred');
//     return transaction.get(userJohn).then((sDoc) {
//       var age = sDoc.data().age + 1;
//       transaction.set(userAlfred, {
//         name: 'Alfred',
//         age: age,
//         details: userAlfredDetails,
//       });
//       transaction.set(userAlfredDetails, {
//         address: 'Alfred Villa',
//       });
//       transaction.update(
//         userJohn,
//         {
//           age,
//         },
//       );
//       transaction.update(
//         userSuhail,
//         {
//           age,
//         },
//       );
//       transaction.update(
//         userSam,
//         {
//           age,
//         },
//       );
//       return age;
//     }).then((age) {
//       print("Age changed to ", age);
//     }).catchError((onError) {
//       print(onError);
//     });
//   });
// }
//
// void transactions_passingInformationOutOfTransactions(
//   String docId,
// ) {
//   // TODO: ewindmill@ - either the above example (using asnyc) or this example
//   // using (then) is "more correct". Figure out which one.
//   // [START transactions_passing_information_out_of_transactions]
//   final sfDocRef =
//       FirebaseFirestore.instance.collection('Adventure').doc(docId);
//   FirebaseFirestore.instance.runTransaction((transaction) {
//     return transaction.get(sfDocRef).then((sfDoc) {
//       final newPopulation = sfDoc.get("population") + 1;
//       transaction.update(sfDocRef, {"population": newPopulation});
//       return newPopulation;
//     });
//   }).then(
//     (newPopulation) => print("Population increased to $newPopulation"),
//     onError: (e) => print("Error updating document $e"),
//   );
//   // [END transactions_passing_information_out_of_transactions]
// }
