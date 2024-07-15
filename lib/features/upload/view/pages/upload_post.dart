import 'package:client/core/theme/app_palette.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class UploadPost extends StatelessWidget {
  const UploadPost({super.key});

  @override
  Widget build(BuildContext context) {
    final contentPostContoller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Post'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Form(
              child: Column(
                children: [
                  DottedBorder(
                    color: Palette.borderColor,
                    radius: const Radius.circular(10),
                    borderType: BorderType.RRect,
                    strokeCap: StrokeCap.round,
                    dashPattern: const [15, 7],
                    child: const SizedBox(
                      height: 150,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.folder_open,
                            size: 40,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Select an image (optional)",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    controller: contentPostContoller,
                    decoration: const InputDecoration(
                      hintText: "What's on your mind...",
                      // border: OutlineInputBorder(),
                    ),
                    maxLines: 8,
                    validator: (val) {
                      if (val!.trim().isEmpty) {
                        return "Type something mate!";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
