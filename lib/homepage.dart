import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:reminderapp/reminder.dart';
import 'package:reminderapp/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:reminderapp/reminder_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reminderapp/customwidget.dart';

final databaseReference = FirebaseDatabase.instance.reference();

final FirebaseAuth _auth = FirebaseAuth.instance;


 class HomePage extends StatefulWidget {
  //  final UserProfile userProfile;
  //  HomePage({Key key, @required this.userProfile}):super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  bool showList =false;
    //  final UserProfile userProfile;
  // _HomePageState(this.userProfile);
  List<Map<dynamic,dynamic>> users =[];
    List<Map<dynamic,dynamic>> usersFinal =[];

   void initState() {
    super.initState();
    getData();
  }

 final phoneNumController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:new AppBar(
        title: Text('Home Page'),
        actions: <Widget>[
           IconButton(
            icon: Icon(Icons.list),
            onPressed: ()=>{
              Navigator.push(
              context,
              MaterialPageRoute(
              builder: (context) => ReminderList(),
              )
              )
            },
          ),
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: ()=>_logOut(),
          ),
        ],
      ),
      body:  Column(
          children: <Widget>[
          new Container(
            margin: const EdgeInsets.only(left:10,right:10,top:15,bottom: 10),
            child:
             TextField(
                onChanged: (value) {    
                  print(value);
                  filterSearchResults(value);

                },
                controller: phoneNumController,
                decoration: InputDecoration(
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0))
                        )
                      ),
              ), 
          ),
          new Expanded(
            child:
          showList?
            ListView.builder(
            shrinkWrap: true,
            itemBuilder: (ctx,index){
             return new InkWell(
              child:
                Column(
                  children:<Widget>[
                     Card(
                    margin: EdgeInsets.all(1.0),
                    elevation: 2.0,
                    child: CustomWidget(
                        title: users[index]['name'],
                        sub1: users[index]['phone'],
                        status: '',
                        delete: Container(),
                        trailing:Container(),
                           ),
                        )
                       ]
                     ),
                    onTap: (){
                     Navigator.push(
                      context,
                      MaterialPageRoute(
                      builder: (context) => ReminderPage(user:users[index]),
                      ),
                    );   
                 },
             );
              },
            itemCount: users.length,
          ):new Container(),
          )
          ],
        ),
    );
  }
  getData() async{
       getUserData().then((results) {
      setState(() {
        results.documents.forEach((element){
          print(element.data);
          var dataUser = {
            'user_id':element.data['uid'],
            'id':element.documentID,
            'name':element.data['user_name'],
            'phone':element.data['phone_number'],
          };
          users.add(dataUser);
          usersFinal.add(dataUser);
          if(this.users.length>0){
            this.showList = true;
          }
        });
        print(users);
      });
    });

  }
  _logOut() async{
   SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('regToken');
    prefs.remove('user_id');
     _auth.signOut().then((_){
        Navigator.push(
          context,
          MaterialPageRoute(
          builder: (context) => LoginPage(),
          ),
       );
     }
     );
  }
  getUserData() async {
    return await Firestore.instance.collection('Users').getDocuments();
  }
  
  void filterSearchResults(String query) {
      List<Map<dynamic,dynamic>> dummySearchList =[];
  dummySearchList.addAll(users);
  if(query.isNotEmpty) {
    List<Map<dynamic,dynamic>> dummyListData =[];
    dummySearchList.forEach((item) {
      var name = item['name'].toLowerCase();
      if(item['phone'].contains(query) || name.contains(query.toLowerCase())) {
        dummyListData.add(item);
      }
    });
    setState(() {
      users.clear();
      users.addAll(dummyListData);
    });
    return;
  } else {
    setState(() {
      users.clear();
      users.addAll(usersFinal);
    });
  }
}
} 