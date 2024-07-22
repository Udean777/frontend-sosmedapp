// ignore_for_file: avoid_print

import 'dart:io';

import 'package:client/core/theme/app_palette.dart';
import 'package:client/core/utils.dart';
import 'package:client/core/widgets/loading.dart';
import 'package:client/features/upload/viewmodel/upload_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UploadPost extends ConsumerStatefulWidget {
  const UploadPost({super.key});

  @override
  ConsumerState<UploadPost> createState() => _UploadPostState();
}

class _UploadPostState extends ConsumerState<UploadPost> {
  final captionController = TextEditingController();
  File? selectedImage;
  final formKey = GlobalKey<FormState>();

  void selectImage() async {
    try {
      final pickedImage = await pickImage();

      if (pickedImage != null) {
        setState(() {
          selectedImage = pickedImage;
        });
      }
    } catch (e) {
      print('Error selecting image: $e');
    }
  }

  @override
  void dispose() {
    captionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref
        .watch(uploadViewmodelProvider.select((val) => val?.isLoading == true));

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              "Drafts",
              style: TextStyle(
                color: Palette.gradient2,
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          ElevatedButton(
            onPressed: () async {
              if (formKey.currentState!.validate() && selectedImage != null) {
                await ref.read(uploadViewmodelProvider.notifier).uploadPost(
                      context: context,
                      selectedImage: selectedImage!,
                      caption: captionController.text,
                    );
              } else {
                showSnackbar(context, "Please fill all the fields");
              }
            },
            style: ButtonStyle(
              backgroundColor:
                  WidgetStateProperty.all<Color>(Palette.gradient2),
            ),
            child: const Text(
              "Post",
              style: TextStyle(
                color: Palette.whiteColor,
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
        ],
      ),
      body: isLoading
          ? const Loading()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Center(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Icon(
                              CupertinoIcons.person_alt_circle,
                              size: 50,
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: captionController,
                                decoration: const InputDecoration(
                                  hintText: "What's on your mind...",
                                  border: InputBorder.none,
                                ),
                                validator: (val) {
                                  if (val!.trim().isEmpty) {
                                    return "Type something mate!";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        selectedImage != null
                            ? SizedBox(
                                height: 300,
                                width: double.infinity,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(
                                    selectedImage!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: selectImage,
                              child: const Icon(CupertinoIcons.photo),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(CupertinoIcons.videocam),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.gif_box_outlined),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(CupertinoIcons.list_bullet),
                            ),
                          ],
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
