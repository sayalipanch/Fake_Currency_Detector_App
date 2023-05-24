import 'dart:io';

import 'package:fake_currency_detector/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Scan extends StatefulWidget {
  const Scan({super.key});

  @override
  State<Scan> createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppTheme.mildGreen,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Place your currency note on a flat surface and scan it or upload image from your gallery.",
                textAlign: TextAlign.center,
                style: AppTheme.appText(
                    size: width / 20,
                    weight: FontWeight.w500,
                    color: AppTheme.whiteColor),
              ),
              Column(
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        var imageFile = await ImagePicker()
                            .pickImage(source: ImageSource.camera);
                        if (imageFile != null) {
                          File file = File(imageFile.path);
                          setState(() {
                            Navigator.pop(context);
                          });
                        }
                      },
                      style:
                          AppTheme.buttonStyle(backColor: AppTheme.whiteColor),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 10),
                        child: Text(
                          "Take image from Camera",
                          style: AppTheme.appText(
                              size: width / 25,
                              weight: FontWeight.w600,
                              color: AppTheme.mildGreen),
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "OR",
                      textAlign: TextAlign.center,
                      style: AppTheme.appText(
                          size: width / 22,
                          weight: FontWeight.w500,
                          color: AppTheme.whiteColor),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        var imageFile = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        if (imageFile != null) {
                          File file = File(imageFile.path);
                          setState(() {
                            Navigator.pop(context);
                          });
                        }
                      },
                      style:
                          AppTheme.buttonStyle(backColor: AppTheme.whiteColor),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 10),
                        child: Text(
                          "Upload image from Gallery",
                          style: AppTheme.appText(
                              size: width / 25,
                              weight: FontWeight.w600,
                              color: AppTheme.mildGreen),
                        ),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
