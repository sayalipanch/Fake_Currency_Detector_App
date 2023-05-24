// ignore_for_file: unused_local_variable, unused_field
import 'dart:io';
import 'package:edge_detection/edge_detection.dart';
import 'package:fake_currency_detector/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class Scan extends StatefulWidget {
  const Scan({super.key});

  @override
  State<Scan> createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  String? _imagePath;

  void detectObject({bool isCamera = true}) async {
    bool isCameraGranted = await Permission.camera.request().isGranted;
    bool success = false;
    if (!isCameraGranted) {
      isCameraGranted =
          await Permission.camera.request() == PermissionStatus.granted;
    }
    if (!isCameraGranted) {
      return;
    }
    _imagePath = join((await getApplicationSupportDirectory()).path,
        "${(DateTime.now().millisecondsSinceEpoch / 1000).round()}.jpeg");

    if (isCamera) {
      success = await EdgeDetection.detectEdge(
        _imagePath!,
        canUseGallery: false,
        androidScanTitle:
            'Scan Currency', // use custom localizations for android
        androidCropTitle: 'Crop Currency',
        androidCropBlackWhiteTitle: 'Black White',
        androidCropReset: 'Reset',
      );
    }
    setState(() {});
  }

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
                    size: width / 18,
                    weight: FontWeight.w500,
                    isShadow: true,
                    color: AppTheme.whiteColor),
              ),
              Column(
                children: [
                  SizedBox(
                    width: width / 1.5,
                    child: ElevatedButton(
                        onPressed: () async {
                          var imageFile = await ImagePicker()
                              .pickImage(source: ImageSource.camera);
                          if (imageFile != null) {
                            File file = File(imageFile.path);
                          }
                        },
                        style: AppTheme.buttonStyle(
                            backColor: AppTheme.whiteColor),
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
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: width / 1.5,
                    child: ElevatedButton(
                        onPressed: () async {
                          var imageFile = await ImagePicker()
                              .pickImage(source: ImageSource.gallery);
                          if (imageFile != null) {
                            File file = File(imageFile.path);
                          }
                        },
                        style: AppTheme.buttonStyle(
                            backColor: AppTheme.whiteColor),
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
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: width / 1.5,
                    child: ElevatedButton(
                        onPressed: () async {
                          detectObject();
                        },
                        style: AppTheme.buttonStyle(
                            backColor: AppTheme.whiteColor),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          child: Text(
                            "Scan using Edge Detection",
                            style: AppTheme.appText(
                                size: width / 25,
                                weight: FontWeight.w600,
                                color: AppTheme.mildGreen),
                          ),
                        )),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
