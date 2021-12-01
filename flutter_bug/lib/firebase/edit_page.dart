import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  const EditPage({ Key? key }) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
               pinned: true,
            title: Text(
              "Flutter Blog",
              style: TextStyle(color: theme.primaryColor),
            ),
            expandedHeight: MediaQuery.of(context).size.height / 3,
            flexibleSpace: FlexibleSpaceBar(
              background: _header(theme),
            ),
            actions: [
              PopupMenuButton(
                icon: Icon(Icons.more_vert, color: theme.primaryColor),
                itemBuilder: (BuildContext context) => [
                  PopupMenuItem(
                      child: Text(
                        "Edit Post",
                        style: theme.textTheme.bodyText2,
                      ),
                      value: "edit"),
                  PopupMenuItem(
                      child: Text(
                        "Delete Post",
                        style: theme.textTheme.bodyText2,
                      ),
                      value: "delete"),
                ],
                onSelected: (String value) {
                  if (value == "edit") {
                    _showEditDialog(context);
                  } 
                  else if (value == "delete") {
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          )
        ],
      ),
    );
  }

    Widget _header(ThemeData theme) {
      CollectionReference board = FirebaseFirestore.instance.collection('board');
    return  StreamBuilder(
        stream: board.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot<Object?>> snap){

          if(!snap.hasData) {
            return Center(
              child: CircularProgressIndicator());
            }
            return ListView.builder(
              // itemCount: snap.data!.docs.length,
              itemBuilder: (BuildContext context, int index){
                return 

                // Text(snap.data!.docs[index].get('title'));
                Container(
                  height: 150.0,
                   padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                  child: GestureDetector(
                    child: Card(
                      margin: EdgeInsets.fromLTRB(15.0, 0.0, 10.0, 15.0),
                     
                      child:
                     ListTile(
                        title: Container(
                          padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
                          child: Text(snap.data!.docs[index].get('title'),
                          style: TextStyle(fontSize:20.0, fontWeight: FontWeight.bold),
                          )
                          ),
                          
                        subtitle: Text(snap.data!.docs[index].get('description')),
                        leading: CircleAvatar(
                           radius: 34.0,
                          child: Text(snap.data!.docs[index].get('title').toString()[0]),
                        ),
                    )),
                   
                    // Navigator.pop(context);
                  ));

              }
              );
        }
        );
  }

     _showEditDialog(BuildContext context) async{
       late TextEditingController name2Controller;
       late TextEditingController title2Controller;
       late TextEditingController description2Controller;
    @override
      void initState() {
    // TODO: implement initState
     super.initState();
     name2Controller =  new TextEditingController();
     title2Controller = TextEditingController();
     description2Controller = TextEditingController();
   }
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
                        controller: name2Controller,
                        autofocus: true,
                        autocorrect: true,
                        decoration: InputDecoration(
                          labelText: ' Your Name',
                        ),
                      )
                      ),
                    Expanded(
                      child: TextField(
                        controller: description2Controller,
                        autofocus: true,
                        autocorrect: true,
                        decoration: InputDecoration(
                          labelText: 'Description',
                        ),
                      )
                      ),
                      Expanded(
                      child: TextField(
                        controller: title2Controller,
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
                  // ElevatedButton(
                  //   onPressed: (){
                  //       nameController.clear();
                  //       titleController.clear();
                  //       descriptionController.clear();

                  //       Navigator.pop(context);
                  //   }, 
                  //   child: Text("Cancel")
                  //   ),
                  ElevatedButton(
                    onPressed: (){
                      if(name2Controller.text.isNotEmpty && title2Controller.text.isNotEmpty
                          && description2Controller.text.isNotEmpty
                      ) {
                        FirebaseFirestore.instance.collection('board').doc().update({
                            "name" : name2Controller.text,
                            "title" : title2Controller.text,
                           "description" : description2Controller.text,
                           "timestamp" : new DateTime.now()
                        }).then((value) => print("User Updated"))
                        .catchError((error) => print("Failed to update user: $error"));
                        // FirebaseFirestore.instance.collection('board')
                        // .add({
                        //     "name" : name2Controller.text,
                        //     "title" : title2Controller.text,
                        //     "description" : descriptionController.text,
                        //     "timestamp" : new DateTime.now()
                        // }).then((response) {
                        //   print(response.id);
                        //   Navigator.pop(context);
                        //   nameController.clear();
                        //   titleController.clear();
                        //   descriptionController.clear();
                        // }
                        // ).catchError((error) => print(error));
                      }
                        
                    }, 
                    child: Text("Edit")
                    ),
                ],
            );
          },
          
          );
    }

}