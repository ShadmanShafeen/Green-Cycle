import "dart:convert";
import "dart:io";

import "package:dio/dio.dart";
import "package:dotted_border/dotted_border.dart";
import "package:flutter/material.dart";
import "package:green_cycle/src/models/community.dart";
import "package:green_cycle/src/utils/responsive_functions.dart";
import "package:green_cycle/src/utils/server.dart";
import "package:green_cycle/src/utils/snackbars_alerts.dart";
import "package:image_picker/image_picker.dart";
import "package:image_picker_android/image_picker_android.dart";
import "package:image_picker_platform_interface/image_picker_platform_interface.dart";
import "package:location/location.dart";

class AddNewCommunity extends StatefulWidget {
  final List<Community> communities;
  final LocationData communityLocation;
  final VoidCallback onNewItemAdded;
  const AddNewCommunity(
      {super.key,
      required this.onNewItemAdded,
      required this.communities,
      required this.communityLocation});

  @override
  State<AddNewCommunity> createState() => _AddNewCommunityState();
}

class _AddNewCommunityState extends State<AddNewCommunity> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late XFile? communityImage = null;
  final ImagePicker _picker = ImagePicker();
  final _communityNameController = TextEditingController();
  bool isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);

    return AnimatedContainer(
      padding: EdgeInsets.only(
          top: 30,
          right: 25,
          left: 25,
          bottom: mediaQuery.viewInsets.bottom + 25),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      duration: const Duration(milliseconds: 500),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Create New Community",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            "Your current location will be picked as the community location. You can change it later.",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              fontSize: dynamicFontSize(context, 12),
            ),
          ),
          const SizedBox(height: 20),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                getAddItemFormField(
                  context,
                  _communityNameController,
                  "Community Name",
                  (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the community name';
                    }
                    return null;
                  },
                  TextInputType.text,
                  1,
                ),
                const SizedBox(height: 20),
                getImagePickerField(context),
                const SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () async {
                    await uploadImage(context);
                  },
                  child: Text(
                    isSubmitting ? "Creating..." : "Create Community",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> uploadImage(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final dio = Dio();
      try {
        setState(() {
          isSubmitting = true;
        });
        File file = File(communityImage!.path);
        String base64Image = base64Encode(file.readAsBytesSync());
        String filename = "image.jpg";

        final response = await dio.post(
          "$serverURLExpress/uploadComImage",
          data: {
            "image": base64Image,
            "name": filename,
          },
        );

        if (response.statusCode == 200) {
          final String communityImageURL = response.data["imageUrl"];

          final response2 =
              await dio.post("$serverURLExpress/add_community", data: {
            "image": communityImageURL,
            "name": _communityNameController.text,
            "location": [
              {
                "latitude": widget.communityLocation.latitude.toString(),
                "longitude": widget.communityLocation.longitude.toString(),
              }
            ],
            "leaderEmail": "shadmanskystar@gmail.com",
          });

          if (response2.statusCode == 201) {
            setState(() {
              isSubmitting = false;
            });
            await createQuickAlert(
              context: context.mounted ? context : context,
              title: "Success",
              message: "Community created successfully",
              type: 'success',
            );
          }
        } else {
          throw createQuickAlert(
            context: context.mounted ? context : context,
            title: "${response.statusCode}",
            message: "${response.statusMessage}",
            type: "error",
          );
        }

        widget.onNewItemAdded();
        if (context.mounted) {
          Navigator.pop(context);
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
  }

  TextFormField getAddItemFormField(
      BuildContext context,
      TextEditingController fieldController,
      String labelText,
      String? Function(String?)? validator,
      TextInputType textType,
      int maxLines) {
    return TextFormField(
      keyboardType: textType,
      controller: fieldController,
      textCapitalization: TextCapitalization.sentences,
      textInputAction: TextInputAction.next,
      maxLines: maxLines,
      style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
      cursorColor: Theme.of(context).colorScheme.secondary,
      decoration: InputDecoration(
        focusColor: Theme.of(context).colorScheme.secondary,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        contentPadding: const EdgeInsets.only(left: 10),
        label: Text(
          labelText,
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        ),
      ),
      validator: validator,
    );
  }

  DottedBorder getImagePickerField(BuildContext context) {
    return DottedBorder(
      color: Theme.of(context).colorScheme.onSurface,
      strokeWidth: 1,
      radius: const Radius.circular(10),
      child: GestureDetector(
        onTap: () {
          openGallery(context);
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.image,
                  color: Colors.grey,
                ),
                const SizedBox(width: 10),
                Text(
                  communityImage != null
                      ? communityImage!.name
                      : "Add Community Image",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: dynamicFontSize(context, 12),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> openGallery(BuildContext context) async {
    try {
      final ImagePickerPlatform imagePickerImplementation =
          ImagePickerPlatform.instance;
      if (imagePickerImplementation is ImagePickerAndroid) {
        imagePickerImplementation.useAndroidPhotoPicker = true;
      }
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        // Use the picked file
        setState(() {
          communityImage = pickedFile;
        });
      }
    } catch (e) {
      // Handle errors or exceptions
      if (context.mounted) {
        await createQuickAlert(
          context: context,
          title: "Error",
          message: e.toString(),
          type: "error",
        );
      }
    }
  }
}
