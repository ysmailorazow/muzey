import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../features/camera/presentation/camera_screen.dart';
import '../theme/constants/app_colors.dart';
import '../theme/constants/app_dimensions.dart';
import '../utils/constants/app_assets.dart';

class ImagePickerBottomSheet extends StatelessWidget {
  const ImagePickerBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170.0,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppDimensions.borderRadiusLarge),
          topRight: Radius.circular(AppDimensions.borderRadiusLarge),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: AppDimensions.paddingMedium,
                horizontal: AppDimensions.paddingExtraLarge),
            child: Row(
              children: [
                Container(
                    width: 4,
                    height: 20,
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: AppColors.green,
                      borderRadius: BorderRadius.circular(15),
                    )),
                Text(
                  r'choose_image_source'.tr,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              r'pick_clear_image'.tr,
              style: const TextStyle(
                fontSize: 12
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // InkWell(
                  //   onTap: () => pickImage(ImageSource.gallery),
                  //   child: Column(
                  //     children: [
                  //       SvgPicture.asset(
                  //         AppAssets.shareIcon,
                  //         height: 25,
                  //         color: Theme.of(context).colorScheme.outline,
                  //       ),
                  //       const SizedBox(height: 8),
                  //       Text(
                  //         r'gallery'.tr,
                  //         style: Theme.of(context)
                  //             .textTheme
                  //             .titleMedium
                  //             ?.copyWith(fontWeight: FontWeight.bold),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  InkWell(
                    onTap: () => pickImage(ImageSource.camera),
                    child: Column(
                      children: [
                        SvgPicture.asset(AppAssets.shareIcon,
                            height: 25,
                            color: Theme.of(context).colorScheme.outline),
                        const SizedBox(height: 8),
                        Text(
                          r'camera'.tr,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: AppDimensions.paddingExtraLarge,
          ),
        ],
      ),
    );
  }

  pickImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      // final image = await ImagePicker().pickImage(source: imageSource, maxHeight: 2600, maxWidth: 2000);
      if (image == null) return;
      // await Gal.putImage(image.path);
      // debugPrint(image.path);
      Get.toNamed(CameraScreen.route,
          arguments: {'search_image': File(image.path)});
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }
}
