import 'package:flutter/material.dart';
import 'package:myapp/core/app_export.dart';
import 'package:myapp/presentation/face_detection_screen/face_detector_view.dart';
import 'package:myapp/widgets/custom_icon_button.dart';

import 'package:myapp/presentation/settings_screen/settings_screen.dart';
import 'package:myapp/presentation/notifications/notifications.dart';
import 'package:myapp/presentation/help&support/help&support.dart';
import 'package:myapp/presentation/about/about.dart';

class FaceDetectionScreen extends StatefulWidget {
  const FaceDetectionScreen({Key? key}) : super(key: key);

  @override
  _FaceDetectionScreenState createState() => _FaceDetectionScreenState();
}

class _FaceDetectionScreenState extends State<FaceDetectionScreen> {


  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.gray300,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.green,
          elevation : 0.0,
          actions: <Widget> [],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              ListTile(
                leading: Icon(
                  Icons.info,
                  color: Colors.grey[850],
                ),
                title: Text('About'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutPage()),
                  );
                },
                trailing: Icon(Icons.add),
              ),
              ListTile(
                leading: Icon(
                  Icons.notifications,
                  color: Colors.grey[850],
                ),
                title: Text('Notifications'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NotificationPage()),
                  );
                },
                trailing: Icon(Icons.add),
              ),
              ListTile(
                leading: Icon(
                  Icons.settings,
                  color: Colors.grey[850],
                ),
                title: Text('Settings'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsScreen()),
                  );
                },
                trailing: Icon(Icons.add),
              ),
              ListTile(
                leading: Icon(
                  Icons.help,
                  color: Colors.grey[850],
                ),
                title: Text('Help and Support'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HelpPage()),
                  );
                },
                trailing: Icon(Icons.add),
              ),
            ],
          ),
        ),
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: getPadding(top: 12),
                child: Text(
                  "FACE DETECTION",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: theme.textTheme.headlineMedium,
                ),
              ),
              Container(
                width: getHorizontalSize(182),
                margin: getMargin(top: 30),
                child: Text(
                  "Please look the camera\nuntill you hear bell",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyLarge,
                ),
              ),
              Container(
                height: getVerticalSize(283),
                width: getHorizontalSize(246),
                margin: getMargin(top: 89),
                decoration: AppDecoration.outline,
                child: Stack(
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.img3dfaceright2,
                      height: getVerticalSize(283),
                      width: getHorizontalSize(246),
                      alignment: Alignment.center,
                    )
                  ],
                ),
              ),
              Spacer(),
              CustomIconButton(
                height: 69,
                width: 265,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FaceDetectorView()),
                  );
                },
                child: Text('Start'),
              )
            ],
          ),
        ),
      ),
    );
  }


}
