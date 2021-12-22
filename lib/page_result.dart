import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:jtbroulette/generated/locale_keys.g.dart';
import 'package:jtbroulette/page_home.dart';
import 'package:jtbroulette/utils.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:easy_localization/easy_localization.dart';

class PageResult extends StatefulWidget {
  const PageResult({Key? key, required this.selectedItem}) : super(key: key);

  final String selectedItem;

  @override
  _PageResultState createState() => _PageResultState();
}

final customWidth07 =
    CustomSliderWidths(trackWidth: 2, progressBarWidth: 10, shadowWidth: 20);
final customColors07 = CustomSliderColors(
    dotColor: Colors.white.withOpacity(0.1),
    trackColor: HexColor('#7EFFFF').withOpacity(0.2),
    progressBarColors: [
      HexColor('#17C5E5'),
      HexColor('#DFFF97'),
      HexColor('#04FFB5')
    ],
    shadowColor: HexColor('#0CA1BD'),
    shadowMaxOpacity: 0.05);

final CircularSliderAppearance appearance07 = CircularSliderAppearance(
    customWidths: customWidth07,
    customColors: customColors07,
    startAngle: 180,
    angleRange: 360,
    size: 250.0,
    spinnerMode: true);

class _PageResultState extends State<PageResult> {
  late Future<bool> isLoading;
  @override
  void initState() {
    isLoading = Future.delayed(Duration(seconds: 2), () {
      return false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future(() => false);
      },
      child: Scaffold(
        bottomSheet: FutureBuilder<Object>(
            initialData: true,
            future: isLoading,
            builder: (context, snapshot) {
              return snapshot.data == true
                  ? SizedBox.shrink()
                  : InkWell(
                      onTap: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => PageHome()),
                            (route) => false);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 18),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.red[500],
                          ),
                          height: 50,
                          width: double.infinity,
                          child: Center(
                            child: Text(LocaleKeys.retry.tr(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18)),
                          ),
                        ),
                      ),
                    );
            }),
        body: FutureBuilder<Object>(
            initialData: true,
            future: isLoading,
            builder: (context, snapshot) {
              return snapshot.data == true
                  ? Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                            HexColor('#FFFFFF'),
                            HexColor('#93EBEB')
                          ],
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                              tileMode: TileMode.clamp)),
                      child: SafeArea(
                        child: Center(
                            child: SleekCircularSlider(
                          onChangeStart: (double value) {},
                          onChangeEnd: (double value) {},
                          // innerWidget: viewModel.innerWidget,
                          appearance: appearance07,
                          min: 0,
                          max: 100,
                          initialValue: 50,
                        )),
                      ),
                    )
                  : Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 18),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                            HexColor('#FFFFFF'),
                            HexColor('#93EBEB')
                          ],
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                              tileMode: TileMode.clamp)),
                      child: SafeArea(
                        child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AnimatedTextKit(
                              animatedTexts: [
                                TypewriterAnimatedText(
                                  LocaleKeys.result_title1.tr(),
                                  textStyle: const TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  speed: const Duration(milliseconds: 200),
                                ),
                                TypewriterAnimatedText(
                                  LocaleKeys.result_title2.tr(),
                                  textStyle: const TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  speed: const Duration(milliseconds: 50),
                                ),
                                TypewriterAnimatedText(
                                  widget.selectedItem,
                                  textStyle: const TextStyle(
                                    fontSize: 32.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  speed: const Duration(milliseconds: 100),
                                ),
                              ],
                              totalRepeatCount: 1,
                            )
                          ],
                        )),
                      ),
                    );
            }),
      ),
    );
  }
}
