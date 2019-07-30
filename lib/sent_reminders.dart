import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:reminderapp/landingpage.dart';
import 'package:reminderapp/customwidget.dart';
class SentReminder extends StatefulWidget {
  @override
  _SentReminderPageState createState() => _SentReminderPageState();
}
class  _SentReminderPageState extends State<SentReminder> {
  bool reminderAvail = false;
  var userEmail;
  List <Map<dynamic,dynamic>> sentReminders =[]; 
  void initState() {
     super.initState();
    getData();
  }
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body:  
       reminderAvail?
             ListView.builder(
              shrinkWrap: true,
              itemBuilder: (ctx,index){
              return Column(
          children: <Widget>[
       Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
    child: Container(
      decoration: BoxDecoration(
         boxShadow: [new BoxShadow(
            color: Colors.black12,
            offset: new Offset(0.0, 1.0),
            blurRadius: 5.0,
          ),],),
      height: 130.0,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 50.0,
            child: Container(
    width: 300.0,
    height: 125.0,
    child: Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 6.0,
          bottom: 8.0,
          left: 40.0,
        ),
        child: Row(children:<Widget>[Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              width: 200,
              child:Column(
                children:<Widget>[
                  Padding(
                     padding: const EdgeInsets.only(
                    bottom: 8.0,
                  ),child:
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(sentReminders[index]['title'],
                style: TextStyle(fontFamily: 'Open Sans',fontWeight: FontWeight.bold,fontSize: 25)),
                  ),),
                Padding(
                    padding: const EdgeInsets.only(
                    bottom: 8.0,
                  ),
                child:
                Align(
                  alignment: Alignment.centerLeft,
                  child:  Text(sentReminders[index]['description'],
                style: TextStyle(fontFamily: 'Open Sans')
          ),
                ),),
            Row(
              children: <Widget>[
                Container(
                  width: 70,
                  height: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.blueAccent
                  ),
                  child: Center(child:Text(sentReminders[index]['to_name'],style:TextStyle(color: Colors.white,fontSize: 10,fontFamily: 'Open Sans'))),
                ),
              ],
            ),
            ],
          ),
            )
          ],
        ),
        Column(children: <Widget>[
        Container(
          child:
          sentReminders[index]['status']=='pending'?
          new IconButton(
        icon: new Icon(Icons.delete),
        highlightColor: Colors.pink,
        onPressed: (){deleteReminder(sentReminders[index]);},
      ):new Container()
      ),
        Container(
          child:
          sentReminders[index]['status']=='pending'?
          new IconButton(
        icon: new Icon(Icons.edit),
        highlightColor: Colors.pink,
        onPressed: (){},
      ):new Container()
      ),
        ],)
        ],
        ),
      ),
    ),
  ),
 ),
Positioned(top: 2, child: Container(
    width: 80.0,
    height: 120.0,
    decoration: BoxDecoration(
      boxShadow: [new BoxShadow(
            color: Colors.black38,
            offset: new Offset(5.0, 0.0),
            blurRadius: 5.0,
          ),],
      borderRadius: BorderRadius.circular(20),
      shape: BoxShape.rectangle,
      color: Colors.blueAccent,
      ),
      child:Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            child:
            Text('${sentReminders[index]['hour']}'+':'+'${sentReminders[index]['minutes']}',
                style:TextStyle(color: Colors.white,fontSize: 20,fontFamily: 'Open Sans')
      ),
            ),
      Text('${sentReminders[index]['date']}',
                style:TextStyle(color: Colors.white,fontSize: 15,fontFamily: 'Open Sans')
                )
          ],
        )
      ),
  ),
  ),
        ],
      ),
    ),
       )
          ],
      );
              },
              itemCount: sentReminders.length,
            ):new Container() ,   
        );
  }
  void getData() async{
        sentReminders= [];
        SharedPreferences prefs = await SharedPreferences.getInstance();
       userEmail = prefs.getString('userEmail');
       if(userEmail != null){
        var notifications =  await Firestore.instance.collection('Reminders').getDocuments();
     setState(() {
        notifications.documents.forEach((element){
          if(element.data['from_email']==userEmail){
            var reminder = {
              'id':element.documentID,
              'from_email':element.data['from_email'],
              'from_id':element.data['from_id'],
              'from_name':element.data['from_name'],
              'from_phone':element.data['from_phone'],
              'to_Id':element.data['to_Id'],
              'to_email':element.data['to_email'],
              'to_name':element.data['to_name'],
              'to_num':element.data['to_num'],
              'time':element.data['time'],
              'title':element.data['title'],
              'status':element.data['status'],
              'description':element.data['description']
            };
            DateTime date = element.data['time'].toDate();
          reminder['hour'] = date.hour;
          reminder['minutes'] = date.minute;
          var formattedDate = "${date.day}-${date.month}";

          reminder['date'] = formattedDate;

            sentReminders.add(reminder);     
          }
        });
        if(sentReminders.length>0){
          reminderAvail = true;
        }
        print(sentReminders);
     });
       }
  }

  deleteReminder(reminder) async{
   var notifications =  await Firestore.instance.collection('Reminders').getDocuments();
    notifications.documents.forEach((element){
      if(reminder['id']==element.documentID){
        setState(() {
        Firestore.instance
        .collection('Reminders')
        .document(element.documentID)
        .delete()
        .catchError((e) {
          print(e);
        });
        getData();
        });
      }
    });
  }
}