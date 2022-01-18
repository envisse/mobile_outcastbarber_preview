import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_outcastbarber/views/shared/colors.dart';

ThemeData themeData() {
  return ThemeData(
    //BUTTON
    //theming elevated button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: new RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5)),  
        primary: ColorsPicker.SecondaryColor   
      ),
    ),
    //theming outlinedbutton
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: new RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5)),
        primary: ColorsPicker.SecondaryColor   
      ),
    ),


    //FORM FIELD
    //theming textform field
    inputDecorationTheme: InputDecorationTheme(        
      labelStyle: TextStyle(color: ColorsPicker.BackgroundColor2),
      errorStyle: TextStyle(color: ColorsPicker.ErrorColor),
      border:
          const OutlineInputBorder(borderSide: BorderSide(color: ColorsPicker.BackgroundColor2)),
      focusedBorder:
          const OutlineInputBorder(borderSide: BorderSide(color: ColorsPicker.PrimaryColor)),
      enabledBorder:
          const OutlineInputBorder(borderSide: BorderSide(color: ColorsPicker.BackgroundColor2)),
      errorBorder:
          const OutlineInputBorder(borderSide: BorderSide(color: ColorsPicker.ErrorColor)),
      focusedErrorBorder:
          const OutlineInputBorder(borderSide: BorderSide(color: ColorsPicker.ErrorColor)),
    ),

    //TEXT
    //Change font style
    textTheme : GoogleFonts.robotoTextTheme(),

    //APPBAR
    appBarTheme: AppBarTheme(
      backgroundColor: ColorsPicker.SecondaryColor,
      iconTheme: IconThemeData(color: Colors.white)
      ),
    
  );
}
