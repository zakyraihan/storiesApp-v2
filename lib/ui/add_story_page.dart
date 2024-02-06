import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:story_app_api/controller/camera_controller.dart';

class AddStoryPage extends StatefulWidget {
  const AddStoryPage({super.key});

  @override
  State<AddStoryPage> createState() => _AddStoryPageState();
}

class _AddStoryPageState extends State<AddStoryPage> {
  void _galleryView() async {
    final provider = context.read<CameraProvider>();
    final ImagePicker picker = ImagePicker();

    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      /// todo-gallery-05: update the state, imagePath and imageFile
      provider.setImageFile(pickedFile);
      provider.setImagePath(pickedFile.path);
    }
  }

  Widget _showImage() {
    final imagePath = context.read<CameraProvider>().imagePath;
    if (imagePath != null && File(imagePath).existsSync()) {
      return AspectRatio(
        aspectRatio: 1.7 / 2,
        child: Image.file(
          File(imagePath),
          fit: BoxFit.contain,
        ),
      );
    } else {
      return const Text('No Image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          context.watch<CameraProvider>().imagePath == null
              ? const Align(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.image_not_supported,
                    size: 100,
                  ),
                )
              : _showImage(),
          ElevatedButton(
              onPressed: () => _galleryView(), child: const Text('add'))
        ],
      ),
    ));
  }
}
