import 'package:flutter/material.dart';
import 'package:mobile_outcastbarber/views/shared/dimens.dart';

enum TextStyling {
  heading2,
  heading3,
  heading4,
  heading5,
  body,
}

class TextComponent extends StatelessWidget {
  //must fill
  final TextStyling textStyling;
  final String text;

  //optional
  final int? maxlines;
  final Color? textcolor;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;

  TextComponent(
      {required this.text,
      required this.textStyling,
      this.maxlines,
      this.textcolor,
      this.textAlign,
      this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: textAlign ?? null,
        maxLines: maxlines,
        overflow: (maxlines != null) ? TextOverflow.ellipsis : null,
        // if-else approach in non-function type request
        style: textStyling == TextStyling.heading2
            ? Theme.of(context).textTheme.headline2!.copyWith(
                fontWeight: fontWeight ?? FontWeight.w500,
                fontSize: Dimens.SizeHeading2,
                color: textcolor ?? Colors.black)
            : textStyling == TextStyling.heading3
                ? Theme.of(context).textTheme.headline3!.copyWith(
                    fontWeight: fontWeight ?? FontWeight.w500,
                    fontSize: Dimens.SizeHeading3,
                    color: textcolor ?? Colors.black)
                : textStyling == TextStyling.heading4
                    ? Theme.of(context).textTheme.headline4!.copyWith(
                        fontWeight: fontWeight ?? FontWeight.w500,
                        fontSize: Dimens.SizeHeading4,
                        color: textcolor ?? Colors.black)
                    : textStyling == TextStyling.heading5
                        ? Theme.of(context).textTheme.headline5!.copyWith(
                            fontWeight: fontWeight ?? FontWeight.w500,
                            fontSize: Dimens.SizeHeading5,
                            color: textcolor ?? Colors.black)
                        : Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontWeight: fontWeight ?? FontWeight.w500,
                            fontSize: Dimens.Sizebody,
                            color: textcolor ?? Colors.black));
  }
}
