import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<File> selectedImages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Image Picker")),
      body: Center(
        child: Column(
          children: [
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Choose Photo"),
                        actions: [
                          TextButton(
                              onPressed: () async {
                                Navigator.pop(context);
                                final ImagePicker picker = ImagePicker();
                                final images = await picker.pickMultiImage();
                                List<XFile> filePick = images;
                                setState(() {
                                  if (filePick.isNotEmpty) {
                                    for (var i = 0; i < filePick.length; i++) {
                                      selectedImages
                                          .add(File(filePick[i].path));
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text('Nothing is selected')));
                                  }
                                });
                              },
                              child: Text("Select Images")),
                        ],
                      ),
                    );
                  },
                  child: Text("Choose Photo")),
            ),
            Expanded(
              child: SizedBox(
                child: selectedImages.isEmpty
                    ? Text("Please Select Images.....")
                    : GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                        itemCount: selectedImages.length,
                        itemBuilder: (context, index) {
                          return Image.file(selectedImages[index]);
                        },
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
