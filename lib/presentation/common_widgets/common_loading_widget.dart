import 'package:flu_warehouse_mobile/extensions/extension_mixin.dart';
import 'package:flu_warehouse_mobile/style/app_dimensions.dart';

import 'package:flutter/material.dart';

class CommonLoadingWidget extends StatelessWidget with ExtensionMixin {
  const CommonLoadingWidget({
    super.key,
    Color? color,
    double? height,
  })  : _height = height,
        _color = color;

  final Color? _color;
  final double? _height;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: _height ?? AppDimensions.xxxl,
        child: CircularProgressIndicator.adaptive(
          backgroundColor: _color ?? context.getColors().primaryYellow100,
        ),
      );
}
