import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bug/firebase/edit_page.dart';
import 'package:flutter_bug/firebase/new_edit_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BoardApp extends StatefulWidget {
  const BoardApp({ Key? key }) : super(key: key);

  @override
  _BoardAppState createState() => _BoardAppState();
}

class _BoardAppState extends State<BoardApp> {
  //final board = FirebaseFirestore.instance.collection('board').snapshots();
  CollectionReference board = FirebaseFirestore.instance.collection('board');
  late TextEditingController nameController;
   late TextEditingController titleController;
    late TextEditingController descriptionController;
    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController =  new TextEditingController();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
  }

  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Community Board'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
            _showDialog(context);
        },
        child: Icon(Icons.add)
        ),
      body: 
      StreamBuilder(
        stream: board.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot<Object?>> snap){
          

          if(!snap.hasData) {
            return Center(
              child: CircularProgressIndicator());
            }
            return ListView.builder(
              itemCount: snap.data!.docs.length,
              itemBuilder: (BuildContext context, int index){   
              final docid=snap.data!.docs[index].id;
                return 
                // Text(snap.data!.docs[index].get('title'));
                Container(
                  height: 180.0,
                   padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                  child: GestureDetector(
                    child: Card(
                      margin: EdgeInsets.fromLTRB(15.0, 0.0, 10.0, 15.0),
                     
                      child:
                     Column(
                       children: [
                         ListTile(
                            title: Container(
                              padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 20.0),
                              child: Text(snap.data!.docs[index].get('title'),
                              style: TextStyle(fontSize:20.0, fontWeight: FontWeight.bold),
                              )
                              ),
                              
                            subtitle: Text(snap.data!.docs[index].get('description')),
                            leading: CircleAvatar(
                               radius: 34.0,
                              child: Text(snap.data!.docs[index].get('title').toString()[0]),
                            ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: (){
                            
                            showCupertinoDialog(
                          context: context, 
                          builder: (context){
                            return Dialog(
                               shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                               elevation: 0,
                              backgroundColor: Colors.transparent,
                            child: contentBox(context),
                      );
                          }
                          );
                          // Navigator.pop(context);
                          Navigator.push(
                            context, 
                            MaterialPageRoute(
                              builder: (BuildContext context){
                                 return NewEditPage(snapshot: snap.data!.docs[index]);
                              }
                              ),
                            );

                          }, 
                          icon: FaIcon(
                            FontAwesomeIcons.edit
                          )
                          ),
                          
                         IconButton(
                           onPressed: (){
                              showDialog(context: context,
                               builder: (BuildContext context){
                                    return AlertDialog(
                                      content: Column(
                                        children: [
                                            Container(
                                              child: Text("Do you really want to delete?"),
                                            ),

                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: (){
                                            FirebaseFirestore.instance.collection('board').doc(docid).delete();
                                          }, 
                                          child: Text('Yes')
                                          ),
                                          TextButton(
                                            onPressed: (){
                                                Navigator.pop(context);
                                            }, 
                                            child: Text('No')
                                            )
                                      ],
                                    );
                               }
                               );
                              
                           }, 
                           icon: FaIcon(
                              FontAwesomeIcons.trashAlt,
                           ) 
                           ),

                        // Icon(FontAwesomeIcons.trashAlt)
                      ],
                    )
                       ],
                     )),
                    // onTap: (){
                    //     showCupertinoDialog(
                    //       context: context, 
                    //       builder: (context){
                    //         return Dialog(
                    //            shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(8.0),
                    //         ),
                    //            elevation: 0,
                    //           backgroundColor: Colors.transparent,
                    //         child: contentBox(context),
                    //   );
                    //       }
                    //       );
                    //       // Navigator.pop(context);
                    //       Navigator.push(
                    //         context, 
                    //         MaterialPageRoute(
                    //           builder: (BuildContext context){
                    //              return NewEditPage(snapshot: snap.data!.docs[index]);
                    //           }
                    //           ),
                    //         );
                        
                        
                    // },
                    // Navigator.pop(context);
                  ));

              }
              );
        }
        )
    );
  }
    _showDialog(BuildContext context) async{
        await showDialog(
          context: context, 
          builder: (BuildContext context){
            return AlertDialog(
                contentPadding: EdgeInsets.all(2.0),
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    Container(
                      padding: EdgeInsets.fromLTRB(20.0, 20.0, 10.0, 10.0),
                      child: Text('Please fill out the field')
                      ),
                    Expanded(
                      child: TextField(
                        controller: nameController,
                        autofocus: true,
                        autocorrect: true,
                        decoration: InputDecoration(
                          labelText: ' Your Name',
                        ),
                      )
                      ),
                    Expanded(
                      child: TextField(
                        controller: descriptionController,
                        autofocus: true,
                        autocorrect: true,
                        decoration: InputDecoration(
                          labelText: 'Description',
                        ),
                      )
                      ),
                      Expanded(
                      child: TextField(
                        controller: titleController,
                        autofocus: true,
                        autocorrect: true,
                        decoration: InputDecoration(
                          labelText: 'Title',
                        ),
                      )
                      ),
                  ]
                ),
                actions: [
                  ElevatedButton(
                    onPressed: (){
                        nameController.clear();
                        titleController.clear();
                        descriptionController.clear();

                        Navigator.pop(context);
                    }, 
                    child: Text("Cancel")
                    ),
                  ElevatedButton(
                    onPressed: (){
                      if(nameController.text.isNotEmpty && titleController.text.isNotEmpty
                          && descriptionController.text.isNotEmpty
                      ) {
                        FirebaseFirestore.instance.collection('board').add({
                            "name" : nameController.text,
                            "title" : titleController.text,
                            "description" : descriptionController.text,
                            "timestamp" : new DateTime.now()
                        }).then((response) {
                          print(response.id);
                          Navigator.pop(context);
                          nameController.clear();
                          titleController.clear();
                          descriptionController.clear();
                        }
                        ).catchError((error) => print(error));
                      }
                        
                    }, 
                    child: Text("Save")
                    ),
                ],
            );
          },
          
          );
    }

       Widget contentBox(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(30.0),
        height: 150,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Center(
          child: Column(
            children: [CircularProgressIndicator(), Text("Please wait...")],
          ),
        ));
  }
  
}