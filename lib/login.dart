
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reminderapp/verification.dart';



String verificationId;
TextEditingController _phoneNumberController = TextEditingController();
TextEditingController _phoneCodeController = TextEditingController();

class LoginPage extends StatefulWidget {
  @override 
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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


class InputWidget extends StatelessWidget {
  final double topRight;
  final double bottomRight;

  InputWidget(this.topRight, this.bottomRight);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10, bottom: 30),
      child: Row(
              children:<Widget>[ 
        Container(
        margin: const EdgeInsets.only(right: 5, left: 5),
          width: 50,
          child: Material(
            elevation: 10,
            color: Colors.white,
             child: Padding(
              padding: EdgeInsets.only(left:5,top: 10, bottom: 10),
              child:  TextField(
                controller: _phoneCodeController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "+91",
                    hintStyle: TextStyle(color: Color(0xFFE1E1E1), fontSize: 14)),
              ),
          ),
          ),
        ),
        Container(
          // margin: const EdgeInsets.only(left: 20),
          width: MediaQuery.of(context).size.width - 80,
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
                controller: _phoneNumberController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "9895180190",
                    hintStyle: TextStyle(color: Color(0xFFE1E1E1), fontSize: 14)),
              ),
            ),
          ),
        ),
      ],
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


class Login extends StatefulWidget{
  LoginPge createState()=> LoginPge();
}


class LoginPge extends State<Login> {
  String verificationId;
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
                              child: new InkWell(
                               child: ImageIcon(
                                  AssetImage("images/ic_forward.png"),
                                  size: 40,
                                  color: Colors.white,
                                ),
                                onTap: ()=>_sendCodeToPhoneNumber(),
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

  // loginWithSms(){
  //   print('object');
  //   _sendCodeToPhoneNumber();
  // }
    Future<void> _sendCodeToPhoneNumber() async {
    final PhoneVerificationCompleted verificationCompleted = (user) {
      setState(() {
          print('Inside _sendCodeToPhoneNumber: signInWithPhoneNumber auto succeeded: $user');
      });
    };

    final PhoneVerificationFailed verificationFailed = (AuthException authException) {
      setState(() {
        print('Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');}
        );
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      this.verificationId = verificationId;
      print("code sent to " + _phoneNumberController.text+verificationId);
        _phoneNumberController.text = '';
        _phoneCodeController.text = '';
          Navigator.push(
            context,
             MaterialPageRoute(
             builder: (context) => OtpPage(verificationId:verificationId),
              ),
           );   
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      this.verificationId = verificationId;
      print("time out");
    };

     await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: _phoneCodeController.text+_phoneNumberController.text,
        timeout: const Duration(seconds: 30),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return null;
  }
  
}