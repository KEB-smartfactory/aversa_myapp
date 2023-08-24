import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:just_audio/just_audio.dart';
import 'detector_view.dart';
import 'face_detector_painter.dart';

class FaceDetectorView extends StatefulWidget {
  @override
  State<FaceDetectorView> createState() => _FaceDetectorViewState();
}

class _FaceDetectorViewState extends State<FaceDetectorView> {
  final FaceDetector _faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableClassification: true,
      enableContours: true,
      enableLandmarks: true,
    ),
  );
  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  String? _text;
  String? status;
  var counter = 0;
  var _cameraLensDirection = CameraLensDirection.front;

  final AudioPlayer _audioPlayer = AudioPlayer();

  double? smile;

  @override
  void dispose() {
    _canProcess = false;
    _faceDetector.close();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DetectorView(
      title: 'Face Detector',
      customPaint: _customPaint,
      text: _text,
      onImage: _processImage,
      initialCameraLensDirection: _cameraLensDirection,
      onCameraLensDirectionChanged: (value) => _cameraLensDirection = value,
    );
  }

  Future<void> _processImage(InputImage inputImage) async {

    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    setState(() {
      _text = '';
    });

    final faces = await _faceDetector.processImage(inputImage);

    if (inputImage.metadata?.size != null &&
        inputImage.metadata?.rotation != null) {

      final painter = FaceDetectorPainter(
        faces,
        inputImage.metadata!.size,
        inputImage.metadata!.rotation,
        _cameraLensDirection,
      );

      for (final face in faces) {
        if (face.smilingProbability != null) {
          smile = face.smilingProbability;

          if (smile! > 0.6) {   //Ideal probability is 0.6
            status = 'Smile';
            if (!_audioPlayer.playing) {
              await _audioPlayer.setAsset('assets/mp3/2-happy.wav');
              await _audioPlayer.play();
            }
          } else {
            status = 'Unhappy';
          }
        }
        if ((face.rightEyeOpenProbability ?? 0.0) < 0.3 && (face.leftEyeOpenProbability ?? 0.0) < 0.3) {
          counter = counter + 1;
          status = 'Closed';
          //text += status;

          if (counter > 4) {
            // 'Driver Sleeping' 출력
            print('Driver Sleeping');

            // Show a snackbar with green background
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('졸음이 감지되었습니다'),
                backgroundColor: Colors.green, // Set background color to green
              ),
            );
            // WAV 파일 재생 (replace 'audioFilePath' with actual path)
            await _audioPlayer.setAsset('assets/mp3/3_sleep.wav');
            await _audioPlayer.play();

            counter = 1; // 카운터 초기화
            continue;
          }
        } else {
          counter = 0; // 눈이 열릴 경우 카운터 초기화
          status = 'Open';
          continue;
        }
      }

      _customPaint = CustomPaint(painter: painter);
    } else {
      String text = 'Faces found: ${faces.length}\n\n';
      for (final face in faces) {
        text += 'face: ${face.boundingBox}\n\n';
      }
      _text = text;
      _customPaint = null;
    }
    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }

  bool areEyesClosed(Face face) {
    double threshold = 0.3; // 눈을 감은/떴을 때의 예시 임계값
    return face.leftEyeOpenProbability! < threshold && face.rightEyeOpenProbability! < threshold;
  }
}



