import 'package:flutter/material.dart';
import 'package:jtbroulette/generated/locale_keys.g.dart';
import 'package:jtbroulette/page_list.dart';
import 'package:jtbroulette/utils.dart';
import 'package:easy_localization/easy_localization.dart';

class PageHome extends StatefulWidget {
  const PageHome({Key? key}) : super(key: key);

  @override
  _PageHomeState createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  TextEditingController textController = TextEditingController();
  int number = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      bottomSheet: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => PageList(
                      quantity: number,
                    )),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.red[500],
            ),
            height: 50,
            width: double.infinity,
            child: Center(
              child: Text(LocaleKeys.select.tr(),
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(LocaleKeys.select.tr()),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [HexColor('#FFFFFF'), HexColor('#93EBEB')],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                tileMode: TileMode.clamp)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(LocaleKeys.select_page_title.tr(),
                style: TextStyle(fontSize: 30)),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    // color: Colors.red,
                  ),
                  child: IconButton(
                    color: Colors.red,
                    onPressed: () {
                      setState(() {
                        if (number <= 2) {
                          return;
                        }
                        number -= 1;
                      });
                    },
                    icon: Icon(Icons.exposure_minus_1),
                  ),
                ),
                SizedBox(width: 10),
                Text('$number', style: TextStyle(fontSize: 80)),
                SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    // color: Colors.blue,
                  ),
                  child: IconButton(
                    color: Colors.blue,
                    onPressed: () {
                      setState(() {
                        if (number >= 10) {
                          return;
                        }
                        number += 1;
                      });
                    },
                    icon: Icon(Icons.plus_one),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
