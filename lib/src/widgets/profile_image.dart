import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/constants/app_assets.dart';

class ProfileImageWidget extends StatelessWidget {
  const ProfileImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){},
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: CircleAvatar(
          radius: 20,
          backgroundImage: AssetImage(AppAssets.photo),
        ),
      ),
    );
  }
}
