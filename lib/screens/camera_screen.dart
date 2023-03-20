import 'dart:io';
import 'package:flutter/material.dart';
import 'package:whp/Common/common_functions.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  File? image;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton.icon(
              onPressed: () => openCamera(),
              icon: const Icon(Icons.camera_alt),
              label: const Text('Open Cmera'))
        ],
      ),
    );
  }
}
