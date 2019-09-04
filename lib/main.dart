import 'dart:io';
import 'package:firebase_app/note.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:core';
import 'package:toast/toast.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Firebase Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Firestore databaseReference = Firestore.instance;
  int noteId;
  final myController = TextEditingController();

  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SizedBox(
            height: 150,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onLongPress: () {
                  showGeneralDialog(
                      barrierColor: Colors.black.withOpacity(0.5),
                      //SHADOW EFFECT
                      transitionBuilder: (context,a1,a2,widget) {
                        return Center(
                          child: Container(
                            height: 400.0 * a1.value, // USE PROVIDED ANIMATION
                            width: 300.0 * a1.value,
                            child: Scaffold(body: Container(
                                child: Center(child: Column(
                                  children: <Widget>[
                                    Text("Subject",style: TextStyle(fontSize: 20),),
                                    Text("Type",style: TextStyle(fontSize: 20),),
                                    Container(
                                      color: Color(0xffeeeeee),
                                      child: TextField(
                                        controller: myController,
                                        maxLines: null,
                                        decoration: new InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Add your description here',
                                        ),
                                      ),
                                    ),
                                    RaisedButton(
                                      child: Text("Submit"),
                                        onPressed:() {

                                        _createRecord();
                                        Navigator.of(context, rootNavigator: true).pop();}),
                                  ],
                                )),
                              ),),
                          ),
                        );
                      },
                      transitionDuration: Duration(milliseconds: 50),
                      // DURATION FOR ANIMATION
                      barrierDismissible: true,
                      barrierLabel: 'LABEL',
                      context: context,
                      pageBuilder: (context, animation1, animation2) {
                        return Text('PAGE BUILDER');
                      });
                },
                child: Container(
                  color: Colors.green,
                    child: Center(
                      child: Text('Create Note', style: TextStyle(fontSize: 30),),
                    )),
              ),
            ),
          ),
        ),
      ),
    );
  }

    void _createRecord()
    {
      databaseReference.collection("users").document("userid0").collection("Notes").getDocuments().then((databaseSnapshot) {
          noteId = databaseSnapshot.documents.length;
      });
      print(noteId);
      noteId++;
      Map<String,String> data = <String,String>{
        "title": "Note"+noteId.toString(),
        "desc":myController.text
      };

      databaseReference.collection("users").document("userid0").collection("Notes").document("Note "+noteId.toString()).setData(data).whenComplete(() {
          Toast.show("Note saved", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
      }).catchError((e) => print(e));


    }

}
