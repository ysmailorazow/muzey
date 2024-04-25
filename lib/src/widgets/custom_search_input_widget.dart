import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../features/camera/presentation/camera_screen.dart';
import '../theme/constants/app_colors.dart';
import '../theme/constants/app_dimensions.dart';
import '../utils/constants/app_assets.dart';
import 'image_picker_bottom_sheet.dart';

class CustomSearchInputWidget extends StatelessWidget {
  const CustomSearchInputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: const BorderRadius.all(
          Radius.circular(AppDimensions.borderRadiusMedium),
        ),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 7,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () => onLangChangePressed(context),
            child: Container(
              width: 250,
              height: 50,
              decoration: const BoxDecoration(
                color: AppColors.green,
                borderRadius: BorderRadius.all(
                  Radius.circular(AppDimensions.borderRadiusMedium),
                ),
              ),
              padding: const EdgeInsets.all(8),
              child: SvgPicture.asset(
                AppAssets.shareIcon,
              ),
            ),
          )
        ],),
    );
  }

  Future<void> onLangChangePressed(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const ImagePickerBottomSheet(),
    );
  }
}
