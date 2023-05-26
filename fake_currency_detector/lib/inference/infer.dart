// ignore_for_file: unused_field, prefer_final_fields, must_be_immutable, prefer_const_constructors, avoid_print
import 'dart:io';
import 'package:fake_currency_detector/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';

class Infer extends StatefulWidget {
  Infer({super.key, required this.imagePath});
  String imagePath;

  @override
  State<Infer> createState() => _InferState();
}

class _InferState extends State<Infer> {
  bool _loading = false;
  List<dynamic> _outputs = [];

  @override
  void initState() {
    _loading = true;
    loadModel().then((value) {
      classifyImage(imagePath: widget.imagePath).then(
        (value) {
          setState(() {
            _loading = false;
          });
        },
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    releaseModel();
    super.dispose();
  }

  Future<void> classifyImage({required String imagePath}) async {
    var output = await Tflite.runModelOnImage(
        path: imagePath,
        imageMean: 0.0,
        imageStd: 255.0,
        numResults: 2,
        threshold: 0.2,
        asynch: true);
    setState(() {
      _loading = false;
      _outputs = output ?? [];
    });
  }

  Future<dynamic> loadModel() async {
    await Tflite.loadModel(
      model: "assets/model/model_unquant.tflite",
      labels: "assets/label/labels.txt",
    );
  }

  releaseModel() async {
    await Tflite.close();
  }

  @override
  Widget build(BuildContext context) {
    return buildWidget(context);
  }

  Widget buildWidget(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Builder(builder: (context) {
      if (_loading) {
        return Scaffold(
          backgroundColor: AppTheme.backGroundColor,
          body: Center(
            child: SizedBox(
              width: width / 12,
              height: width / 12,
              child: CircularProgressIndicator(
                color: AppTheme.mildGreen,
              ),
            ),
          ),
        );
      } else {
        return Scaffold(
          backgroundColor: AppTheme.backGroundColor,
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "Classification",
              style: AppTheme.appText(
                  size: width / 15,
                  weight: FontWeight.w900,
                  color: AppTheme.textColor),
            ),
            foregroundColor: Colors.black,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: width / 6,
                ),
                SizedBox(
                  height: width,
                  width: width,
                  child: Card(
                      clipBehavior: Clip.antiAlias,
                      elevation: 10,
                      margin: EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Image.file(
                        File(widget.imagePath),
                        fit: BoxFit.cover,
                      )),
                ),
                SizedBox(
                  height: width / 6,
                ),
                if (_outputs.isNotEmpty)
                  RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                          text: "The Input Image is ",
                          style: AppTheme.appText(
                              size: width / 20,
                              weight: FontWeight.w600,
                              color: AppTheme.textColor),
                        ),
                        TextSpan(
                          text: _outputs[0]["label"].toString().split(" ")[1],
                          style: AppTheme.appText(
                              size: width / 20,
                              weight: FontWeight.w900,
                              color: Colors.redAccent),
                        ),
                        TextSpan(
                          text: "\nConfidence: ",
                          style: AppTheme.appText(
                              size: width / 20,
                              weight: FontWeight.w600,
                              color: AppTheme.textColor),
                        ),
                        TextSpan(
                          text: _outputs[0]["confidence"].toStringAsFixed(3),
                          style: AppTheme.appText(
                              size: width / 20,
                              weight: FontWeight.w900,
                              color: AppTheme.mildGreen),
                        ),
                      ]))
              ],
            ),
          ),
        );
      }
    });
  }
}
