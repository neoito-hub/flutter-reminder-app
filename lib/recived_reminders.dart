import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecivedReminder extends StatefulWidget {
  @override
  _RecivedReminderPageState createState() => _RecivedReminderPageState();
}
class  _RecivedReminderPageState extends State<RecivedReminder> {
  var userId;
  List <Map<dynamic,dynamic>> recivedReminders =[]; 
  void initState() {
     super.initState();
    getData();
  }
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body:
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(recivedReminders[index]['title'],
                style: TextStyle(fontFamily: 'Open Sans',fontWeight: FontWeight.bold,fontSize: 20)),
            Text(recivedReminders[index]['description'],
                style: TextStyle(fontFamily: 'Open Sans')
),
            Row(
              children: <Widget>[
                Container(
                  width: 70,
                  height: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.blueAccent
                  ),
                  child: Center(child:Text(recivedReminders[index]['from_name'],style:TextStyle(color: Colors.white,fontSize: 10,fontFamily: 'Open Sans'))),
                )
              ],
            )
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
                          Text('${recivedReminders[index]['hour']}'+':'+'${recivedReminders[index]['minutes']}',
                style:TextStyle(color: Colors.white,fontSize: 20,fontFamily: 'Open Sans')
      ),
            ),
      Text('${recivedReminders[index]['date']}',
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
              itemCount: recivedReminders.length,
            )
    );
  }
  getData() async{
        SharedPreferences prefs = await SharedPreferences.getInstance();
       userId = prefs.getString('user_id');
      var notifications =  await Firestore.instance.collection('Reminders').getDocuments();
       setState(() {
        notifications.documents.forEach((element){
          if((element.data['to_uid']==userId)&& (element.data['status']=='sent')){
          DateTime date = element.data['time'].toDate();
          element.data['hour'] = date.hour;
          element.data['minutes'] = date.minute;
          var formattedDate = "${date.day}-${date.month}";

          element.data['date'] = formattedDate;

          recivedReminders.add(element.data);
          }
        }); 
        print(recivedReminders);
       });
    }
}
