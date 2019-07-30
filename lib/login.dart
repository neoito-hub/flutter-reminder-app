// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:reminderapp/homepage.dart';
// import 'package:reminderapp/register.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// Firestore db = Firestore.instance;
// final FirebaseAuth _auth = FirebaseAuth.instance;

// FirebaseMessaging _firebaseMessaging = FirebaseMessaging();


//  class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }




// class _LoginPageState extends State<LoginPage> {
//       UserProfile profile;
//       String token;
//       final mailController = TextEditingController();
//       final passwordController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//       return Scaffold(
//       body:
//          Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           new Container(
//             margin: const EdgeInsets.only(left:10,right:10,top:50),
//             child:
//               TextField(
//                 controller: mailController,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'Enter Your Mail Id',
//                   labelStyle: TextStyle(textBaseline: TextBaseline.alphabetic)
//                 ),
//               ),
//           ),          
//             new Container(
//             margin: const EdgeInsets.only(left:10,right:10,top:10),
//             child:
//               TextField(
//                 controller:passwordController,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'Enter Password',
//                   labelStyle: TextStyle(textBaseline: TextBaseline.alphabetic)
//                 ),
//               ),
//           ),
//           Container(
//             margin: const EdgeInsets.only(top:10),
//             child: 
//             new RaisedButton(
//                   child: new Text('Log In'),
//                   color: Colors.blueAccent,
//                   textColor: Colors.white,
//                   onPressed: ()=>login(),
//                   shape: RoundedRectangleBorder(side: BorderSide(color: Colors.white),borderRadius: BorderRadius.circular(30)),
//                 ),
//           ),
//           new InkWell(
//              child: Text("SignUp"),
//               onTap: () {
//                  Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                   builder: (context) => RegisterPage(),
//                   ),
//                 );    
//               },
//             )
//         ],
//       ),  
//     );
//   }
//   void login() async{
//     FirebaseUser user;
//      profile = UserProfile(mailController.text,passwordController.text);
//    try{
//       user = await _auth.signInWithEmailAndPassword(
//       email: profile.email,
//       password: profile.password
//     );
//    }catch(e){
//    return showDialog<void>(
//     context: context,
//     builder: (BuildContext context) {
//         return AlertDialog(
//         title: Text('Login Failed'),
//         content:  Text(e.toString()),
//         actions: <Widget>[
//           FlatButton(
//             child: Text('Ok'),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//         ]
//         );
//     },
//    );
//    }finally{
//       if(user != null){ 
//         switchToNextRoute();   
//       }
//    }
//   }
//   switchToNextRoute() async{
//        SharedPreferences prefs = await SharedPreferences.getInstance();
//         if(prefs.getString('regToken')==null){
//           _firebaseMessaging.getToken().then((token){
//              print('no token available in databse');
//              this.token = token;
//           });  
//           Firestore.instance.collection('Users').getDocuments().then((result){
//             result.documents.forEach((element){
//               if(element.data['email']==profile.email){
//                 db.collection('Users').document(element.documentID).updateData({'token':this.token});
//               }
//             });
//           });
//         }
//         mailController.text='';
//         passwordController.text='';
//         prefs.setString('userEmail', profile.email);
//          Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => HomePage(userProfile:profile),
//           ),
//         );  
//   }
// } 
//   class UserProfile{
//     String email;
//     String password;
//     UserProfile(this.email,this.password);
//   }
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            Background(),
            Login(),
          ],
        ));
  }
}

Widget roundedRectButton(
    String title, List<Color> gradient, bool isEndIconVisible) {
  return Builder(builder: (BuildContext mContext) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Stack(
        alignment: Alignment(1.0, 0.0),
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(mContext).size.width / 1.7,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              gradient: LinearGradient(
                  colors: gradient,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
            ),
            child: Text(title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500)),
            padding: EdgeInsets.only(top: 16, bottom: 16),
          ),
          Visibility(
            visible: isEndIconVisible,
            child: Padding(
                padding: EdgeInsets.only(right: 10),
                child: ImageIcon(
                  AssetImage("images/ic_forward.png"),
                  size: 30,
                  color: Colors.white,
                )),
          ),
        ],
      ),
    );
  });
}
class InputWidget extends StatelessWidget {
  final double topRight;
  final double bottomRight;

  InputWidget(this.topRight, this.bottomRight);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 40, bottom: 30),
      child: Container(
        width: MediaQuery.of(context).size.width - 40,
        child: Material(
          elevation: 10,
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(bottomRight),
                  topRight: Radius.circular(topRight))),
          child: Padding(
            padding: EdgeInsets.only(left: 40, right: 20, top: 10, bottom: 10),
            child: TextField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "9895180190",
                  hintStyle: TextStyle(color: Color(0xFFE1E1E1), fontSize: 14)),
            ),
          ),
        ),
      ),
    );
  }
}
class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          new Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Image.asset('images/collaboration.png', width: MediaQuery.of(context).size.width/1.5),
              WavyHeader(),
            ],
          ),
        ],
      ),
    );
  }
}

const List<Color> orangeGradients = [
  Color(0xFF3761f4),
  Color(0xFF3761f4),
  Color(0xFF1f4ef4),
];

class WavyHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TopWaveClipper(),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: orangeGradients,
              begin: Alignment.topLeft,
              end: Alignment.center),
        ),
        height: MediaQuery.of(context).size.height / 2.5,
      ),
    );
  }
}

class CirclePink extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(-70.0, 90.0),
      child: Material(
        color: Colors.pink,
        child: Padding(padding: EdgeInsets.all(120)),
        shape: CircleBorder(side: BorderSide(color: Colors.white, width: 15.0)),
      ),
    );
  }
}


class TopWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // This is where we decide what part of our image is going to be visible.
    var path = Path();
    path.lineTo(0.0, size.height);

    var firstControlPoint = new Offset(size.width / 7, size.height - 30);
    var firstEndPoint = new Offset(size.width / 6, size.height / 1.5);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint = Offset(size.width / 5, size.height / 4);
    var secondEndPoint = Offset(size.width / 1.5, size.height / 5);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    var thirdControlPoint =
        Offset(size.width - (size.width / 9), size.height / 6);
    var thirdEndPoint = Offset(size.width, 0.0);
    path.quadraticBezierTo(thirdControlPoint.dx, thirdControlPoint.dy,
        thirdEndPoint.dx, thirdEndPoint.dy);

    ///move from bottom right to top
    path.lineTo(size.width, 0.0);

    ///finally close the path by reaching start point from top right corner
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
const List<Color> signInGradients = [
  Color(0xFF3761f4),
  Color(0xFF03A0FE),
];


class Login extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height / 2),
        ),
        Column(
          children: <Widget>[
            ///holds email header and inputField
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 40, bottom: 10),
                  child: Text(
                    "Phone Number",
                    style: TextStyle(fontSize: 16, color: Color(0xFF999A9A)),
                  ),
                ),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: <Widget>[
                    InputWidget(30.0, 0.0),
                    Padding(
                        padding: EdgeInsets.only(right: 50),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                child: Padding(
                              padding: EdgeInsets.only(top: 40),
                              child: Text(
                                'Enter your phone number to continue...',
                                textAlign: TextAlign.end,
                                style: TextStyle(color: Color(0xFFA0A0A0),
                                fontSize: 12),
                              ),
                            )),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: ShapeDecoration(
                                shape: CircleBorder(),
                                gradient: LinearGradient(
                                    colors: signInGradients,
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight),
                              ),
                              child: ImageIcon(
                                AssetImage("images/ic_forward.png"),
                                size: 40,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ))
                  ],
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}