import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../theme/theme_controller.dart';

class CustomSvgPicture extends StatelessWidget {
  CustomSvgPicture({
    super.key,
    required this.path,
    this.height,
    this.width,
    this.withColorFilter = true,
  });

  const CustomSvgPicture.withoutColor({
    super.key,
    required this.path,
    this.height,
    this.width,
  }) : withColorFilter = false;

  final String path;
  final double? height;
  final double? width;
  final bool withColorFilter;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      height: height,
      width: width,
      colorFilter: withColorFilter
          ? ColorFilter.mode(
              Theme.of(context).colorScheme.secondaryContainer,
              BlendMode.srcIn,
            )
          : null,
    );
  }
}
