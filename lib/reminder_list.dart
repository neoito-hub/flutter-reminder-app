// import 'package:flutter/material.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:shared_preferences/shared_preferences.dart';



// final databaseReference = FirebaseDatabase.instance.reference();



// class ReminderList extends StatefulWidget {
//   @override
//   _ReminderListPageState createState() => _ReminderListPageState();
// }
// class  _ReminderListPageState extends State<ReminderList> {
//     var userEmail;
//     List<Map<dynamic, dynamic>> sentReminders=[];
//     List<Map<dynamic, dynamic>> recivedReminders=[] ;
//     bool showRecived = false;
//     bool showSent = false;
//    void initState() {
//      super.initState();
//     getData();
//   }
//   @override
//   Widget build(BuildContext context){
//     return Scaffold(
//       appBar: new AppBar(
//         title: Text('Reminder List'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: <Widget>[
//           showSent?
//             Text('Sent',
//             style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)):new Container(),
//            ListView.builder(
//             shrinkWrap: true,
//             itemBuilder: (ctx,index){
//              return new InkWell(
//               child:
//                 Column(
//                   children:<Widget>[
//                     new Container(
//                    margin: const EdgeInsets.only(left:20,top:30),
//                       child:Row(
//                         children: <Widget>[
//                       Text('to:'),
//                       Text(sentReminders[index]['to_email'])
//                         ],
//                       ),    
//                     ),
//                   new Container(
//                    margin: const EdgeInsets.only(left:20),
//                       child:Row(
//                       children: <Widget>[
//                       Text('title:'),
//                       Text(sentReminders[index]['title'])
//                         ],
//                       )
//                   )
//                   ]
//                 )
//              );
//               },
//             itemCount: sentReminders.length,
//           ),
//           new Container(
//             margin: const EdgeInsets.only(top: 30),
//             child: Column(
//               children:<Widget>[
//             showRecived?
//               Text('Recived',
//               style:TextStyle(fontSize:25,fontWeight:FontWeight.bold)):new Container(),
//            ListView.builder(
//             shrinkWrap: true,
//             itemBuilder: (ctx,index){
//              return new InkWell(
//               child:
//                 Column(
//                   children:<Widget>[
//                     new Container(
//                    margin: const EdgeInsets.only(left:20,top:30),
//                       child:Row(
//                         children: <Widget>[
//                       Text('from:'),
//                       Text(recivedReminders[index]['to_email'])
//                         ],
//                       ),    
//                     ),
//                   new Container(
//                    margin: const EdgeInsets.only(left:20),
//                       child:Row(
//                       children: <Widget>[
//                       Text('title:'),
//                       Text(recivedReminders[index]['title'])
//                         ],
//                       )
//                   )
//                   ]
//                 )
//              );
//               },
//             itemCount: recivedReminders.length,
//           )
//               ]
//               ),
//           )
//           ]
//          ),
//       )
//     );
//   }
//   getData() async{
//        SharedPreferences prefs = await SharedPreferences.getInstance();
//         userEmail = prefs.getString('userEmail');
//         var db= databaseReference.child('Reminders');
//             db.once().then((DataSnapshot snapshot) {
//             Map<dynamic, dynamic> values = snapshot.value;
//             setState(() {
//             values.forEach((key,values) {
//               print(values);
//               if(userEmail == values['from_email']){
//                 sentReminders.add(values);
//               }
//               if(userEmail ==values['to_email']){
//                 recivedReminders.add(values);
//               }
//             });
//             if(sentReminders.length>0){
//               showSent = true;
//             }else{
//               showSent = false;
//             }
//             if(recivedReminders.length>0){
//               showRecived = true;
//             }else{
//               showRecived = false;
//             }
//             }
//             );
//   });
// }
// }

import 'package:flutter/material.dart';
import 'package:reminderapp/recived_reminders.dart';
import 'package:reminderapp/sent_reminders.dart';

class  ReminderList extends StatelessWidget{ 
   @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(text:'Recived'),
                Tab(text: 'Sent'),
              ],
            ),
            title: Text('Reminders'),
          ),
          body: TabBarView(
            children: [
              RecivedReminder(),
              SentReminder()
            ],
          ),
        ),
      
    );
  }
}