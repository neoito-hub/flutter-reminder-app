import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:reminderapp/profile.dart';

FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

class OtpPage extends StatefulWidget {
  final verificationId;
  OtpPage({Key key, @required this.verificationId}):super (key:key);

  @override
  OtpPageState createState() => OtpPageState(this.verificationId);
}

class OtpPageState extends State<OtpPage> {
  String token;
  String verificationId;
  OtpPageState(this.verificationId);

  TextEditingController controller1 = new TextEditingController();
  TextEditingController controller2 = new TextEditingController();
  TextEditingController controller3 = new TextEditingController();
  TextEditingController controller4 = new TextEditingController();
  TextEditingController controller5 = new TextEditingController();
  TextEditingController controller6 = new TextEditingController();

  TextEditingController currController = new TextEditingController();

  @override
  void dispose() {
    super.dispose();
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    controller4.dispose();
    controller5.dispose();
    controller6.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currController = controller1;

  }

  @override
  Widget build(BuildContext context) {
       List<Widget> widgetList = [

      Padding(
        padding: EdgeInsets.only(left: 0.0, right: 2.0),
        child: new Container(
          color: Colors.transparent,
        ),
      ),

      Padding(
        padding: const EdgeInsets.only(right: 2.0, left: 2.0),
        child: new Container(
            alignment: Alignment.center,
            decoration: new BoxDecoration(
                color: Colors.grey[200],
                border: new Border.all(
                    width: 1.0,
                    color: Colors.blue[300]
                ),
                borderRadius: new BorderRadius.circular(4.0)
            ),
            child: new TextField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
              ],
              enabled: true,
              keyboardType: TextInputType.number,
              controller: controller1,
              autofocus: false,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24.0, color: Colors.black),

            )

        ),
      ),

      Padding(
        padding: const EdgeInsets.only(right: 2.0, left: 2.0),
        child: new Container(
          alignment: Alignment.center,
          decoration: new BoxDecoration(
              color: Colors.grey[200],
              border: new Border.all(
                  width: 1.0,
                  color: Colors.blue[300]
              ),
              borderRadius: new BorderRadius.circular(4.0)
          ),
          child: new TextField(
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
            ],
            controller: controller2,
            autofocus: false,
            enabled: true,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24.0, color: Colors.black),
          ),
        ),
      ),

      Padding(
        padding: const EdgeInsets.only(right: 2.0, left: 2.0),
        child: new Container(
          alignment: Alignment.center,
          decoration: new BoxDecoration(
              color: Colors.grey[200],
              border: new Border.all(
                  width: 1.0,
                  color: Colors.blue[300]
              ),
              borderRadius: new BorderRadius.circular(4.0)
          ),
          child: new TextField(
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
            ],

            keyboardType: TextInputType.number,
            controller: controller3,
            textAlign: TextAlign.center,
            autofocus: false,
            enabled: true,
            style: TextStyle(fontSize: 24.0, color: Colors.black),
          ),
        ),
      ),

      Padding(
        padding: const EdgeInsets.only(right: 2.0, left: 2.0),
        child: new Container(
          alignment: Alignment.center,
          decoration: new BoxDecoration(
              color: Colors.grey[200],
              border: new Border.all(
                  width: 1.0,
                  color: Colors.blue[300]
              ),
              borderRadius: new BorderRadius.circular(4.0)
          ),
          child: new TextField(
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
            ],
              keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            controller: controller4,
            autofocus: false,
            enabled: true,
            style: TextStyle(fontSize: 24.0, color: Colors.black),
          ),
        ),
      ),

      Padding(
        padding: const EdgeInsets.only(right: 2.0, left: 2.0),
        child: new Container(
          alignment: Alignment.center,
          decoration: new BoxDecoration(
              color: Colors.grey[200],
              border: new Border.all(
                  width: 1.0,
                  color: Colors.blue[300]
              ),
              borderRadius: new BorderRadius.circular(4.0)
          ),
          child: new TextField(
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
            ],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            controller: controller5,
            autofocus: false,
            enabled: true,
            style: TextStyle(fontSize: 24.0, color: Colors.black),
          ),
        ),
      ),

      Padding(
        padding: const EdgeInsets.only(right: 2.0, left: 2.0),
        child: new Container(
          alignment: Alignment.center,
          decoration: new BoxDecoration(
              color: Colors.grey[200],
              border: new Border.all(
                  width: 1.0,
                  color: Colors.blue[300]
              ),
              borderRadius: new BorderRadius.circular(4.0)
          ),
          child: new TextField(
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
            ],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            controller: controller6,
            autofocus: false,
            enabled: true,
            style: TextStyle(fontSize: 24.0, color: Colors.black),
          ),
        ),
      ),

      Padding(
        padding: EdgeInsets.only(left: 2.0, right: 0.0),
        child: new Container(
          color: Colors.transparent,
        ),
      ),

    ];
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[

            Background(),
              Container(
                margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
              child: Column(
                // mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children:<Widget>[
                GridView.count (
                crossAxisCount:8,
                mainAxisSpacing: 10.0,
                shrinkWrap: true,
                primary: false,
                scrollDirection: Axis.vertical,
                children: List <Container>.generate(
                    8, (int index) => Container(child: widgetList[index])
                )
                ),
                 Padding(
                  padding: const EdgeInsets.only(top: 40.0, bottom: 40.0),
                  child: new Container (
                    width: 150.0,
                    height: 40.0,
                    child: new RaisedButton(onPressed: () {
                      var sms = controller1.text+controller2.text+controller3.text+controller4.text+controller5.text+controller6.text;
                     _signInWithPhoneNumber(sms);
                    },
                        child: Text("Submit OTP"),
                        textColor: Colors.white,
                        color: Colors.blue,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0))
                    ),
                  ),
                )
            ]
        ),
              ) 
          ],
        ));
  }
Future<String> _signInWithPhoneNumber(String smsCode) async {
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    await FirebaseAuth.instance.signInWithCredential(credential).then((FirebaseUser user) async {
          final FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
          assert(user.uid == currentUser.uid);
          if (user!=null){
            _firebaseMessaging.getToken().then((token){
             print(token);
             this.token = token;
          });
          var data = {
            'phone_number':user.phoneNumber,
            'uid':user.uid
          };
          Firestore.instance.collection('Users').add(data).catchError((onError){print(onError);}).then((response){ switchToNextRoute(user.uid);});

          }
        }).catchError((error){print(error);});
}
  switchToNextRoute(id) async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('regToken', token);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfilePage(),
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
              Container(
              child:Image.asset('images/collaboration.png', width: MediaQuery.of(context).size.width/1.5)),
              WavyHeader(),
            ],
          ),
        ],
      ),
    );
  }
}
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
const List<Color> orangeGradients = [
  Color(0xFF3761f4),
  Color(0xFF3761f4),
  Color(0xFF1f4ef4),
];