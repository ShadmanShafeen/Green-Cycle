import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:green_cycle/auth.dart';
import 'package:green_cycle/src/notification/notification_service.dart';
import 'package:green_cycle/src/utils/responsive_functions.dart';
import 'package:green_cycle/src/utils/server.dart';
import 'package:green_cycle/src/utils/snackbars_alerts.dart';
import 'package:green_cycle/src/widgets/app_bar.dart';
import 'package:green_cycle/src/widgets/nav_bar.dart';

class ImagePreview extends StatefulWidget {
  final String imagePath;
  final XFile imageFile;
  const ImagePreview(
      {super.key, required this.imagePath, required this.imageFile});

  @override
  State<ImagePreview> createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  bool isLoading = true;
  bool isAdding = false;
  String? processedImageBase64;
  final labels = [];
  late final String category;
  late final double accuracy;

  @override
  void initState() {
    super.initState();
    _getDetectedImage().then((base64String) {
      setState(() {
        isLoading = false;
        processedImageBase64 = base64String;
      });
    });
  }

  Future<dynamic> _getDetectedImage() async {
    final dio = Dio();
    try {
      File file = File(widget.imagePath);
      FormData formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(file.path, filename: "image.jpg"),
      });
      final response = await dio.post(
        "$serverURLFlask/object-rec",
        data: formData,
      );

      if (response.statusCode == 200) {
        final tempCat = response.data['name'];
        category = tempCat[0].toUpperCase() + tempCat.substring(1);
        accuracy = response.data['accuracy'] * 100;
        return response.data['processed_image'];
      } else {
        throw createQuickAlert(
          context: context.mounted ? context : context,
          title: "${response.statusCode}",
          message: response.statusMessage!,
          type: 'error',
        );
      }
    } catch (e) {
      throw createQuickAlert(
        context: context.mounted ? context : context,
        title: "Error",
        message: e.toString(),
        type: 'error',
      );
    }
  }

  Uint8List _base64ToUint8List(String base64String) {
    return base64Decode(base64String);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      bottomNavigationBar: const NavBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerLowest,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildImageViewer(context),
              const SizedBox(height: 10),
              buildIsRecyclableRow(context),
              const SizedBox(height: 10),
              buildDetailsContainer(context),
              const SizedBox(height: 10),
              buildAddToListButton(context),
              const SizedBox(height: 5),
              buildRecycleDetailsPanel(context),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox buildImageViewer(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: isLoading
          ? SizedBox(
              height: MediaQuery.of(context).size.height,
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            )
          : processedImageBase64 != null
              ? Image.memory(
                  _base64ToUint8List(processedImageBase64!),
                )
              : Image.asset(
                  "lib/assets/images/error.png",
                ),
    );
  }

  Widget buildIsRecyclableRow(BuildContext context) {
    return isLoading
        ? const SizedBox(
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.check_circle,
                color: Theme.of(context).colorScheme.secondaryFixedDim,
              ),
              const SizedBox(width: 10),
              Text(
                "Recyclable Item",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 20,
                ),
              ),
            ],
          );
  }

  Widget buildDetailsContainer(BuildContext context) {
    return isLoading
        ? const SizedBox(
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          )
        : Container(
            padding: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    category,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Category\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020: $category",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Accuracy\u0020\u0020\u0020\u0020\u0020\u0020\u0020\u0020: ${accuracy.toStringAsFixed(2)}%",
                      style: TextStyle(
                        color: accuracy > 70
                            ? Theme.of(context).colorScheme.secondaryFixedDim
                            : Theme.of(context).colorScheme.tertiary,
                        fontSize: 16,
                      ),
                    ),
                    // retake photo icon-button
                    IconButton(
                      onPressed: () {
                        context.go('/home/camera-control');
                      },
                      icon: Icon(
                        Icons.replay,
                        color: Theme.of(context).colorScheme.secondaryFixedDim,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
  }

  SizedBox buildAddToListButton(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: () async {
          await addToDraftList(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primaryFixed,
          overlayColor: Theme.of(context).colorScheme.tertiary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            isAdding ? "Adding to list ..." : "Add to List",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  ExpansionTile buildRecycleDetailsPanel(BuildContext context) {
    return ExpansionTile(
      title: Text(
        "Recycle Details",
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontSize: 20,
        ),
      ),
      children: [
        isLoading
            ? SizedBox(
                height: MediaQuery.of(context).size.height,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              )
            : ListTile(
                title: Text(
                  "This is details about the recyclable item and how it can be recycled. "
                  "This is details about the recyclable item and how it can be recycled. "
                  "This is details about the recyclable item and how it can be recycled. "
                  "This is details about the recyclable item and how it can be recycled.",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 16,
                  ),
                ),
              ),
      ],
    );
  }

  Future<void> addToDraftList(BuildContext context) async {
    final item = {
      "name": category,
      "description": "This is a $category",
      "Amount": "1",
      'createdAt': getFormattedCurrentDate(),
      'confirmedAt': 'Not Confirmed',
    };

    try {
      final dio = Dio();
      final Auth auth = Auth();
      User? user = auth.currentUser;
      setState(() {
        isAdding = true;
      });

      final response = await dio.post(
        "$serverURLExpress/draft-insert/${user!.email}",
        data: item,
      );

      if (response.statusCode != 200) {
        throw createQuickAlert(
          context: context.mounted ? context : context,
          title: "${response.statusCode}",
          message: "${response.statusMessage}",
          type: "error",
        );
      }

      setState(() {
        isAdding = false;
      });

      String? token = await auth.firebaseMessaging.getToken();
      await NotificationService().sendNotification(
        "New item added to draft",
        "Item name: $category\nAmount: 1",
        token!,
        context.mounted ? context : context,
      );
    } catch (e) {
      throw createQuickAlert(
        context: context.mounted ? context : context,
        title: "Error",
        message: e.toString(),
        type: "error",
      );
    }
  }
}
