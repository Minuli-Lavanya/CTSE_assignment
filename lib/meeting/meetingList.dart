
import 'package:flutter/material.dart';
import 'package:lunch_partner/controller/meetingController.dart';
import 'package:lunch_partner/adminHome.dart';
import 'package:lunch_partner/meeting/form.dart';
import 'package:lunch_partner/meeting/viewMeeting.dart';
import 'package:lunch_partner/userHome.dart';

//import 'package:lunch_partner/form.dart';

class MeetingList extends StatefulWidget {
  const MeetingList({Key? key}) : super(key:key);

  @override
  _MeetingListState createState() => _MeetingListState();
}

class _MeetingListState extends State<MeetingList>{
  late MeetingController  db;
  List docs = [];

  initialise() {
    db = MeetingController ();
    db.initiliase();
    db.read().then((value) => {
      setState((){
        docs = value;
      })
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialise();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            iconSize: 20.0,
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => UserHome()));
            },
          ),
          centerTitle: true,
          title: Text('Invitation List'),
          backgroundColor: Colors.blueAccent,
      ),
      body:ListView.builder(
          itemCount: docs.length,
          itemBuilder: (BuildContext context, int index){
            return Card(
              margin: EdgeInsets.all(10),
              child: ListTile(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewMeeting(meeting:docs[index],db:db)))
                      .then((value)=> {
                    if(value != null) {initialise()}
                  });
                },
                contentPadding: EdgeInsets.only(right: 30,left: 36),
                title: Text(docs[index]['title']),
                trailing: Text(docs[index]['location']),

              ),
            );
          }),
       // This trailing comma makes auto-formatting nicer for build methods.
    );// This trailing comma makes auto-formatting nicer for build methods.
  }
  _goBack(BuildContext context) {
    Navigator.pop(context);
  }
}