import 'package:flutter/material.dart';
import 'package:myapp/core/app_export.dart';
import 'package:myapp/widgets/custom_icon_button.dart';
import 'package:myapp/presentation/settings_screen/settings_screen.dart';
import 'package:myapp/presentation/notifications/notifications.dart';
import 'package:myapp/presentation/help&support/help&support.dart';
import 'package:myapp/presentation/about/about.dart';
import 'package:camera/camera.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';
import 'package:provider/provider.dart';

class FaceDetectionScreen2 extends StatefulWidget {
  const FaceDetectionScreen2({Key? key}) : super(key: key);

  @override
  _FaceDetectionScreenState2 createState() => _FaceDetectionScreenState2();
}

class _FaceDetectionScreenState2 extends State<FaceDetectionScreen2> {
  late CameraImage cameraImage;
  late CameraController cameraController;
  String result = "";
  String conf = "";
  List<CameraDescription> cameras=[];


  Future<void> initCamera() async {
    final cameras = await availableCameras();
    cameraController = CameraController(cameras[1], ResolutionPreset.low);

    try {
      await cameraController.initialize();
    } catch (e) {
      print("Camera initialization error: $e");
    }

    if (mounted) {
      setState(() {});
    }

    if (await Permission.camera.isGranted) {
      cameraController.startImageStream((imageStream) {
        runModel(imageStream);
      });
    } else {
      var status = await Permission.camera.request();
      if (status.isGranted) {
        cameraController.startImageStream((imageStream) {
          runModel(imageStream);
        });
      } else {
        print("Camera permission denied");
      }
    }
  }
  void loadModel() async {
    await Tflite.loadModel(
      model: "assets/fer_model.tflite",
      labels: "assets/emotion_labels.txt",
    );
  }

  void runModel(CameraImage imageStream) async {


    try {
      var recognitions = await Tflite.runModelOnFrame(
        bytesList: imageStream.planes.map((plane) {
          return plane.bytes;
        }).toList(),
        imageHeight: imageStream.height,
        imageWidth: imageStream.width,
        imageMean: 127.5,
        imageStd: 127.5,
        rotation: 90,
        numResults: 7,
        threshold: 0.001,
        asynch: true,
      );

      // 이 부분이 수정되 부분임? //
      if (recognitions != null && recognitions.isNotEmpty) {
        double sadConfidenceSum = 0.0;
        double surpriseConfidenceSum = 0.0;
        double happyConfidenceSum = 0.0;
        double neutralConfidenceSum = 0.0;

        for (var recognition in recognitions) {
          String label = recognition["label"];
          double confidence = recognition["confidence"];

          if (label == "sad" || label == "disgust") {
            sadConfidenceSum += confidence;
          } else if (label == "surprise" || label == "fear" || label == "angry") {
            surpriseConfidenceSum += confidence;
          }else if ( label == "happy") {
            happyConfidenceSum += confidence;
          }else if ( label == "neutral") {
            neutralConfidenceSum += confidence;
          }
        }

        String maxLabel = "";
        double maxConfidence = 0.0;


        if (sadConfidenceSum >= maxConfidence) {
          maxConfidence = sadConfidenceSum;
          maxLabel = "sad";
        }
        if (surpriseConfidenceSum >= maxConfidence) {
          maxConfidence = surpriseConfidenceSum;
          maxLabel = "surprise";
        }
        if (happyConfidenceSum >= maxConfidence) {
          maxConfidence = happyConfidenceSum;
          maxLabel = "happy";
        }if (neutralConfidenceSum >= maxConfidence) {
          maxConfidence = surpriseConfidenceSum;
          maxLabel = "neutral";
        }


        setState(() {
          result = maxLabel;
          conf = maxConfidence.toString();
          print("Label: $maxLabel, Confidence : $maxConfidence");
          // if(maxConfidence >= 0.3) {
          //   showFaceDetectedDialog(context);
          //   cameraController.stopImageStream();
          // }
        });
      }
    } catch (e) {
      print("Error running model: $e");
    }
  }



  @override
  void initState() {
    super.initState();
    initCamera();
    loadModel();
  }

  @override
  void dispose() {
    cameraController.dispose();
    Tflite.close();
    super.dispose();
  }

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
                  "ddmdmdm",
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
                height: getVerticalSize(300),
                width: getHorizontalSize(300),
                margin: getMargin(top: 89),
                decoration: AppDecoration.outline,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: cameraController.value.isInitialized
                          ? AspectRatio(
                        aspectRatio: cameraController.value.aspectRatio,
                        child: CameraPreview(cameraController),
                      )
                          : Container(),

                    ),

                  ],
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }


}