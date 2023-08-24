import 'package:flutter/material.dart';
import 'package:myapp/core/app_export.dart';
import 'package:myapp/widgets/app_bar/custom_app_bar.dart';
import 'package:myapp/widgets/custom_icon_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myapp/routes/app_routes.dart';
import 'package:myapp/presentation/menu_screen/menu_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SensitivityPopup extends StatefulWidget {
  final double currentSensitivity;
  final double minSensitivity;
  final double maxSensitivity;

  SensitivityPopup({
    required this.currentSensitivity,
    required this.minSensitivity,
    required this.maxSensitivity,
  });

  @override
  _SensitivityPopupState createState() => _SensitivityPopupState();
}

class _SensitivityPopupState extends State<SensitivityPopup> {
  double _currentSensitivity = 0.0;

  @override
  void initState() {
    super.initState();
    _loadSensitivity();
  }

  Future<void> _loadSensitivity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double savedSensitivity = prefs.getDouble('sensitivity') ?? widget.currentSensitivity;
    setState(() {
      _currentSensitivity = savedSensitivity;
    });
  }

  Future<void> _savedSensitivity(double value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('sensitivity', value);
  }





  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("민감도 설정"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("최소 민감도: ${widget.minSensitivity.toStringAsFixed(1)}"),
          Slider(
            value: _currentSensitivity,
            min: widget.minSensitivity,
            max: widget.maxSensitivity,
            onChanged: (newValue) {
              setState(() {
                _currentSensitivity = newValue;
              });
            },
          ),
          Text("최대 민감도: ${widget.maxSensitivity.toStringAsFixed(1)}"),
          Text("현재 민감도: ${_currentSensitivity.toStringAsFixed(1)}"),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () async{
            // 민감도 값을 저장하고 팝업창 닫기.
            await _savedSensitivity(_currentSensitivity);
            Navigator.pop(context, _currentSensitivity);
          },
          child: Text("저장"),
        ),
      ],
    );
  }
}







class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.blueGray50,
        appBar: CustomAppBar(
          height: getVerticalSize(135),
          leadingWidth: 78,
          leading: CustomIconButton(
            height: 48,
            width: 48,
            margin: getMargin(left: 30, top: 4, bottom: 4),
            padding: getPadding(all: 12),
            decoration: IconButtonStyleHelper.fillGray30001,
            onTap: () {
              onTapBtnArrowleft(context);
            },
            child: CustomImageView(svgPath: ImageConstant.imgArrowleft),
          ),
          centerTitle: true,
          title: Text(
            "Settings",
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: CustomTextStyles.headlineSmallBlack900,
          ),
        ),
        body: Container(
          height: getVerticalSize(791),
          width: double.maxFinite,
          padding: getPadding(left: 19, top: 14, right: 19, bottom: 14),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: getPadding(left: 45, top: 133, right: 34),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MenuScreen()),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                height: getSize(30),
                                width: getSize(30),
                                margin: getMargin(bottom: 3),
                                decoration: BoxDecoration(
                                  color: appTheme.deepOrange300,
                                  borderRadius: BorderRadius.circular(
                                    getHorizontalSize(6),
                                  ),
                                ),
                                child: Center(
                                    child: SvgPicture.asset(
                                      ImageConstant.imgMicrophone,
                                      height: getSize(20),
                                      width: getSize(20),
                                    )
                                )
                            ),
                            SizedBox(width: 20), // 텍스트와 아이콘 사이에 간격을 주기 위해 사용
                            Text(
                              "목소리 선택",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: CustomTextStyles.titleSmallRobotoBlack900,
                            ),
                            Spacer(), // 오른쪽에 공간을 만들어 마이크 아이콘과 분리
                            CustomImageView(
                              svgPath: ImageConstant.imgArrowright,
                              height: getVerticalSize(14),
                              width: getHorizontalSize(7),
                              onTap: () {
                                onTapImgArrowright(context);
                              },
                            ),
                          ],
                        ),
                      ),
                      // 상자 내부의 첫 번째 아이콘과 텍스트

                      // '목소리 미리 듣기 기능' 텍스트
                      Padding(
                        padding: getPadding(top: 8), // 이 부분 수정
                        child: Text(
                          "목소리 미리 듣기 기능",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 10,
                            color : Colors.grey,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      // 상자 내부의 세 번째 아이콘과 텍스트
                      Padding(
                        padding: getPadding(top: 123),
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => SensitivityPopup(
                                currentSensitivity: 0.5, // 현재 민감도 값을 여기에 제공합니다.
                                minSensitivity: 0.0,
                                maxSensitivity: 1.0,
                              ),
                            ).then((newSensitivity) {
                              // 팝업에서 반환된 새 민감도 값을 처리합니다.
                              if (newSensitivity != null) {
                                // 새 민감도 값을 저장하는 로직을 구현합니다.
                                // 예를 들어, 상태 관리나 환경 설정을 업데이트하는 함수를 호출할 수 있습니다.
                                print("새 민감도: $newSensitivity");
                              }
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  height: getSize(30),
                                  width: getSize(30),
                                  margin: getMargin(bottom: 3),
                                  decoration: BoxDecoration(
                                    color: appTheme.lightBlue300,
                                    borderRadius: BorderRadius.circular(
                                      getHorizontalSize(6),
                                    ),
                                  ),
                                  child: Center(
                                      child: Icon(
                                        Icons.touch_app,
                                        color: Colors.white,
                                      )
                                  )
                              ),
                              SizedBox(width: 20), // 텍스트와 아이콘 사이에 간격을 주기 위해 사용
                              Text(
                                "민감도 설정",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: CustomTextStyles.titleSmallRobotoBlack900,
                              ),
                              Spacer(),
                              CustomImageView(
                                svgPath: ImageConstant.imgArrowright,
                                height: getVerticalSize(14),
                                width: getHorizontalSize(7),
                                onTap: () {
                                  // 화살표 아이콘 클릭 처리 함수를 호출합니다.
                                  onTapArrowIcon(context);
                                },
                              ),
                            ],
                          ),
                        ),
                      )],
                  ),
                ),
              ),
            ], // children
          ),
        ),
      ),
    );
  }

  /// Navigates back to the previous screen.
  ///
  /// This function takes a [BuildContext] object as a parameter, which is used
  /// to navigate back to the previous screen.
  onTapBtnArrowleft(BuildContext context) {
    Navigator.pop(context);
  }

  /// Navigates to the menuScreen when the action is triggered.
  ///
  /// The [BuildContext] parameter is used to build the navigation stack.
  /// When the action is triggered, this function uses the `Navigator` widget
  /// to push the named route for the menuScreen.
  onTapImgArrowright(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MenuScreen(),
      ),
    );
  }

  onTapArrowIcon(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => SensitivityPopup(
        currentSensitivity: 0.5, // 현재 민감도 값을 여기에 제공합니다.
        minSensitivity: 0.0,
        maxSensitivity: 1.0,
      ),
    );
  }
}
