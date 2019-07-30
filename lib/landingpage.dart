import 'package:flutter/material.dart';


class LandingPage extends StatefulWidget {
  final reminder;
  LandingPage({Key key,@required this.reminder}):super(key:key);
  @override
  _LandingPageState createState() => _LandingPageState(this.reminder);

}

class _LandingPageState extends State<LandingPage> {
  void initState(){
    super.initState();
    print(this.reminder);
  }
    var reminder;
  _LandingPageState(this.reminder);
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Column(
          children: <Widget>[
       Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: Container(
      height: 115.0,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 50.0,
            child: reminderCard,
          ),
          Positioned(top: 7.5, child: reminderImage),
        ],
      ),
    ),
       )
          ],
      ),
    );
  }
  Widget get reminderImage {
  return Container(
      // You can explicitly set heights and widths on Containers.
      // Otherwise they take up as much space as their children.
    width: 100.0,
    height: 100.0,
      // Decoration is a property that lets you style the container.
      // It expects a BoxDecoration.
    decoration: BoxDecoration(
      // BoxDecorations have many possible properties.
      // Using BoxShape with a background image is the
      // easiest way to make a circle cropped avatar style image.
      shape: BoxShape.circle,
      image: DecorationImage(
        // Just like CSS's `imagesize` property.
        fit: BoxFit.cover,
        // A NetworkImage widget is a widget that
        // takes a URL to an image.
        // ImageProviders (such as NetworkImage) are ideal
        // when your image needs to be loaded or can change.
        // Use the null check to avoid an error.
        image: AssetImage('images/reminder.png'),
      ),
    ),
  );
}

Widget get reminderCard {
  // A new container
  // The height and width are arbitrary numbers for styling.
  return Container(
    width: 200.0,
    height: 115.0,
    child: Card(
      color: Colors.white,
      // Wrap children in a Padding widget in order to give padding.
      child: Padding(
        // The class that controls padding is called 'EdgeInsets'
        // The EdgeInsets.only constructor is used to set
        // padding explicitly to each side of the child.
        padding: const EdgeInsets.only(
          top: 8.0,
          bottom: 8.0,
          left: 64.0,
        ),
        // Column is another layout widget -- like stack -- that
        // takes a list of widgets as children, and lays the
        // widgets out from top to bottom.
        child: Column(
          // These alignment properties function exactly like
          // CSS flexbox properties.
          // The main axis of a column is the vertical axis,
          // `MainAxisAlignment.spaceAround` is equivalent of
          // CSS's 'justify-content: space-around' in a vertically
          // laid out flexbox.
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text('Name of the reminder',
                // Themes are set in the MaterialApp widget at the root of your app.
                // They have default values -- which we're using because we didn't set our own.
                // They're great for having consistent, app-wide styling that's easily changed.
                style: Theme.of(context).textTheme.headline),
            Text('widget.dog.location',
                style: Theme.of(context).textTheme.subhead),
            Row(
              children: <Widget>[
                Icon(
                  Icons.star,
                ),
                Text('text here')
              ],
            )
          ],
        ),
      ),
    ),
  );
}
}