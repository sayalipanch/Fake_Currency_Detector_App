import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart' as tfl;

class Infer extends StatefulWidget {
  const Infer({super.key});

  @override
  State<Infer> createState() => _InferState();
}

class _InferState extends State<Infer> {
  late tfl.Interpreter interpreter;

  loadModel() async {
    interpreter = await tfl.Interpreter.fromAsset(
        'assets/model/model_unquant.tflite',
        options: tfl.InterpreterOptions());
  }

  releaseModel() async {
    interpreter.close();
  }

  @override
  void dispose() {
    releaseModel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
