import 'package:flutter/material.dart';
import 'package:flutter_bug/helper/service.dart';
import 'package:flutter_bug/model/photo.dart';
import 'package:flutter_bug/model/post_list.dart';
import 'package:intl/intl.dart';

class FlutterBlug extends StatefulWidget {
  const FlutterBlug({ Key? key }) : super(key: key);

  @override
  _FlutterBlugState createState() => _FlutterBlugState();
}

class _FlutterBlugState extends State<FlutterBlug> {
  // final String description = post[index].toString();
   static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat("E d, MMM y");
  final String formatted = formatter.format(now);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title: Text('Flutter Blog', style: TextStyle(
          color: Colors.brown
        ),),
        actions: [
          Icon(Icons.search, color: Colors.brown,),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: (){

        },
        child: Icon(Icons.add),
        ),
    
      body: Container(
            child: FutureBuilder<List<Posts>>(
              future: postList(),
              builder: (BuildContext context, AsyncSnapshot snapshot)  {
                   if (snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                  
                  
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error'),
                  );
                }
                List <Posts> post = snapshot.data;
                // final String description = '${post[index].body}';
                return ListView.builder(
                  itemCount: post.length,
                  itemBuilder: (BuildContext context, int index) {
                    final String description = '${post[index].body!.replaceAll('\n', "")}';
                    return 
                    
                        // Divider(
                        //     height: 2.0,
                        // ),
                        // Container(
                        //   width: 300.0,
                        //   height: 200.0,
                        //   color: Colors.red,
                        //     child: Center(
                        //       child: Text('Image'),
                        //     )
                        // ),
                        // SizedBox(
                        //   height: 10.0,
                        // ),
                        
                          // title: Text('${photo[index].url}')
                           
                           Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             mainAxisAlignment: MainAxisAlignment.start,
                             children: [
                              //  Text('Top Headlines', style: TextStyle(fontSize: 15.0,)),
                              //  SizedBox(
                              //    height: 10.0,
                              //  ),
                               Container(
                                 width: 400.0,
                                 margin: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 5.0),
                                   child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     mainAxisAlignment: MainAxisAlignment.start,
                                     children: [
                                       Stack(
                                         clipBehavior: Clip.none, 
                                         fit: StackFit.passthrough,
                                         children: [
                                           Container(
                                                       // width: 300.0,
                                              height: 200.0,
                                              color: Colors.blueGrey.shade200,
                                              child: Center(
                                              child: Text('Image'),
                                              )
                                          ),
                                            Positioned(
                                            left: 208.0,
                                            top: 140.0,
                                            child: Container(
                                              // decoration: BoxDecoration(
                                                  // borderRadius: BorderRadius.circular(30.0),
                                                  // color: Colors.green,
                                              // ),
                                              // color: Colors.green,
                                              width: 170.0,
                                              height: 40.0,
                                              child: Center(
                                                child: Text(formatted)
                                                ),                       
                                               ),
                                          )
                                         ],
                                       ),
                                       Container(
                                         height: 290.0,
                                         width: 500.0,
                                         child: Stack(
                                           children: [
                                             Card(
                                              //  margin: EdgeInsets.all(10.0),
                                               child: Column(
                                                 crossAxisAlignment: CrossAxisAlignment.start,
                                                 mainAxisAlignment: MainAxisAlignment.start,
                                                 children: [
                                                   Container(
                                                      margin: EdgeInsets.fromLTRB(0, 5.0, 0, 0),
                                                     padding: EdgeInsets.all(5.0),
                                                     child: Text('${post[index].title}', style: TextStyle(
                                                       fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red,
                                                     ),),
                                                   ),
                                                   Container(
                                                    //  height: 200.0,
                                                     margin: EdgeInsets.fromLTRB(0, 10.0, 0, 0),
                                                     padding: EdgeInsets.all(10.0),
                                                     child: DescriptionTextWidget(text: description,)
                                                   ),
                                                 ],
                                                 // width: 300.0,
                                                 // height: 300.0,
                                                 // image: NetworkImage('${photo[index].url}')
                                                 ),
                                             ),
                                              Positioned(
                                            left: 278.0,
                                            top: 220.0,
                                            child: Text(TimeOfDay.now().format(context)),
                                          )
                                           ],
                                         ),
                                       ),
                                       
                                     ],
                                   ),
                                 
                               ),
                               SizedBox(
                                 height: 30.0,
                               ),
                             ],
                           );
                          
                        
                        //  Divider(
                        //     height: 2.0,
                        // ),
                       
                      
                  },
                );

              }
              ),
          ),
        
      
    );
  }
}

class DescriptionTextWidget extends StatefulWidget {
  final String text;

  DescriptionTextWidget({required this.text});

  @override
  _DescriptionTextWidgetState createState() => new _DescriptionTextWidgetState();
}

class _DescriptionTextWidgetState extends State<DescriptionTextWidget> {
  late String firstHalf;
  late String secondHalf;

  bool flag = true;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > 90) {
      firstHalf = widget.text.substring(0, 90);
      secondHalf = widget.text.substring(90, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      // height: 300.0,
      padding: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: secondHalf.isEmpty
          ? new Text(firstHalf)
          : new Column(
              children: <Widget>[
                new Text(flag ? (firstHalf + "...") : (firstHalf + secondHalf),
                textAlign: TextAlign.justify,
                ),
                new InkWell(
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      new Text(
                        flag ? "show more" : "show less",
                        style: new TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      flag = !flag;
                    });
                  },
                ),
              ],
            ),
    );
  }
}