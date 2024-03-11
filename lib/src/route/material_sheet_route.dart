import 'package:flutter/material.dart';
import 'package:tarp/route.dart';
import 'package:tarp/tarp.dart';

class MaterialSheetRoute<T> extends SheetRoute<T> {
  MaterialSheetRoute({
    required WidgetBuilder builder,
    Color? backgroundColor,
    double? elevation,
    ShapeBorder? shape,
    Clip? clipBehavior,
    Color barrierColor = Colors.black87,
    SheetFit fit = SheetFit.expand,
    Curve? animationCurve,
    bool barrierDismissible = true,
    bool enableDrag = true,
    List<double>? detents,
    double initialDetent = 1,
    Duration? duration,
    super.settings,
  }) : super(
          builder: (BuildContext context) => Material(
            color: backgroundColor,
            clipBehavior: clipBehavior ?? Clip.none,
            shape: shape,
            elevation: elevation ?? 1,
            child: Builder(
              builder: builder,
            ),
          ),
          detents: detents,
          initialExtent: initialDetent,
          fit: fit,
          barrierDismissible: barrierDismissible,
          barrierColor: barrierColor,
          draggable: enableDrag,
          animationCurve: animationCurve,
          duration: duration,
        );
}
