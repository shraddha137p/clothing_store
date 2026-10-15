import 'dart:math' as math;

import 'package:clothing_store/gen/assets.gen.dart';
import 'package:clothing_store/utilities/common/extensions.dart';
import 'package:clothing_store/utilities/common/widget_extensions.dart';
import 'package:clothing_store/utilities/common/widgets/common_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommonTextField extends StatelessWidget {
  final List<TextInputFormatter> inputFormatters;
  final FormFieldValidator<String>? validator;
  final GlobalKey<FormFieldState>? _fieldKey;
  final ValueChanged<String>? fieldSubmitted;
  final TextEditingController controller;
  final BoxConstraints? iconConstraints;
  final Iterable<String>? autofillHints;
  final ValueChanged<String>? onChanged;
  final TextInputType keyboardType;
  final TextInputAction inputAction;
  final String obscuringCharacter;
  final TextAlign textAlign;
  final VoidCallback? onTap;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String labelText;
  final FocusNode? focus;
  final bool isReadOnly;
  final String hintText;
  final Widget? suffix;
  final Widget? prefix;
  final bool isCanSee;
  final bool obscure;
  final int maxLines;
  final int minLines;
  final Widget Function(
    BuildContext, {
    required int currentLength,
    required bool isFocused,
    required int? maxLength,
  })?
  buildCounter;
  final TextCapitalization? textCapitalization;
  final Color? bgColor;
  final Color? textColor;
  final Color? borderColor;
  final Color? cursorColor;
  final double? contentPadding;
  final double? verticalPadding;
  final double? horizontalPadding;
  final int? maxLength;
  final double? borderWidth;
  final double borderRadius;
  final String? showCounter;

  const CommonTextField({
    required this.controller,
    this.labelText = "",
    GlobalKey<FormFieldState>? globalKey,
    this.keyboardType = TextInputType.text,
    this.obscure = false,
    this.inputAction = TextInputAction.next,
    this.validator,
    this.fieldSubmitted,
    this.focus,
    this.onChanged,
    this.prefix,
    this.suffix,
    this.prefixIcon,
    this.suffixIcon,
    this.inputFormatters = const [],
    this.maxLines = 1,
    this.minLines = 1,
    this.isReadOnly = false,
    this.hintText = "",
    this.textAlign = TextAlign.start,
    this.onTap,
    this.iconConstraints = const BoxConstraints(maxWidth: 160),
    super.key,
    this.obscuringCharacter = '•',
    this.autofillHints,
    this.isCanSee = false,
    this.buildCounter,
    this.textCapitalization,
    this.borderColor,
    this.bgColor,
    this.textColor,
    this.cursorColor,
    this.contentPadding,
    this.verticalPadding = 16,
    this.horizontalPadding = 16,
    this.borderRadius = 12,
    this.maxLength,
    this.showCounter,
    this.borderWidth,
  }) : _fieldKey = globalKey;

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder borderStyle = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: BorderSide(
        color:
            borderColor ??
            context.colorScheme.surfaceContainerLowest.withValues(alpha: 0.2),
        width: borderWidth ?? 1.5,
      ),
    );

    OutlineInputBorder focusedBorderStyle = borderStyle.copyWith(
      borderSide: BorderSide(
        color: borderColor ?? context.colorScheme.surfaceContainerLowest,
        width: borderWidth ?? 1.5,
      ),
    );

    OutlineInputBorder errorBorderStyle = borderStyle.copyWith(
      borderSide: BorderSide(
        color: context.colorScheme.error,
        width: borderWidth ?? 1.5,
      ),
    );

    return TextFormField(
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      cursorColor: cursorColor ?? context.colorScheme.onSurfaceVariant,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscuringCharacter: obscuringCharacter,
      inputFormatters: inputFormatters,
      onFieldSubmitted: fieldSubmitted,
      autofillHints: autofillHints,
      textInputAction: inputAction,
      buildCounter: buildCounter,
      keyboardType: keyboardType,
      controller: controller,
      obscureText: obscure,
      onChanged: onChanged,
      maxLength: maxLength,
      validator: validator,
      textAlign: textAlign,
      readOnly: isReadOnly,
      maxLines: maxLines,
      minLines: minLines,
      focusNode: focus,
      key: _fieldKey,
      onTap: onTap,
      style: context.textTheme.bodyLarge?.copyWith(
        color: textColor ?? context.colorScheme.onSurface,
        fontWeight: FontWeight.w400,
        fontSize: 14.sp,
      ),
      decoration: InputDecoration(
        prefixIconConstraints:
            iconConstraints ?? BoxConstraints(maxWidth: 160.w),
        suffixIconConstraints:
            iconConstraints ?? BoxConstraints(maxWidth: 160.w),
        suffixIcon: suffixIcon?.marginOnly(left: 14.w, right: 14.w),
        prefixIcon: prefixIcon?.marginOnly(left: 14.w, right: 8.w),
        fillColor: bgColor ?? context.colorScheme.surface,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        errorStyle: context.textTheme.bodyMedium!.copyWith(
          color: context.colorScheme.error,
          fontSize: 12.sp,
        ),
        hintStyle: context.textTheme.bodyMedium!.copyWith(
          color: context.colorScheme.onInverseSurface,
          fontSize: 14.sp,
        ),
        isDense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        focusedBorder: focusedBorderStyle,
        errorBorder: errorBorderStyle,
        enabledBorder: borderStyle,
        counterText: showCounter,
        alignLabelWithHint: true,
        border: borderStyle,
        hintText: hintText,
        prefix: prefix,
        suffix: suffix,
        filled: true,
      ),
    );
  }
}

class CommonDropDownField extends StatelessWidget {
  const CommonDropDownField({
    super.key,
    required this.hintText,
    required this.onSave,
    required this.items,
    required this.errorText,
    this.selectedValue,
    this.bgColor,
    this.txtColor,
    this.isSelectedItemTxtClrSame = false,
    this.dropDownStyleDecoration,
    this.isExpandState = false,
    this.selectedItemTxtLength,
    this.menuItemStyleData,
    this.contentPaddingVertical = 6,
    this.contentPaddingRight = 12,
    this.contentPaddingLeft = 12,
    this.isValidate = false,
    this.isBorderAllSide = false,
    required this.onMenuStateChanges,
  });

  final String hintText;
  final String errorText;
  final String? selectedValue;
  final Function(String?) onSave;
  final List<String> items;
  final Color? bgColor;
  final Color? txtColor;

  final bool isSelectedItemTxtClrSame;

  final BoxDecoration? dropDownStyleDecoration;
  final bool isExpandState;
  final Function(bool?) onMenuStateChanges;
  final int? selectedItemTxtLength;
  final MenuItemStyleData? menuItemStyleData;
  final double contentPaddingVertical;
  final double contentPaddingRight;
  final double contentPaddingLeft;
  final bool isValidate;

  final bool isBorderAllSide;

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder borderStyle = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: BorderSide(
        color: context.colorScheme.surfaceContainerLowest.withValues(
          alpha: 0.2,
        ),
        width: 1.5,
      ),
    );

    OutlineInputBorder focusedBorderStyle = borderStyle.copyWith(
      borderSide: BorderSide(
        color: context.colorScheme.surfaceContainerLowest,
        width: 1.5,
      ),
    );

    return Container(
      width: double.infinity,
      height: 45.h,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(0.0, 1.0),
            color: context.colorScheme.surfaceContainer.withAlpha(
              (0.12 * 255).toInt(),
            ), // Blue with opacity 16%
            blurRadius: 2.0,
            spreadRadius: 0.0,
          ),
        ],
      ),
      child: DropdownButtonFormField2<String>(
        isExpanded: true,
        onChanged: (value) => onSave(value),
        onMenuStateChange: (value) => onMenuStateChanges(value),
        decoration: InputDecoration(
          alignLabelWithHint: true,
          contentPadding: EdgeInsets.only(
            top: contentPaddingVertical.h,
            bottom: contentPaddingVertical.h,
            left: contentPaddingLeft.w,
            right: contentPaddingRight.w,
          ),
          labelText: hintText,
          floatingLabelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: context.colorScheme.primary,
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
          ),
          labelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: context.colorScheme.onSurface,
            fontWeight: FontWeight.w300,
            fontSize: 14.sp,
          ),
          errorStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: context.colorScheme.error,
            fontWeight: FontWeight.w500,
            fontSize: 12.sp,
          ),
          errorMaxLines: 4,
          border: borderStyle,
          errorBorder: borderStyle,
          focusedBorder: focusedBorderStyle,
          focusedErrorBorder: focusedBorderStyle,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          enabledBorder: borderStyle,
          fillColor: bgColor ?? context.colorScheme.surface,
          filled: true,
        ),
        validator: (value) => isValidate
            ? (value == null)
                  ? errorText
                  : null
            : null,
        iconStyleData: IconStyleData(
          icon: Transform.rotate(
            angle: isExpandState ? 180 * math.pi / 180 : 0,
            child: SvgPicture.asset(
              Assets.imagesIcDropDownIcon,
              width: 20.r,
              height: 20.r,
            ),
          ),
        ),
        dropdownStyleData: DropdownStyleData(
          padding: menuItemStyleData != null ? EdgeInsets.zero : null,
          decoration:
              dropDownStyleDecoration ??
              BoxDecoration(
                color: bgColor ?? context.colorScheme.surface,
                borderRadius: isBorderAllSide
                    ? BorderRadius.circular(8.r)
                    : BorderRadius.only(
                        bottomLeft: Radius.circular(8.r),
                        bottomRight: Radius.circular(8.r),
                      ),
                border: isBorderAllSide
                    ? Border.all(
                        color: context.colorScheme.surfaceContainerLowest
                            .withValues(alpha: 0.2),
                        width: 1,
                      )
                    : Border(
                        bottom: BorderSide(
                          color: context.colorScheme.surfaceContainerLowest
                              .withValues(alpha: 0.2),
                          width: 1,
                        ),
                        left: BorderSide(
                          color: context.colorScheme.surfaceContainerLowest
                              .withValues(alpha: 0.2),
                          width: 1,
                        ),
                        right: BorderSide(
                          color: context.colorScheme.surfaceContainerLowest
                              .withValues(alpha: 0.2),
                          width: 1,
                        ),
                      ),
              ),
        ),
        menuItemStyleData: menuItemStyleData ?? MenuItemStyleData(),
        items: items
            .map(
              (item) => DropdownItem<String>(
                value: item,
                height: 40,
                child: CommonText.regular(
                  item,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  color: txtColor ?? context.colorScheme.onSurface,
                  size: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            )
            .toList(),
        selectedItemBuilder: (context) {
          return items.map((item) {
            return CommonText.regular(
              textAlign: TextAlign.start,
              selectedItemTxtLength != null
                  ? item.substring(0, selectedItemTxtLength ?? 1)
                  : item,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              color: isSelectedItemTxtClrSame
                  ? txtColor
                  : context.colorScheme.onSurface,
              size: 14.sp,
              fontWeight: FontWeight.w400,
            );
          }).toList();
        },
      ),
    );
  }
}
