import 'package:flutter/material.dart';

import '../helper/app_assets.dart';
import '../helper/colors.dart';
import '../helper/dimens.dart';

class AppButton extends StatelessWidget {
  final String label;
  final Function() onPressed;
  final double? width;
  final double height;
  final double textSize;
  final double radius;
  final EdgeInsets margin;

  final double iconSize;
  final Color? bgColor;
  final Color? backgroundColor;
  final Color textColor;
  final bool isBorder;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final MainAxisAlignment mainAxisAlignment;

  const AppButton(
      {required this.label,
      required this.onPressed,
      this.width,
      this.height = 48,
      this.textSize = 18,
      this.radius = 0,
      this.margin = EdgeInsets.zero,
      this.iconSize = 20,
      this.bgColor,
      this.backgroundColor ,
      this.textColor = whiteColor,
      this.isBorder = false,
      this.suffixIcon,
      this.mainAxisAlignment = MainAxisAlignment.center,
      this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width ?? MediaQuery.of(context).size.width,
      margin: margin,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF5f3969), Color(0xFFba3baa), Color(0xFF8146cc)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10),

        ),
      child: MaterialButton(
        height: height,
        color: backgroundColor,
        minWidth: width ?? MediaQuery.of(context).size.width / 2,
        elevation: 0,
        hoverElevation: 0,
        focusElevation: 0,
        disabledElevation: 0,
        highlightElevation: 0,
        splashColor: Colors.white.withOpacity(0.2),
        highlightColor: Colors.white.withOpacity(0.2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        onPressed: onPressed,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: mainAxisAlignment,
          children: [
            if (prefixIcon != null)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimens.dimen_15),
                child: prefixIcon!,
              ),
            Text(
              label,
              textAlign: TextAlign.center,
              softWrap: false,
              maxLines: 1,
              style: TextStyle(
                fontSize: textSize,
                color: textColor,
                fontFamily: Fonts.pBold,
              ),
            ),
            if (suffixIcon != null)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimens.dimen_8),
                child: suffixIcon!,
              ),
          ],
        ),
      ),
    );
  }
}

// class SocialButton extends StatelessWidget {
//   final String label;
//   final Function() onPressed;
//   final double? width;
//   final double height;
//   final double textSize;
//   final double radius;
//   final EdgeInsets margin;
//   final TextStyle? textStyle;
//   final String? icon;
//   final double iconSize;
//
//   const SocialButton({
//     super.key,
//     required this.label,
//     required this.onPressed,
//     this.width,
//     this.height = 50,
//     this.textSize = 14,
//     this.radius = 8,
//     this.margin = EdgeInsets.zero,
//     this.textStyle,
//     this.icon,
//     this.iconSize = 18,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: height,
//       width: width ?? MediaQuery.of(context).size.width,
//       margin: margin,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(radius),
//         // border: Border.all(color: AppColors.buttonBorder.withOpacity(0.2)),
//         color: Colors.transparent,
//       ),
//       child: MaterialButton(
//         height: height,
//         color: Colors.transparent,
//         minWidth: width ?? MediaQuery.of(context).size.width / 2,
//         elevation: 0,
//         hoverElevation: 0,
//         focusElevation: 0,
//         disabledElevation: 0,
//         highlightElevation: 0,
//         splashColor: Colors.white.withOpacity(0.2),
//         highlightColor: Colors.white.withOpacity(0.2),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(radius),
//         ),
//         onPressed: onPressed,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             icon == null
//                 ? Container()
//                 : Padding(
//                     padding:  EdgeInsets.only(right: Dimens.padding_5),
//                     child: Image.asset(
//                       icon!,
//                       width: iconSize,
//                     ),
//                   ),
//             Center(
//               child: Text(
//                 label,
//                 style: TextStyle(
//                   fontSize: textSize,
//                   color: Theme.of(context).textTheme.labelSmall!.color,
//                   // fontFamily: Fonts.semiBold,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class Social_link_Button extends StatelessWidget {
  final String label;
  final Function() onPressed;
  final double? width;
  final double height;
  final double textSize;
  final double radius;
  final EdgeInsets margin;

  final double iconSize;
  final Color? bgColor;
  final Color textColor;
  final bool isBorder;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final MainAxisAlignment mainAxisAlignment;

  const Social_link_Button(
      {required this.label,
        required this.onPressed,
        this.width = 287,
        this.height = 51,
        this.textSize = 12,
        this.radius = 0,
        this.margin = EdgeInsets.zero,
        this.iconSize = 20,
        this.bgColor,
        this.textColor = whiteColor,
        this.isBorder = false,
        this.suffixIcon,
        this.mainAxisAlignment = MainAxisAlignment.center,
        this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width ?? MediaQuery.of(context).size.width,
      margin: margin,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          border:
          Border.all(color: isBorder ? whiteColor : Colors.white),
          gradient: bgColor == null ?  LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[primaryColor.withOpacity(0.6), primaryColor],
          ) : null,
          color: bgColor),
      child: MaterialButton(
        height: height,
        color: Colors.transparent,
        minWidth: width ?? MediaQuery.of(context).size.width / 2,
        elevation: 0,
        hoverElevation: 0,
        focusElevation: 0,
        disabledElevation: 0,
        highlightElevation: 0,
        splashColor: Colors.white.withOpacity(0.2),
        highlightColor: Colors.white.withOpacity(0.2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        onPressed: onPressed,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: mainAxisAlignment,
          children: [
            if (prefixIcon != null)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimens.dimen_15),
                child: prefixIcon!,
              ),
            Expanded(
              child: Text(
                label,
                textAlign: TextAlign.center,
                softWrap: false,
                maxLines: 1,
                style: TextStyle(
                  fontSize: textSize,
                  color: textColor,
                  fontFamily: Fonts.medium,
                ),
              ),
            ),
            if (suffixIcon != null)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimens.dimen_8),
                child: suffixIcon!,
              ),
          ],
        ),
      ),
    );
  }
}

class UploadImageButton extends StatelessWidget {
  final String label;
  final Function() onPressed;
  final Widget child;
  final double? width;
  final double height;
  final double textSize;
  final double radius;
  final EdgeInsets margin;

  final double iconSize;
  final Color? bgColor;
  final Color? backgroundColor;
  final Color textColor;
  final bool isBorder;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final MainAxisAlignment mainAxisAlignment;

  const UploadImageButton(
      {required this.label,
        required this.onPressed,
        required this.child,
        this.width,
        this.height = 48,
        this.textSize = 18,
        this.radius = 0,
        this.margin = EdgeInsets.zero,
        this.iconSize = 20,
        this.bgColor,
        this.backgroundColor ,
        this.textColor = whiteColor,
        this.isBorder = false,
        this.suffixIcon,
        this.mainAxisAlignment = MainAxisAlignment.center,
        this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width ?? MediaQuery.of(context).size.width,
      margin: margin,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF5f3969), Color(0xFFba3baa), Color(0xFF8146cc)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10),

      ),
      child: MaterialButton(
        height: height,
        color: backgroundColor,
        minWidth: width ?? MediaQuery.of(context).size.width / 2,
        elevation: 0,
        hoverElevation: 0,
        focusElevation: 0,
        disabledElevation: 0,
        highlightElevation: 0,
        splashColor: Colors.white.withOpacity(0.2),
        highlightColor: Colors.white.withOpacity(0.2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        onPressed: onPressed,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: mainAxisAlignment,
          children: [
            if (prefixIcon != null)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimens.dimen_15),
                child: prefixIcon!,
              ),
            Text(
              label,
              textAlign: TextAlign.center,
              softWrap: false,
              maxLines: 1,
              style: TextStyle(
                fontSize: textSize,
                color: textColor,
                fontFamily: Fonts.pBold,
              ),
            ),
            if (suffixIcon != null)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimens.dimen_8),
                child: suffixIcon!,
              ),
            child,
          ],
        ),
      ),
    );
  }
}