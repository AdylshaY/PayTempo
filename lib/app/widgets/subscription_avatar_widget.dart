import 'package:flutter/material.dart';
import 'package:pay_tempo/app/theme/app_theme.dart';
import 'package:pay_tempo/data/local/models/subscription_record.dart';

class SubscriptionAvatarWidget extends StatelessWidget {
  const SubscriptionAvatarWidget({
    required this.item,
    required this.size,
    this.borderRadius,
    this.shape = BoxShape.rectangle,
    this.border,
    super.key,
  });

  final SubscriptionRecord item;
  final double size;
  final double? borderRadius;
  final BoxShape shape;
  final BoxBorder? border;

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = item.avatarColorValue != null
        ? Color(item.avatarColorValue!)
        : AppColors.primary;

    final double effectiveRadius = borderRadius ?? AppRadii.button;

    Widget childWidget;
    if (item.avatarType == 'emoji' &&
        item.avatarEmoji != null &&
        item.avatarEmoji!.isNotEmpty) {
      childWidget = Text(
        item.avatarEmoji!,
        style: TextStyle(fontSize: size * 0.5),
      );
    } else if (item.avatarIconCodePoint != null) {
      childWidget = Icon(
        IconData(
          item.avatarIconCodePoint!,
          fontFamily: item.avatarIconFontFamily,
          fontPackage: item.avatarIconFontPackage,
        ),
        color: Colors.white,
        size: size * 0.5,
      );
    } else {
      childWidget = Icon(
        Icons.subscriptions_outlined,
        color: Colors.white,
        size: size * 0.5,
      );
    }

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: shape,
        borderRadius: shape == BoxShape.circle
            ? null
            : BorderRadius.circular(effectiveRadius),
        border: border,
      ),
      alignment: Alignment.center,
      child: childWidget,
    );
  }
}
