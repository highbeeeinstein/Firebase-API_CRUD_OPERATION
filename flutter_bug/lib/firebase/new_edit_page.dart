import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NewEditPage extends StatefulWidget {
 
  final QueryDocumentSnapshot<Object?> snapshot;
  const NewEditPage({ Key? key, required this.snapshot }) : super(key: key);

  @override
  _NewEditPageState createState() => _NewEditPageState();
}

class _NewEditPageState extends State<NewEditPage> {
    TextEditingController nameController =TextEditingController();
   late TextEditingController titleController;
    late TextEditingController descriptionController;
    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController =  new TextEditingController(text: widget.snapshot.get("name") );
    titleController = TextEditingController(text: widget.snapshot.get("title"));
    descriptionController = TextEditingController(text: widget.snapshot.get('description'));
  }
  @override
  Widget build(BuildContext context) {
    final docid=widget.snapshot.id;
    return Scaffold(
        body: Container(
          child: AlertDialog(
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
                         FirebaseFirestore.instance.collection('board').doc(docid).update({
                            "name" : nameController.text,
                            "title" : titleController.text,
                           "description" : descriptionController.text,
                          //  "timestamp" : new DateTime.now()
                        }).then((value) => print("User Updated"))
                        .catchError((error) => print("Failed to update user: $error"));
                      }
                      Navigator.pop(context);
                        
                    }, 
                    child: Text("Edit")
                    ),
                ],
            )
        ),
    );
  }
}