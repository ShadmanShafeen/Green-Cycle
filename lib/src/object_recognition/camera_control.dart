import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:green_cycle/src/utils/snackbars_alerts.dart';
import 'package:green_cycle/src/widgets/nav_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_android/image_picker_android.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';

class CameraControl extends StatefulWidget {
  final List<CameraDescription> cameras;
  const CameraControl({super.key, required this.cameras});

  @override
  State<CameraControl> createState() => _CameraControlState();
}

class _CameraControlState extends State<CameraControl> {
  late CameraController controller;
  double _currentScale = 1.0;
  double _baseScale = 1.0;
  late XFile? imageFile;
  int currentCamera = 0;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    controller = CameraController(
      widget.cameras[currentCamera],
      ResolutionPreset.max,
    );
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((error) {
      if (error is CameraException) {
        _showErrorDialog(context, error.code);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: buildAppBar(context),
        bottomNavigationBar: const NavBar(),
        body: (!controller.value.isInitialized)
            ? Container(
                alignment: Alignment.center,
                color: Colors.white,
                child: const CircularProgressIndicator(),
              )
            : Container(
                color: Theme.of(context).colorScheme.surfaceContainerLowest,
                child: Column(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onScaleStart: (details) {
                          _baseScale = _currentScale;
                        },
                        onScaleUpdate: (details) async {
                          _currentScale =
                              (_baseScale * details.scale).clamp(1.0, 5.0);
                          await controller.setZoomLevel(_currentScale);
                        },
                        onTapUp: (details) async {
                          if (controller.value.isTakingPicture) {
                            return;
                          }
                          final RenderBox box =
                              context.findRenderObject() as RenderBox;
                          final Offset localPoint =
                              box.globalToLocal(details.globalPosition);
                          final Offset scaledPoint = Offset(
                            localPoint.dx / box.size.width,
                            localPoint.dy / box.size.height,
                          );
                          await controller.setFocusPoint(scaledPoint);
                        },
                        child: CameraPreview(controller),
                      ),
                    ),
                  ],
                ),
              ),
        floatingActionButton: buildFloatingButtonContainer(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
          imageFile = pickedFile;
        });

        if (context.mounted) {
          context.goNamed(
            "image-preview",
            pathParameters: {
              "imagePath": imageFile!.path,
            },
            extra: imageFile,
          );
        }
      }
    } catch (e) {
      // Handle errors or exceptions
      if (context.mounted) {
        _showErrorDialog(context, e.toString());
      }
    }
  }

  Container buildFloatingButtonContainer(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.18,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildFlashAndZoomButtons(context),
          const SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              returnIconButton(
                context,
                const Icon(
                  Icons.collections,
                ),
                'gallery',
              ),
              const SizedBox(width: 20),
              returnFloatingActionButton(context),
              const SizedBox(width: 20),
              returnIconButton(
                context,
                const Icon(
                  Icons.loop,
                ),
                'reverse',
              ),
            ],
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.surfaceDim,
      elevation: 0,
      leading: returnBackButton(context),
      actions: const [
        Icon(
          Icons.recycling,
          color: Colors.white,
        ),
        SizedBox(width: 20),
      ],
      title: const Text(
        "Scan an object",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      automaticallyImplyLeading: false,
    );
  }

  void _showErrorDialog(BuildContext context, String errorCode) {
    createQuickAlert(
      context: context,
      title: "Camera Error",
      message: errorCode,
      type: "error",
    );
  }

  BackButton returnBackButton(BuildContext context) {
    return BackButton(
      color: Colors.white,
      onPressed: () {
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        } else {
          context.go('/home');
        }
      },
    );
  }

  IconButton returnIconButton(BuildContext context, Widget icon, String type) {
    return IconButton(
      style: IconButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.onError,
        backgroundColor: Colors.white24,
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(15),
        elevation: 6,
      ),
      onPressed: () {
        if (type == 'reverse') {
          switchCamera(context);
        } else {
          openGallery(context);
        }
      },
      icon: icon,
      iconSize: 30,
    );
  }

  void switchCamera(BuildContext context) {
    return setState(() {
      currentCamera = (currentCamera + 1) % widget.cameras.length;
      controller =
          CameraController(widget.cameras[currentCamera], ResolutionPreset.max);
      controller.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      }).catchError((error) {
        if (error is CameraException) {
          _showErrorDialog(context, error.code);
        }
      });
    });
  }

  Widget returnFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      foregroundColor: Theme.of(context).colorScheme.onError,
      backgroundColor: Colors.white,
      onPressed: () async {
        try {
          final XFile file = await controller.takePicture();
          setState(() {
            imageFile = file;
          });

          if (context.mounted) {
            context.goNamed(
              "image-preview",
              pathParameters: {
                "imagePath": imageFile!.path,
              },
              extra: imageFile,
            );
          }
        } catch (e) {
          if (context.mounted) {
            _showErrorDialog(context, e.toString());
          }
        }
      },
      child: const Icon(Icons.camera_alt, size: 30, color: Colors.black),
    );
  }

  Row buildFlashAndZoomButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: const Icon(Icons.flash_off),
          onPressed: () {
            controller.setFlashMode(FlashMode.off);
          },
        ),
        IconButton(
          icon: const Icon(Icons.flash_on),
          onPressed: () {
            controller.setFlashMode(FlashMode.torch);
          },
        ),
        IconButton(
          icon: const Icon(Icons.zoom_in),
          onPressed: () {
            _currentScale = _currentScale + 0.1;
            controller.setZoomLevel(_currentScale);
          },
        ),
        IconButton(
          icon: const Icon(Icons.zoom_out),
          onPressed: () {
            _currentScale = _currentScale - 0.1;
            controller.setZoomLevel(_currentScale);
          },
        ),
      ],
    );
  }
}
