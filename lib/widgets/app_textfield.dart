import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../helper/app_assets.dart';
import '../helper/colors.dart';
import '../helper/dimens.dart';

class AppTextField extends StatelessWidget {
  final String titleText;
  final TextEditingController? controller;
  final int? maxLines;
  final bool? isReadOnly;
  final bool? isEnabled;
  final int? maxLength;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final Function(String)? onchanged;
  final FormFieldValidator? validator;
  final Function()? onTap;
  final String? hintText;
  final List<TextInputFormatter>? inputFormatters;
  final String? prefix;
  final Widget? prefixWidget;
  final Widget? suffix;
  final TextAlign? textAlign;
  final bool? autoValidate;
  final EdgeInsets? contentPadding;
  final bool? isCapital;
  final bool? isFilled;
  final ValueChanged<String>? onFieldSubmitted;
  final double? borderRadius;
  final Color? borderColor;
  final Color? fillColor;
  final String? labelText;
  final Color? prefixColor;
  const AppTextField(
      {super.key,
      required this.titleText,
      this.controller,
      this.maxLines,
      this.isReadOnly = false,
      this.isEnabled,
      this.maxLength,
      this.obscureText = false,
      this.keyboardType,
      this.onchanged,
      this.validator,
      this.onTap,
      this.hintText,
      this.inputFormatters,
      this.prefix,
      this.prefixWidget,
      this.suffix,
      this.textAlign,
      this.autoValidate = false,
      this.contentPadding,
      this.isCapital,
      this.onFieldSubmitted,
      this.isFilled = true,
      this.borderRadius = 0,
      this.borderColor = primaryColor,
      this.fillColor,
      this.labelText,
      this.prefixColor = textFieldIconColor, required InputDecoration decoration});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleText.isNotEmpty
            ? Text(
                titleText,
                style: TextStyle(
                  fontSize: Dimens.fontSize_12,
                  fontFamily: Fonts.semibold,
                  color: whiteColor,
                ),
              )
            : const SizedBox.shrink(),
        SizedBox(
          height: Dimens.height_6,
        ),
        TextFormField(
          controller: controller,
          style: TextStyle(
            fontSize: Dimens.fontSize_18,
            color: whiteColor,
            fontFamily: Fonts.regular,
          ),
          maxLines: maxLines ?? 1,
          readOnly: isReadOnly!,
          enabled: isEnabled,
          maxLength: maxLength,
          obscureText: obscureText!,
          decoration: InputDecoration(
              filled: isFilled,
              fillColor: buttonBackground,
              contentPadding: contentPadding ??
                  EdgeInsets.only(
                    left: Dimens.padding_15,
                    top: Dimens.padding_10,
                    right: Dimens.padding_15,
                    bottom: Dimens.padding_10,
                  ),
              hintText: hintText,
              hintStyle: TextStyle(
                  fontSize: Dimens.fontSize_18,
                  fontFamily: Fonts.regular,
                  color: whiteColor),
              labelText: labelText,
              labelStyle: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontFamily: Fonts.regular,
                letterSpacing: -0.1,
                fontSize: Dimens.fontSize_14,
                color: hintColor.withOpacity(0.24),
              ),
              border: OutlineInputBorder(
                borderRadius:
                BorderRadius.circular(maxLines == null ? borderRadius! : 6),
                borderSide: isFilled!
                    ? BorderSide.none
                    : BorderSide(width: 1.0, color: borderColor!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius:
                BorderRadius.circular(maxLines == null ? borderRadius! : 6),
                borderSide: isFilled!
                    ? BorderSide.none
                    : BorderSide(width: 1.0, color: borderColor!),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius:
                BorderRadius.circular(maxLines == null ? borderRadius! : 6),
                borderSide: isFilled!
                    ? BorderSide.none
                    : BorderSide(width: 1.0, color: borderColor!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius:
                BorderRadius.circular(maxLines == null ? borderRadius! : 6),
                borderSide: isFilled!
                    ? BorderSide.none
                    : BorderSide(width: 1.0, color: borderColor!),
              ),
              prefixIcon: prefixWidget ??
                  (prefix == null
                      ? null
                      : Padding(
                    padding:  EdgeInsets.only(
                        left: Dimens.padding_10, top: Dimens.padding_10, bottom: Dimens.padding_10, right: Dimens.padding_6),
                    child: SvgPicture.asset(
                      prefix!,
                      width: Dimens.width_30,
                      height: Dimens.height_30,
                      colorFilter:
                      ColorFilter.mode(prefixColor!, BlendMode.srcIn),
                    ),
                  )),

              suffixIcon: Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimens.padding_10),
                child: suffix,
              ),
              suffixIconColor: textFieldIconColor,
              suffixIconConstraints: BoxConstraints(
                minHeight: Dimens.height_20,
                minWidth: Dimens.width_20,
              ),
              counterText: ""),
          keyboardType: keyboardType ?? TextInputType.text,
          cursorColor: blackColor,
          onChanged: onchanged ?? (val) {},
          onTap: onTap ?? () {},
          validator: validator,
          autovalidateMode: autoValidate!
              ? AutovalidateMode.onUserInteraction
              : AutovalidateMode.onUserInteraction,
        )
      ],
    );
  }
}

class DashboardTextField extends StatelessWidget {
  final String titleText;
  final TextEditingController? controller;
  final int? maxLines;
  final bool? isReadOnly;
  final bool? isEnabled;
  final int? maxLength;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final Function(String)? onchanged;
  final FormFieldValidator? validator;
  final Function()? onTap;
  final String? hintText;
  final List<TextInputFormatter>? inputFormatters;
  final String? prefix;
  final Widget? prefixWidget;
  final Widget? suffix;
  final TextAlign? textAlign;
  final bool? autoValidate;
  final EdgeInsets? contentPadding;
  final bool? isCapital;
  final bool? isFilled;
  final ValueChanged<String>? onFieldSubmitted;
  final double? borderRadius;
  final Color? borderColor;
  final Color? fillColor;
  final String? labelText;
  final double? fontSizes;
  final Color? prefixColor;
  const DashboardTextField(
      {super.key,
        this.titleText = "",
        this.controller,
        this.maxLines,
        this.isReadOnly = false,
        this.isEnabled,
        this.maxLength,
        this.obscureText = false,
        this.keyboardType,
        this.onchanged,
        this.validator,
        this.onTap,
        required this.hintText,
        this.inputFormatters,
        this.prefix,
        this.prefixWidget,
        this.suffix,
        this.textAlign,
        this.autoValidate = false,
        this.contentPadding,
        this.isCapital,
        this.onFieldSubmitted,
        this.isFilled = true,
        this.fontSizes,
        this.borderRadius = 10,
        this.borderColor = primaryColor,
        this.fillColor = textFieldFillColor,
        this.labelText,
        this.prefixColor = textFieldIconColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleText.isNotEmpty
            ? Text(
          titleText,
          style: TextStyle(
            fontSize: Dimens.fontSize_12,
            fontFamily: Fonts.semibold,
            color: whiteColor,
          ),
        )
            : const SizedBox.shrink(),
        SizedBox(
          height: Dimens.height_6,
        ),
        TextFormField(
          controller: controller,
          style: TextStyle(
            fontSize: Dimens.fontSize_18,
            color: hintColor,
            fontFamily: Fonts.regular,
          ),
          maxLines: maxLines ?? 1,
          readOnly: isReadOnly!,
          enabled: isEnabled,
          maxLength: maxLength,
          obscureText: obscureText!,
          textAlign: textAlign ?? TextAlign.start,
          decoration: InputDecoration(
              filled: isFilled,
              fillColor:fillColor,
              contentPadding: contentPadding ??
                  EdgeInsets.only(
                    left: Dimens.padding_20,
                    top: Dimens.padding_5,
                    right: Dimens.padding_15,
                    bottom: Dimens.padding_5,
                  ),
              hintText: hintText,
              hintStyle: TextStyle(
                  fontSize: fontSizes ?? Dimens.fontSize_10,
                  fontFamily: Fonts.pRegular,
                  color: hintColorDashboard),
              labelText: labelText,
              labelStyle: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontFamily: Fonts.regular,
                letterSpacing: -0.1,
                fontSize: Dimens.fontSize_14,
                color: hintColor.withOpacity(0.24),
              ),
              border: OutlineInputBorder(
                borderRadius:
                BorderRadius.circular(maxLines == null ? borderRadius! : 6),
                borderSide: isFilled!
                    ? BorderSide.none
                    : BorderSide(width: 1.0, color: borderColor!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius:
                BorderRadius.circular(maxLines == null ? borderRadius! : 6),
                borderSide: isFilled!
                    ? BorderSide.none
                    : BorderSide(width: 1.0, color: borderColor!),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius:
                BorderRadius.circular(maxLines == null ? borderRadius! : 6),
                borderSide: isFilled!
                    ? BorderSide.none
                    : BorderSide(width: 1.0, color: borderColor!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius:
                BorderRadius.circular(maxLines == null ? borderRadius! : 6),
                borderSide: isFilled!
                    ? BorderSide.none
                    : BorderSide(width: 1.0, color: borderColor!),
              ),
              prefixIcon: prefixWidget ??
                  (prefix == null
                      ? null
                      : Padding(
                    padding:  EdgeInsets.only(
                        left: Dimens.padding_10, top: Dimens.padding_10, bottom: Dimens.padding_10, right: Dimens.padding_6),
                    child: SvgPicture.asset(
                      prefix!,
                      width: Dimens.width_30,
                      height: Dimens.height_30,
                      colorFilter:
                      ColorFilter.mode(prefixColor!, BlendMode.srcIn),
                    ),
                  )),

              suffixIcon: Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimens.padding_10),
                child: suffix,
              ),
              suffixIconColor: textFieldIconColor,
              suffixIconConstraints: BoxConstraints(
                minHeight: Dimens.height_20,
                minWidth: Dimens.width_20,
              ),
              counterText: ""),
          keyboardType: keyboardType ?? TextInputType.text,
          cursorColor: blackColor,
          onChanged: onchanged ?? (val) {},
          onTap: onTap ?? () {},
          validator: validator,
          autovalidateMode: autoValidate!
              ? AutovalidateMode.onUserInteraction
              : AutovalidateMode.onUserInteraction,
        ),
      ],
    );
  }
}

class SignupTextField extends StatelessWidget {
  final String titleText;
  final TextEditingController? controller;
  final int? maxLines;
  final bool? isReadOnly;
  final bool? isEnabled;
  final int? maxLength;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final Function(String)? onchanged;
  final FormFieldValidator? validator;
  final Function()? onTap;
  final String? hintText;
  final List<TextInputFormatter>? inputFormatters;
  final String? prefix;
  final Widget? prefixWidget;
  final Widget? suffix;
  final TextAlign? textAlign;
  final bool? autoValidate;
  final EdgeInsets? contentPadding;
  final bool? isCapital;
  final bool? isFilled;
  final ValueChanged<String>? onFieldSubmitted;
  final double? borderRadius;
  final Color? borderColor;
  final Color? fillColor;
  final String? labelText;
  final Color? prefixColor;
  const SignupTextField(
      {super.key,
        required this.titleText,
        this.controller,
        this.maxLines,
        this.isReadOnly = false,
        this.isEnabled,
        this.maxLength,
        this.obscureText = false,
        this.keyboardType,
        this.onchanged,
        this.validator,
        this.onTap,
        this.hintText,
        this.inputFormatters,
        this.prefix,
        this.prefixWidget,
        this.suffix,
        this.textAlign,
        this.autoValidate = false,
        this.contentPadding,
        this.isCapital,
        this.onFieldSubmitted,
        this.isFilled = true,
        this.borderRadius = 0,
        this.borderColor = primaryColor,
        this.fillColor = blackColor,
        this.labelText,
        this.prefixColor = textFieldIconColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleText.isNotEmpty
            ? Text(
          titleText,
          style: TextStyle(
            fontSize: Dimens.fontSize_12,
            fontFamily: Fonts.semibold,
            color: whiteColor,
          ),
        )
            : const SizedBox.shrink(),
        SizedBox(
          height: Dimens.height_6,
        ),
        TextFormField(
          controller: controller,
          style: TextStyle(
            fontSize: Dimens.fontSize_18,
            color: hintColor,
            fontFamily: Fonts.regular,
          ),
          maxLines: maxLines ?? 1,
          readOnly: isReadOnly!,
          enabled: isEnabled,
          maxLength: maxLength,
          obscureText: obscureText!,
          decoration: InputDecoration(
              filled: isFilled,
              fillColor: whiteColor,
              contentPadding: contentPadding ??
                  EdgeInsets.only(
                    left: Dimens.padding_15,
                    top: Dimens.padding_10,
                    right: Dimens.padding_15,
                    bottom: Dimens.padding_10,
                  ),
              hintText: hintText,
              hintStyle: TextStyle(
                  fontSize: Dimens.fontSize_18,
                  fontFamily: Fonts.regular,
                  color: hintColor),
              labelText: labelText,
              labelStyle: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontFamily: Fonts.regular,
                letterSpacing: -0.1,
                fontSize: Dimens.fontSize_14,
                color: hintColor.withOpacity(0.24),
              ),
              border: OutlineInputBorder(
                borderRadius:
                BorderRadius.circular(maxLines == null ? borderRadius! : 6),
                borderSide: isFilled!
                    ? BorderSide.none
                    : BorderSide(width: 1.0, color: borderColor!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius:
                BorderRadius.circular(maxLines == null ? borderRadius! : 6),
                borderSide: isFilled!
                    ? BorderSide.none
                    : BorderSide(width: 1.0, color: borderColor!),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius:
                BorderRadius.circular(maxLines == null ? borderRadius! : 6),
                borderSide: isFilled!
                    ? BorderSide.none
                    : BorderSide(width: 1.0, color: borderColor!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius:
                BorderRadius.circular(maxLines == null ? borderRadius! : 6),
                borderSide: isFilled!
                    ? BorderSide.none
                    : BorderSide(width: 1.0, color: borderColor!),
              ),
              prefixIcon: prefixWidget ??
                  (prefix == null
                      ? null
                      : Padding(
                    padding:  EdgeInsets.only(
                        left: Dimens.padding_10, top: Dimens.padding_10, bottom: Dimens.padding_10, right: Dimens.padding_6),
                    child: SvgPicture.asset(
                      prefix!,
                      width: Dimens.width_30,
                      height: Dimens.height_30,
                      colorFilter:
                      ColorFilter.mode(prefixColor!, BlendMode.srcIn),
                    ),
                  )),

              suffixIcon:
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimens.padding_10),
                child: suffix,
              ),
              suffixIconColor: textFieldIconColor,
              suffixIconConstraints: BoxConstraints(
                minHeight: Dimens.height_20,
                minWidth: Dimens.width_20,
              ),
              counterText: ""),
          keyboardType: keyboardType ?? TextInputType.text,
          cursorColor: blackColor,
          onChanged: onchanged ?? (val) {},
          onTap: onTap ?? () {},
          validator: validator,
          autovalidateMode: autoValidate!
              ? AutovalidateMode.onUserInteraction
              : AutovalidateMode.onUserInteraction,
        )
      ],
    );
  }
}

