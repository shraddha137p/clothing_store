import 'package:clothing_store/utilities/common/extensions.dart';
import 'package:clothing_store/utilities/common/widget_extensions.dart';
import 'package:clothing_store/utilities/common/widgets/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../gen/assets.gen.dart';

enum ButtonType { primary, secondary, outline, disable, whiteButton }

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    this.onTap,
    this.textSize,
    this.type = ButtonType.primary,
    this.bgColor,
    this.txtClr,
    this.btnVerticalPadding,
    this.btnHorizontalPadding,
    this.btnCornerRadius,
    this.iconColor,
    this.iconMarginRight,
    this.svg,
  });

  final VoidCallback? onTap;
  final double? textSize;
  final double? btnVerticalPadding;
  final double? btnHorizontalPadding;
  final double? btnCornerRadius;
  final ButtonType type;
  final SvgPicture? svg;
  final String label;
  final Color? bgColor, txtClr;
  final Color? iconColor;
  final double? iconMarginRight;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = context.colorScheme;
    Color textColor = txtClr ?? colorScheme.onPrimary;

    // Style for primary button
    final ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
      foregroundColor: context.colorScheme.primary,
      disabledBackgroundColor: context.colorScheme.primary,
      padding: EdgeInsets.symmetric(
        vertical: btnVerticalPadding ?? 16.h,
        horizontal: btnHorizontalPadding ?? 16.w,
      ),
      backgroundColor: bgColor ?? colorScheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(btnCornerRadius ?? 100.r),
      ),
    );

    final ButtonStyle whiteButtonStyle = ElevatedButton.styleFrom(
      foregroundColor: context.colorScheme.onSecondary,
      disabledBackgroundColor: context.colorScheme.onSecondary,
      surfaceTintColor: context.colorScheme.primary,
      iconColor: context.colorScheme.primary,
      padding: EdgeInsets.symmetric(
        vertical: btnVerticalPadding ?? 16.h,
        horizontal: btnHorizontalPadding ?? 16.w,
      ),
      backgroundColor: context.colorScheme.onSecondary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(btnCornerRadius ?? 100.r),
      ),
    );

    final ButtonStyle secondaryButtonStyle = ElevatedButton.styleFrom(
      padding: EdgeInsets.symmetric(
        vertical: btnVerticalPadding ?? 16.h,
        horizontal: btnHorizontalPadding ?? 16.w,
      ),
      backgroundColor: bgColor ?? colorScheme.error,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(btnCornerRadius ?? 100.r),
      ),
    );

    // Style for outline button
    final ButtonStyle outlineButtonStyle = ElevatedButton.styleFrom(
      foregroundColor: context.colorScheme.onSecondary,
      disabledBackgroundColor: context.colorScheme.onSecondary,
      surfaceTintColor: context.colorScheme.error,
      iconColor: context.colorScheme.error,
      padding: EdgeInsets.symmetric(
        vertical: btnVerticalPadding ?? 16.h,
        horizontal: btnHorizontalPadding ?? 16.w,
      ),
      backgroundColor: colorScheme.onSecondary,
      side: BorderSide(
        color: bgColor ?? colorScheme.error,
        width: 1,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(btnCornerRadius ?? 100.r),
      ),
    );

    // Style for disabled button
    final ButtonStyle disableButtonStyle = ElevatedButton.styleFrom(
      padding: EdgeInsets.symmetric(
        vertical: btnVerticalPadding ?? 16.h,
        horizontal: btnHorizontalPadding ?? 16.w,
      ),
      // backgroundColor: Colors.red,
      backgroundColor: bgColor ??
          colorScheme.secondaryContainer.withAlpha((0.12 * 255).toInt()),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(btnCornerRadius ?? 100.r),
      ),
    );

    // Set the appropriate button style based on the type
    ButtonStyle buttonStyle;
    if (type == ButtonType.disable) {
      buttonStyle = disableButtonStyle;
    } else if (type == ButtonType.primary) {
      buttonStyle = primaryButtonStyle;
    } else if (type == ButtonType.secondary) {
      buttonStyle = secondaryButtonStyle;
    } else if (type == ButtonType.whiteButton) {
      buttonStyle = whiteButtonStyle;
    } else {
      buttonStyle = outlineButtonStyle;
    }

    // Disable the onPressed functionality if the button is of type 'disable'
    VoidCallback? onPressed = type == ButtonType.disable ? null : onTap;

    // Set shadow color conditionally based on the button type
    Color shadowColor;
    if (type == ButtonType.primary) {
      shadowColor = colorScheme.primary.withAlpha((0.20 * 255).toInt());
    } else if (type == ButtonType.secondary) {
      shadowColor = colorScheme.error.withAlpha((0.20 * 255).toInt());
    } else if (type == ButtonType.disable) {
      shadowColor = colorScheme.surfaceBright.withAlpha((0.20 * 255).toInt());
    } else if (type == ButtonType.whiteButton) {
      shadowColor = colorScheme.onSecondary.withAlpha((0.20 * 255).toInt());
    } else {
      shadowColor = colorScheme.error.withAlpha((0.20 * 255).toInt());
    }

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(0.0, 8.0),
            color: shadowColor,
            blurRadius: 16.0,
            spreadRadius: 0.0,
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed:
            onPressed, // Disable the button's interaction if the type is 'disable'
        style: buttonStyle,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            (svg ??
                SvgPicture.asset(
                  Assets.imagesIcDone,
                  width: 20.r,
                  height: 20.r,
                )).marginOnly(right: iconMarginRight ?? 4.w),
            CommonText.bold(
              label,
              textAlign: TextAlign.center,
              color: textColor,
              size: textSize ?? 16.sp,
              fontWeight: FontWeight.w800,
            ),
          ],
        ),
      ),
    );
  }
}
