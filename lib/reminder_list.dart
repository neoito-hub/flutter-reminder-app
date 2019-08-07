
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