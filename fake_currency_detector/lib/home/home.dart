import 'package:fake_currency_detector/utils/app_theme.dart';
import 'package:flutter/material.dart';

import '../scan/scan.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppTheme.backGroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              width: width / 5,
              height: 70,
              child: ElevatedButton(
                onPressed: () {},
                style: AppTheme.buttonStyle(
                    backColor: AppTheme.lightRedColor, radius: 20),
                child: Text(
                  "Report",
                  style: AppTheme.appText(
                      size: width / 30,
                      isShadow: true,
                      weight: FontWeight.w900,
                      color: Colors.red),
                ),
              ),
            ),
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.currency_rupee_sharp,
                        size: width / 6,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Fake Currency Detector",
                    textAlign: TextAlign.center,
                    style: AppTheme.appText(
                        size: width / 11,
                        weight: FontWeight.w800,
                        color: AppTheme.textColor),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      "Scan a note using your phone's camera to assist in locating security features.",
                      textAlign: TextAlign.center,
                      style: AppTheme.appText(
                          size: width / 23,
                          weight: FontWeight.w500,
                          color: AppTheme.textColor),
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                  onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (_){return Scan();}));},
                  style: AppTheme.buttonStyle(backColor: AppTheme.mildGreen),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 10),
                    child: Text(
                      "Launch Fake Currency Detector",
                      style: AppTheme.appText(
                          size: width / 25, weight: FontWeight.w600),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
