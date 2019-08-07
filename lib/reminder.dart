import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

Firestore db = Firestore.instance;
final databaseReference = FirebaseDatabase.instance.reference();


class ReminderPage extends StatefulWidget {
  final  user;
  ReminderPage({Key key, @required this.user}) : super(key: key);
  @override
  _ReminderPageState createState()=>_ReminderPageState(this.user);
}

class _ReminderPageState extends State<ReminderPage>{
     void initState() {
    super.initState();
    getData();
  }
  DateTime selectedTime;
  var fromUser ;
  bool showText = false;
   final titleController = TextEditingController();
   final descriptionController = TextEditingController();
   final datetimeController =TextEditingController();
  var user;
  _ReminderPageState(this.user);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:new AppBar(
        title: Text(this.user['phone']??''),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
          new Container(
            margin: const EdgeInsets.only(left:10,right:10,top:10),
            child:
              TextField(
                controller:titleController,
                decoration: InputDecoration(
                  labelText: 'Enter Title',
                  labelStyle: TextStyle(textBaseline: TextBaseline.alphabetic)
                ),
              ), 
          ),
           new Container(
            margin: const EdgeInsets.only(left:10,right:10,top:10,bottom: 40),
            child:
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'Enter Description',
                  labelStyle: TextStyle(textBaseline: TextBaseline.alphabetic)
                ),
              ), 
          ),showText?new Container(
            margin: const EdgeInsets.only(left:10,right:10,bottom: 50),
            child:
              TextField(
                controller: datetimeController,
                enabled: false,
                decoration: InputDecoration(
                  labelStyle: TextStyle(textBaseline: TextBaseline.alphabetic)
                ),
              ), 
          ):new Container(),
            FlatButton(
                onPressed: () {
                  DatePicker.showDateTimePicker(context, showTitleActions: true,
                      onChanged: (date) {
                    print('change $date in time zone ' +
                        date.timeZoneOffset.inHours.toString());
                  }, onConfirm: (date) {
                    selectedTime = date;
                    datetimeController.text =selectedTime.toString();
                    setState(() {
                    if(selectedTime!=null){
                      showText = true;
                    }
                    });
                    print('confirm $date');
                  }, currentTime: DateTime.now());
                },
                child: Text(
                  'Select date and time',
                  style: TextStyle(color: Colors.blue),
                )),        
           new RaisedButton(
             child: new Text('Send Reminder'),
             color: Colors.brown,
             textColor: Colors.white,
             onPressed: ()=>sendReminder(),
                )
          ],
        ),
      ),
    );
  }

  void sendReminder(){
    if((titleController.value!=null)&&(titleController.value!=null)&&(selectedTime!=null)){

    var data={
      'from_uid':fromUser['from_uid'],
      'from_id':fromUser['from_id'],
      'from_name':fromUser['from_name'],
      'from_phone':fromUser['from_phone'],
      'to_uid':user['user_id'],
      'to_Id':user['id'],
      'to_num':user['phone'],
      'to_name':user['name'],
      'title':titleController.text,
      'description':descriptionController.text,
      'time':selectedTime,
      'status':'pending'
    };
    Firestore.instance.collection('Reminders').add(data).catchError((onError){print(onError);}).then((response){print(response);
     Navigator.of(context).pop();});
    }else{
     showDialog<void>(
    context: context,
    builder: (BuildContext context) {
        return AlertDialog(
        title: Text('Something Went Wrong'),
        content:  Text('All fields are required'),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ]
        );
    },
   );
    }
  }
  getData() async{
        SharedPreferences prefs = await SharedPreferences.getInstance();
       var uid = prefs.getString('user_id');
     var fromData =  await Firestore.instance.collection('Users').getDocuments();
        fromData.documents.forEach((element){
          if(uid==element['uid']){
      fromUser = { 'from_uid':uid,
                  'from_id':element.documentID,
                  'from_name':element['user_name'],
                  'from_phone':element['phone_number']
                };
          }
        });
                 

  }
}