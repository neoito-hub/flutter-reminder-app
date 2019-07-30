import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reminderapp/login.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
Firestore db = Firestore.instance;

FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
final FirebaseAuth _auth = FirebaseAuth.instance;




 class RegisterPage extends StatefulWidget {
  @override 
  _RegisterPageState createState() => _RegisterPageState();
}




class _RegisterPageState extends State<RegisterPage> {

    String token;
    final mailController = TextEditingController();
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
         Column(
          mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Container(
            margin: const EdgeInsets.only(left:10,right:10,top:50),
            child:
              TextField(
                controller:mailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Your Mail Id',
                  labelStyle: TextStyle(textBaseline: TextBaseline.alphabetic)
                ),
              ),
          ),          
          new Container(
            margin: const EdgeInsets.only(left:10,right:10,top:10),
            child:
              TextField(
                 controller:nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Your Name',
                  labelStyle: TextStyle(textBaseline: TextBaseline.alphabetic)
                ),
              ),
          ),
            new Container(
            margin: const EdgeInsets.only(left:10,right:10,top:10),
            child:
              TextField(
                controller:phoneController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Your Phone Number',
                  labelStyle: TextStyle(textBaseline: TextBaseline.alphabetic)
                ),
              ),
          ),
            new Container(
            margin: const EdgeInsets.only(left:10,right:10,top:10),
            child:
              TextField(
                controller:passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Password',
                  labelStyle: TextStyle(textBaseline: TextBaseline.alphabetic)
                ),
              ),
          ),
          Container(
           margin: const EdgeInsets.only(top:10),
            child: 
            new RaisedButton(
                  child: new Text('SignUp'),
                  color: Colors.blueAccent,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(side: BorderSide(color: Colors.white),borderRadius: BorderRadius.circular(30)),
                  onPressed: ()=>signUp(),
                )
          ),
            new InkWell(
             child: Text("Login"),
              onTap: () {
                 Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context) => LoginPage(),
                  ),
                );    
              },
            )
        ],
      ),
    );
  }
   signUp() async{    
      FirebaseUser user;
      try {
        user = await _auth.createUserWithEmailAndPassword(
          email: mailController.text,
          password: passwordController.text,
        );
      } catch (e) {
        return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
        return AlertDialog(
        title: Text('Login Failed'),
        content:  Text(e.toString()),
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
      }finally{
        if(user != null){
          _firebaseMessaging.getToken().then((token){
             print(token);
             this.token = token;
          });
        
        final profile = UserProfile(this.mailController.text,this.phoneController.text,this.passwordController.text,this.nameController.text);
        var data = {
          'name':profile.name,
          'email':profile.email,
          'phone':profile.phoneNo,
          'password':profile.password,
          'token':token
        };
        Firestore.instance.collection('Users').add(data).catchError((onError){print(onError);}).then((response){ switchToNextRoute();});
        }else{
        AlertDialog(
        title: Text('Login Failed'),
        content:  Text('Error Logging in . Try again'),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ]
        );
       }
      }
} 
switchToNextRoute() async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('regToken', token);
          mailController.text='';
          passwordController.text = '';
          phoneController.text = '';
          nameController.text = '';
          Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
}
}
  class UserProfile{
    String email;
    String phoneNo;
    String password;
    String name;

    UserProfile(this.email,this.phoneNo,this.password,this.name);
  }