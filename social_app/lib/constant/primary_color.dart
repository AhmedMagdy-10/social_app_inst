import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_app/core/helper/hexcolor_base.dart';

const Color kprimaryColor = Color.fromARGB(253, 255, 140, 176);

ThemeData lightTheme = ThemeData(
    fontFamily: 'Jannah',
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white, statusBarBrightness: Brightness.dark),
      titleTextStyle: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      iconTheme: IconThemeData(
        color: Colors.black,
        size: 25,
      ),
      elevation: 0.0,
    ),
    textTheme: const TextTheme(
        bodyLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        titleMedium: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          height: 1.3,
          color: Colors.black,
        )),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      elevation: 20,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey[600],
      selectedLabelStyle: const TextStyle(
        color: Colors.blue,
      ),
      unselectedLabelStyle: const TextStyle(
        color: Colors.grey,
      ),
    ));

ThemeData darkTheme = ThemeData(
    fontFamily: 'Jannah',
    brightness: Brightness.dark,
    scaffoldBackgroundColor: HexColor('333739'),
    appBarTheme: AppBarTheme(
      backgroundColor: HexColor('333739'),
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: HexColor('333739'),
          statusBarBrightness: Brightness.light),
      titleTextStyle: const TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      elevation: 0.0,
    ),
    textTheme: const TextTheme(
        bodyLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        titleMedium: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          height: 1.3,
          color: Colors.white,
        )),
    colorScheme: ColorScheme.highContrastDark(
      background: HexColor('433739'),
      secondary: Colors.blue,
    ),
    buttonTheme: const ButtonThemeData(
        buttonColor: Colors.blue, // Customize the button color
        textTheme: ButtonTextTheme.primary // Customize the button text color
        ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: HexColor('333739'),
      elevation: 20,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey[600],
      selectedLabelStyle: const TextStyle(
        color: Colors.blue,
      ),
      unselectedLabelStyle: const TextStyle(
        color: Colors.grey,
      ),
    ));
