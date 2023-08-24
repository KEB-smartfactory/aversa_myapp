import 'package:flutter/material.dart';
import 'package:myapp/core/app_export.dart';
import 'package:myapp/presentation/face_detection_screen/face_detection_screen.dart';
import 'package:myapp/widgets/custom_elevated_button.dart';
import 'package:myapp/widgets/custom_icon_button.dart';
import 'package:just_audio/just_audio.dart';
import 'package:myapp/presentation/face_detection_screen/face_detector_view.dart';
// import 'package:myapp/presentation/face_detection_screen/result_provider.dart';
// import 'package:myapp/presentation/face_detection_screen/face_detection_screen2.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class MenuScreen extends StatefulWidget {
  MenuScreen({Key? key}) : super(key: key);

  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final AudioPlayer player = AudioPlayer();
  // final faceDetectionScreen2 = FaceDetectionScreen2();
  String _faceDetectionResult = "";
  int _selectedVoiceIndex = 0;

  Future<void> playAudio(String audioPath) async {
    print("Playing audio: $audioPath");
    await player.setAsset(audioPath);
    await player.play();
  }

  void initState() {
    super.initState();
    // _loadFaceDetectionResult();
  }

  // void _loadFaceDetectionResult() {
  //   _faceDetectionResult =
  //       Provider.of<ResultProvider>(context, listen: false).result;
  // }

  void _saveSelectedVoiceIndex(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('selectedVoiceIndex', index);
  }

  void _showConfirmationDialog() async {
    bool isConfirmed = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('파일 재생 완료'),
        content: Text('pre.wav 파일을 재생하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('예'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('아니오'),
          ),
        ],
      ),
    );
  }

  void playMusicBasedOnFaceDetectionResult1() {
    if (_faceDetectionResult == "happy") {
      playAudio('assets/mp3/1_happy.wav');
    } else if (_faceDetectionResult == "sad") {
      playAudio('assets/mp3/1_sad.wav');
    } else if (_faceDetectionResult == "surprise") {
      playAudio('assets/mp3/1_surprise.wav');
    } else if (_faceDetectionResult == "neutral") {
      playAudio('assets/mp3/1_neutral.wav');
    }
    _showConfirmationDialog();
  }

  void playMusicBasedOnFaceDetectionResult2() {
    if (_faceDetectionResult == "happy") {
      playAudio('assets/mp3/2-happy.wav');
    } else if (_faceDetectionResult == "sad") {
      playAudio('assets/mp3/2-sad.wav');
    } else if (_faceDetectionResult == "surprise") {
      playAudio('assets/mp3/2-surprise.wav');
    } else if (_faceDetectionResult == "neutral") {
      playAudio('assets/mp3/2-neutral.wav');
    }
    _showConfirmationDialog();
  }

  void playMusicBasedOnFaceDetectionResult3() {
    if (_faceDetectionResult == "happy") {
      playAudio('assets/mp3/2-happy.wav');
    } else if (_faceDetectionResult == "sad") {
      playAudio('assets/mp3/2-sad.wav');
    } else if (_faceDetectionResult == "surprise") {
      playAudio('assets/mp3/2-sad.wav');
    } else if (_faceDetectionResult == "neutral") {
      playAudio('assets/mp3/2-sad.wav');
    }
    _showConfirmationDialog();
  }

  void playPreAudio() {
    playAudio('assets/mp3/Summer Vacation_full.wav');
  }

  int selectedVoiceIndex = -1;

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            backgroundColor: appTheme.whiteA700,
            body: SizedBox(
                width: getHorizontalSize(427),
                child: SingleChildScrollView(
                    child: Container(
                        padding: getPadding(
                            left: 24, top: 92, right: 24, bottom: 92),
                        decoration: AppDecoration.fill1,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                  padding: getPadding(left: 1),
                                  child: Row(children: [
                                    CustomIconButton(
                                        height: 48,
                                        width: 48,
                                        padding: getPadding(all: 12),
                                        decoration:
                                        IconButtonStyleHelper.fillGray30001,
                                        onTap: () {
                                          onTapBtnArrowleft(context);
                                        },
                                        child: CustomImageView(
                                            svgPath:
                                            ImageConstant.imgArrowleft)),
                                    Padding(
                                        padding: getPadding(
                                            left: 79, top: 9, bottom: 9),
                                        child: Text("select voice",
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style:
                                            theme.textTheme.headlineSmall))
                                  ])),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedVoiceIndex = 1;
                                    // playMusicBasedOnFaceDetectionResult1();
                                  });
                                },
                                child: Padding(
                                    padding: getPadding(left: 1, top: 40),
                                    child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Card(
                                              clipBehavior: Clip.antiAlias,
                                              elevation: 0,
                                              margin: EdgeInsets.all(0),
                                              color: appTheme.lightGreenA200,
                                              shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                      color: appTheme.whiteA700,
                                                      width: getHorizontalSize(
                                                          10)),
                                                  borderRadius:
                                                  BorderRadiusStyle
                                                      .roundedBorder50),
                                              child: Container(
                                                  height: getVerticalSize(101),
                                                  width: getHorizontalSize(100),
                                                  decoration: AppDecoration
                                                      .outline2
                                                      .copyWith(
                                                      borderRadius:
                                                      BorderRadiusStyle
                                                          .roundedBorder50),
                                                  child: Stack(
                                                      alignment:
                                                      Alignment.center,
                                                      children: [
                                                        CustomImageView(
                                                            imagePath:
                                                            ImageConstant
                                                                .imgRectangle,
                                                            height:
                                                            getVerticalSize(
                                                                101),
                                                            width:
                                                            getHorizontalSize(
                                                                96),
                                                            alignment: Alignment
                                                                .center),
                                                        Align(
                                                            alignment: Alignment
                                                                .center,
                                                            child: Card(
                                                                clipBehavior: Clip
                                                                    .antiAlias,
                                                                elevation: 0,
                                                                margin:
                                                                EdgeInsets
                                                                    .all(0),
                                                                color: appTheme
                                                                    .lightGreenA200,
                                                                shape: RoundedRectangleBorder(
                                                                    side: BorderSide(
                                                                        color: appTheme
                                                                            .whiteA700,
                                                                        width: getHorizontalSize(
                                                                            10)),
                                                                    borderRadius:
                                                                    BorderRadiusStyle
                                                                        .roundedBorder50),
                                                                child:
                                                                Container(
                                                                    height: getVerticalSize(
                                                                        101),
                                                                    width: getHorizontalSize(
                                                                        100),
                                                                    decoration: AppDecoration
                                                                        .outline2
                                                                        .copyWith(borderRadius: BorderRadiusStyle.roundedBorder50),
                                                                    child: Stack(children: [
                                                                      CustomImageView(
                                                                          imagePath: ImageConstant.imgRectangle,
                                                                          height: getVerticalSize(101),
                                                                          width: getHorizontalSize(96),
                                                                          alignment: Alignment.center)
                                                                    ]))))
                                                      ]))),
                                          Container(
                                              margin:
                                              getMargin(top: 9, bottom: 41),
                                              decoration:
                                              AppDecoration.fill4.copyWith(
                                                borderRadius: BorderRadiusStyle
                                                    .roundedBorder24,
                                                border: Border.all(
                                                    color: selectedVoiceIndex ==
                                                        1
                                                        ? Colors.blue
                                                        : Colors.transparent,
                                                    width: 2.0),
                                              ),
                                              child: Column(
                                                  mainAxisSize:
                                                  MainAxisSize.min,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  children: [
                                                    CustomImageView(
                                                        imagePath: ImageConstant
                                                            .imgSong,
                                                        height:
                                                        getVerticalSize(1),
                                                        width:
                                                        getHorizontalSize(
                                                            16)),
                                                    Padding(
                                                        padding: getPadding(
                                                            left: 8,
                                                            top: 8,
                                                            bottom: 8),
                                                        child: Row(children: [
                                                          SizedBox(
                                                              height:
                                                              getSize(32),
                                                              width:
                                                              getSize(32),
                                                              child: Stack(
                                                                  alignment:
                                                                  Alignment
                                                                      .center,
                                                                  children: [
                                                                    Align(
                                                                        alignment:
                                                                        Alignment
                                                                            .center,
                                                                        child: Container(
                                                                            height:
                                                                            getSize(2),
                                                                            width: getSize(2),
                                                                            decoration: BoxDecoration(color: appTheme.indigoA200, borderRadius: BorderRadius.circular(getHorizontalSize(1))))),
                                                                    CustomIconButton(
                                                                        height:
                                                                        32,
                                                                        width:
                                                                        32,
                                                                        padding: getPadding(
                                                                            all:
                                                                            6),
                                                                        alignment:
                                                                        Alignment
                                                                            .center,
                                                                        onTap:
                                                                            () {
                                                                          playAudio(
                                                                              'assets/mp3/1_preview.wav');
                                                                        },
                                                                        child: CustomImageView(
                                                                            svgPath:
                                                                            ImageConstant.imgPlay))
                                                                  ])),
                                                          CustomImageView(
                                                              svgPath:
                                                              ImageConstant
                                                                  .imgWaveform,
                                                              height:
                                                              getVerticalSize(
                                                                  32),
                                                              width:
                                                              getHorizontalSize(
                                                                  86),
                                                              margin: getMargin(
                                                                  left: 12)),
                                                          Opacity(
                                                              opacity: 0.66,
                                                              child: Padding(
                                                                  padding:
                                                                  getPadding(
                                                                      left:
                                                                      12,
                                                                      top:
                                                                      6,
                                                                      bottom:
                                                                      5),
                                                                  child: Text(
                                                                      "0:05",
                                                                      overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                      textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                      style: theme
                                                                          .textTheme
                                                                          .bodyMedium))),
                                                          Opacity(
                                                              opacity: 0.66,
                                                              child: CustomImageView(
                                                                  svgPath:
                                                                  ImageConstant
                                                                      .imgVolume,
                                                                  height:
                                                                  getSize(
                                                                      24),
                                                                  width:
                                                                  getSize(
                                                                      24),
                                                                  margin: getMargin(
                                                                      left: 12,
                                                                      top: 4,
                                                                      bottom:
                                                                      4)))
                                                        ]))
                                                  ]))
                                        ])),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedVoiceIndex = 2;
                                    // playMusicBasedOnFaceDetectionResult2();
                                  });
                                },
                                child: Padding(
                                    padding: getPadding(left: 8, top: 45),
                                    child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          CustomImageView(
                                              imagePath: ImageConstant
                                                  .imgRectangle101x100,
                                              height: getSize(100),
                                              width: getSize(100),
                                              radius: BorderRadius.circular(
                                                  getHorizontalSize(50))),
                                          Container(
                                              margin:
                                              getMargin(top: 9, bottom: 41),
                                              decoration:
                                              AppDecoration.fill4.copyWith(
                                                borderRadius: BorderRadiusStyle
                                                    .roundedBorder24,
                                                border: Border.all(
                                                    color: selectedVoiceIndex ==
                                                        2
                                                        ? Colors.blue
                                                        : Colors.transparent,
                                                    width: 2.0),
                                              ),
                                              child: Column(
                                                  mainAxisSize:
                                                  MainAxisSize.min,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  children: [
                                                    CustomImageView(
                                                        imagePath: ImageConstant
                                                            .imgSong,
                                                        height:
                                                        getVerticalSize(1),
                                                        width:
                                                        getHorizontalSize(
                                                            16)),
                                                    Padding(
                                                        padding: getPadding(
                                                            left: 8,
                                                            top: 8,
                                                            bottom: 8),
                                                        child: Row(children: [
                                                          SizedBox(
                                                              height:
                                                              getSize(32),
                                                              width:
                                                              getSize(32),
                                                              child: Stack(
                                                                  alignment:
                                                                  Alignment
                                                                      .center,
                                                                  children: [
                                                                    Align(
                                                                        alignment:
                                                                        Alignment
                                                                            .center,
                                                                        child: Container(
                                                                            height:
                                                                            getSize(2),
                                                                            width: getSize(2),
                                                                            decoration: BoxDecoration(color: appTheme.indigoA200, borderRadius: BorderRadius.circular(getHorizontalSize(1))))),
                                                                    CustomIconButton(
                                                                        height:
                                                                        32,
                                                                        width:
                                                                        32,
                                                                        padding: getPadding(
                                                                            all:
                                                                            6),
                                                                        alignment:
                                                                        Alignment
                                                                            .center,
                                                                        onTap:
                                                                            () {
                                                                          playAudio(
                                                                              'assets/mp3/2_preview.wav');
                                                                        },
                                                                        child: CustomImageView(
                                                                            svgPath:
                                                                            ImageConstant.imgPlay))
                                                                  ])),
                                                          CustomImageView(
                                                              svgPath:
                                                              ImageConstant
                                                                  .imgWaveform,
                                                              height:
                                                              getVerticalSize(
                                                                  32),
                                                              width:
                                                              getHorizontalSize(
                                                                  86),
                                                              margin: getMargin(
                                                                  left: 12)),
                                                          Opacity(
                                                              opacity: 0.66,
                                                              child: Padding(
                                                                  padding:
                                                                  getPadding(
                                                                      left:
                                                                      12,
                                                                      top:
                                                                      6,
                                                                      bottom:
                                                                      5),
                                                                  child: Text(
                                                                      "0:05",
                                                                      overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                      textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                      style: theme
                                                                          .textTheme
                                                                          .bodyMedium))),
                                                          Opacity(
                                                              opacity: 0.66,
                                                              child: CustomImageView(
                                                                  svgPath:
                                                                  ImageConstant
                                                                      .imgVolume,
                                                                  height:
                                                                  getSize(
                                                                      24),
                                                                  width:
                                                                  getSize(
                                                                      24),
                                                                  margin: getMargin(
                                                                      left: 12,
                                                                      top: 4,
                                                                      bottom:
                                                                      4)))
                                                        ]))
                                                  ]))
                                        ])),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedVoiceIndex = 3;
                                    // playMusicBasedOnFaceDetectionResult3();
                                  });
                                },
                                child: Padding(
                                    padding: getPadding(left: 8, top: 45),
                                    child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          CustomImageView(
                                              imagePath: ImageConstant
                                                  .imgRectangle100x100,
                                              height: getSize(100),
                                              width: getSize(100),
                                              radius: BorderRadius.circular(
                                                  getHorizontalSize(50))),
                                          Container(
                                              margin:
                                              getMargin(top: 9, bottom: 41),
                                              decoration:
                                              AppDecoration.fill4.copyWith(
                                                borderRadius: BorderRadiusStyle
                                                    .roundedBorder24,
                                                border: Border.all(
                                                    color: selectedVoiceIndex ==
                                                        3
                                                        ? Colors.blue
                                                        : Colors.transparent,
                                                    width: 2.0),
                                              ),
                                              child: Column(
                                                  mainAxisSize:
                                                  MainAxisSize.min,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  children: [
                                                    CustomImageView(
                                                        imagePath: ImageConstant
                                                            .imgSong,
                                                        height:
                                                        getVerticalSize(1),
                                                        width:
                                                        getHorizontalSize(
                                                            16)),
                                                    Padding(
                                                        padding: getPadding(
                                                            left: 8,
                                                            top: 8,
                                                            bottom: 8),
                                                        child: Row(children: [
                                                          SizedBox(
                                                              height:
                                                              getSize(32),
                                                              width:
                                                              getSize(32),
                                                              child: Stack(
                                                                  alignment:
                                                                  Alignment
                                                                      .center,
                                                                  children: [
                                                                    Align(
                                                                        alignment:
                                                                        Alignment
                                                                            .center,
                                                                        child: Container(
                                                                            height:
                                                                            getSize(2),
                                                                            width: getSize(2),
                                                                            decoration: BoxDecoration(color: appTheme.indigoA200, borderRadius: BorderRadius.circular(getHorizontalSize(1))))),
                                                                    CustomIconButton(
                                                                        height:
                                                                        32,
                                                                        width:
                                                                        32,
                                                                        padding: getPadding(
                                                                            all:
                                                                            6),
                                                                        alignment:
                                                                        Alignment
                                                                            .center,
                                                                        onTap:
                                                                            () {
                                                                          playAudio(
                                                                              'assets/mp3/3-preview.wav');
                                                                        },
                                                                        child: CustomImageView(
                                                                            svgPath:
                                                                            ImageConstant.imgPlay))
                                                                  ])),
                                                          CustomImageView(
                                                              svgPath:
                                                              ImageConstant
                                                                  .imgWaveform,
                                                              height:
                                                              getVerticalSize(
                                                                  32),
                                                              width:
                                                              getHorizontalSize(
                                                                  86),
                                                              margin: getMargin(
                                                                  left: 12)),
                                                          Opacity(
                                                              opacity: 0.66,
                                                              child: Padding(
                                                                  padding:
                                                                  getPadding(
                                                                      left:
                                                                      12,
                                                                      top:
                                                                      6,
                                                                      bottom:
                                                                      5),
                                                                  child: Text(
                                                                      "0:05",
                                                                      overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                      textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                      style: theme
                                                                          .textTheme
                                                                          .bodyMedium))),
                                                          Opacity(
                                                              opacity: 0.66,
                                                              child: CustomImageView(
                                                                  svgPath:
                                                                  ImageConstant
                                                                      .imgVolume,
                                                                  height:
                                                                  getSize(
                                                                      24),
                                                                  width:
                                                                  getSize(
                                                                      24),
                                                                  margin: getMargin(
                                                                      left: 12,
                                                                      top: 4,
                                                                      bottom:
                                                                      4)))
                                                        ]))
                                                  ]))
                                        ])),
                              ),
                              CustomElevatedButton(
                                  text: "Select Voice",
                                  margin: getMargin(
                                      left: 36, top: 68, right: 47, bottom: 68),
                                  buttonStyle: CustomButtonStyles.fillPrimary
                                      .copyWith(
                                      fixedSize:
                                      MaterialStateProperty.all<Size>(
                                          Size(double.maxFinite,
                                              getVerticalSize(48)))),
                                  buttonTextStyle: theme.textTheme.titleMedium!,
                                  alignment: Alignment.center,
                                  onTap: () {
                                    if (selectedVoiceIndex != -1) {
                                      if (selectedVoiceIndex == 1) {
                                        playMusicBasedOnFaceDetectionResult1();
                                        Navigator.pop(context);
                                      } else if (selectedVoiceIndex == 2) {
                                        playMusicBasedOnFaceDetectionResult2();
                                        Navigator.pop(context);
                                      } else if (selectedVoiceIndex == 3) {
                                        playMusicBasedOnFaceDetectionResult3();
                                        Navigator.pop(context);
                                      }
                                      _saveSelectedVoiceIndex(selectedVoiceIndex);
                                      Navigator.pop(context);
                                    }
                                  })
                            ]))))));
  }

  onTapBtnArrowleft(BuildContext context) {
    Navigator.pop(context);
  }
}
