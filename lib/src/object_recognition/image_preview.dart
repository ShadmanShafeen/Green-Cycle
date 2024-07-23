import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle/src/utils/server.dart';
import 'package:green_cycle/src/utils/snackbars_alerts.dart';
import 'package:green_cycle/src/widgets/app_bar.dart';

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
  String? processedImageBase64;
  final labels = [];

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
      ;
    }
  }

  Uint8List _base64ToUint8List(String base64String) {
    return base64Decode(base64String);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: isLoading
            ? SizedBox(
                height: MediaQuery.of(context).size.height,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              )
            : Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceDim,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 300,
                      child: processedImageBase64 != null
                          ? Image.memory(
                              _base64ToUint8List(processedImageBase64!),
                            )
                          : Image.file(
                              File(widget.imagePath),
                            ),
                    ),
                    const SizedBox(height: 20),
                    Card(
                      color: Theme.of(context).colorScheme.surfaceContainerHigh,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Recyclable Waste",
                                  style: TextStyle(
                                    fontSize: 30,
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Icon(
                                  Icons.recycling,
                                  size: 30,
                                  color: Theme.of(context).colorScheme.error,
                                ),
                              ],
                            ),
                            Text(
                              "Not organic waste",
                              style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context).colorScheme.error,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Aluminium can",
                              style: TextStyle(
                                fontSize: 15,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Recycling Details",
                      style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Card(
                      color: Theme.of(context).colorScheme.surfaceContainerHigh,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Aluminium cans are 100% recyclable and can be recycled indefinitely "
                          "without a loss in quality. Recycling aluminium saves 95% of the energy "
                          "needed to make new aluminium from raw materials. Making cans from recycled "
                          "aluminium reduces air pollution by 95% and water pollution by 97%."
                          "Recycling aluminium cans saves 95% of the energy used to make aluminium cans "
                          "from raw materials. Making new aluminium cans from used cans takes 95% less energy."
                          "Recycling 1 tonne of aluminium saves 9 tonnes of CO2 emissions. Recycling aluminium ",
                          style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
