import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toast/toast.dart';

class note {

  final CollectionReference collectionReference = Firestore.instance.collection("users").document("userid0").collection("Notes");

  void addNote(BuildContext context,subcode,subname,userid,notetype,String description) {
    DocumentReference docRef = collectionReference .document(subcode);
    docRef.get()
        .then((docSnapshot){
      if (docSnapshot.exists) {
        updateNote(docRef,context,description);
      }
      else {
        createNote(context,subcode,subname,userid,notetype,description);
      }
    });
  }
  void createNote(context,subcode,subname,userid,notetype,description)
  {
    int noteId;
    String sub_code = subcode;
    String noteid;
    String createDate = DateTime.now().toString();
    String title = subname;
    String uid = userid;
    String user_email = "user0@xyz.com";
    String type = notetype;
    bool is_deleted = false;

    collectionReference.getDocuments().then((databaseSnapshot) {
      noteId = databaseSnapshot.documents.length;
    });
    if(noteId==null)
    {
      noteId=0;
    }
    print(noteId);
    noteId++;
    noteid = noteId.toString();
    Map<String,String> data = <String,String>{
      "title": title,
      "desc":description,
      "type":type,
      "created":createDate,
      "is_deleted":is_deleted.toString(),
      "is_updated":createDate,
      "ref-uid":noteid,
      "ref-code":sub_code,
      "user-uid":uid,
      "user-email":user_email
    };

    collectionReference.document(sub_code).setData(data).whenComplete(() {
      Toast.show("Note saved", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
    }).catchError((e) => print(e));
  }

  void updateNote(docRef,context,description){
    Map<String,String> update = <String,String>{
      "desc":description,
      "is_updated":DateTime.now().toString()
    };
    docRef.updateData(update).whenComplete(() {
      Toast.show("Note updated", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
    }).catchError((e) => print(e));
  }

  void deleteNote(docRef, context){
    Map<String,String> delete = <String,String>{
      "is_deleted": "true"
    };
    docRef.updateData(delete).whenComplete(() {
      Toast.show("Note deleted", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
    }).catchError((e) => print(e));
  }
}