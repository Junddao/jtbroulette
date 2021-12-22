import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:jtbroulette/admob_service.dart';
import 'package:jtbroulette/generated/locale_keys.g.dart';
import 'package:jtbroulette/page_result.dart';
import 'package:jtbroulette/utils.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:easy_localization/easy_localization.dart';

class PageList extends StatefulWidget {
  const PageList({Key? key, required this.quantity}) : super(key: key);

  final int quantity;

  @override
  _PageListState createState() => _PageListState();
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

class _PageListState extends State<PageList> {
  InterstitialAd? _interstitialAd;
  int _numInterstitialLoadAttempts = 0;

  int maxFailedLoadAttempts = 3;

  List<TextEditingController>? controllers;

  List<Color?> colors = [
    Colors.red[100],
    Colors.blue[100],
    Colors.yellow[100],
    Colors.teal[100],
    Colors.purple[100],
    Colors.pink[100],
    Colors.red[100],
    Colors.blue[100],
    Colors.yellow[100],
    Colors.teal[100],
  ];

  String selectedItem = '';
  bool isLoading = false;

  @override
  void initState() {
    _createInterstitialAd();
    controllers =
        List.generate(widget.quantity, (index) => TextEditingController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      // resizeToAvoidBottomInset: true,
      bottomSheet: isLoading == true
          ? SizedBox.shrink()
          : InkWell(
              onTap: () {
                var result = selectItem();
                if (result == true) {
                  _showInterstitialAd();
                  setState(() {
                    isLoading = true;
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(LocaleKeys.error1.tr() + '😀'),
                    duration: Duration(seconds: 1),
                  ));
                  return;
                }
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.red[500],
                  ),
                  height: 50,
                  width: double.infinity,
                  child: Center(
                    child: Text(LocaleKeys.random_select.tr(),
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18)),
                  ),
                ),
              ),
            ),
      appBar: AppBar(
        title: Text(LocaleKeys.input_page.tr()),
      ),
      body: isLoading == true
          ? Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [HexColor('#FFFFFF'), HexColor('#93EBEB')],
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
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: widget.quantity,
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(),
                      itemBuilder: (BuildContext context, int index) {
                        // 여기에 입력하는 창 넣고
                        // 입력된 값을 저장하고
                        // 확인 눌렀을때 그걸 뺑뺑이 돌려서
                        // 그중에 하나 보여주면 끝

                        return Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: colors[index],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            leading: Stack(
                              children: [
                                Image.asset(
                                  'assets/images/memo.png',
                                  fit: BoxFit.contain,
                                ),
                                Positioned(
                                  top: 5,
                                  right: 10,
                                  child: Text(
                                    '${index + 1}',
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            title: TextField(
                              controller: controllers![index],
                              maxLength: 20,
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 90,
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  bool selectItem() {
    for (var c in controllers!) {
      if (c.text == '') {
        return false;
      }
    }
    int randomNum = Random().nextInt(widget.quantity);
    selectedItem = controllers![randomNum].text;

    return true;
  }

  void _showInterstitialAd() {
    if (_interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('11111111');
        ad.dispose();
        _createInterstitialAd();
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => PageResult(
                    selectedItem: selectedItem,
                  )),
        );
        isLoading = false;
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('22222222');
        ad.dispose();
        _createInterstitialAd();
      },
      onAdShowedFullScreenContent: (InterstitialAd ad) => print('333333333'),
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }

  void _createInterstitialAd() {
    String adId = AdMobService().getInterstitialAdId()!;
    // String adId = 'ca-app-pub-3940256099942544/1033173712';
    InterstitialAd.load(
        adUnitId: adId,
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            _interstitialAd = ad;
            _numInterstitialLoadAttempts = 0;
          },
          onAdFailedToLoad: (LoadAdError error) {
            _numInterstitialLoadAttempts += 1;
            _interstitialAd = null;
            if (_numInterstitialLoadAttempts <= maxFailedLoadAttempts) {
              _createInterstitialAd();
            }
          },
        ));
  }
}
