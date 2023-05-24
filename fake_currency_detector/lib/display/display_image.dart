// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:fake_currency_detector/utils/app_theme.dart';
import 'package:flutter/material.dart';

class DisplayImage extends StatefulWidget {
  DisplayImage({super.key, required this.file});
  File file;
  @override
  State<DisplayImage> createState() => _DisplayImageState();
}

class _DisplayImageState extends State<DisplayImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.whiteColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Card(
                elevation: 4.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Image.file(File(widget.file.path)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
