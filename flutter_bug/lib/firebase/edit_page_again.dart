// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class EditPageAgain extends StatefulWidget {
//   final AsyncSnapshot<QuerySnapshot<Object?>> snap;
//   const EditPageAgain({ Key? key, required this.snap,  }) : super(key: key);

//   @override
//   _EditPageAgainState createState() => _EditPageAgainState();
// }

// class _EditPageAgainState extends State<EditPageAgain> {
  
//   @override
//   Widget build(BuildContext context) {
    
//     return Scaffold(
//       body: Card(
//         margin: EdgeInsets.fromLTRB(15.0, 0.0, 10.0, 15.0),
//             child:
//               ListTile(
//                   title: Container(
//                   padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
//                     child: Text(snap.data!.docs.get('title'),
//                        style: TextStyle(fontSize:20.0, fontWeight: FontWeight.bold),
//                   )
//                   ),
                          
//                   subtitle: Text(snap.data!.docs[index].get('description')),
//                   leading: CircleAvatar(
//                     radius: 34.0,
//                       child: Text(snap.data!.docs[index].get('title').toString()[0]),
//                   ),
//                 )
//       ),
//     );
//   }
// }