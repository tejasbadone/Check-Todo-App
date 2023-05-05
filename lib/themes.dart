import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance!.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class ChangeThemeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return FlutterSwitch(
      width: 70,
      height: 45,
      toggleSize: 45.0,
      value: themeProvider.isDarkMode,
      borderRadius: 30.0,
      padding: 2.0,
      activeToggleColor: Color(0xFF6E40C9),
      inactiveToggleColor: Color(0xFF2F363D),
      activeSwitchBorder: Border.all(
        color: Color(0xFF3C1E70),
        width: 6.0,
      ),
      inactiveSwitchBorder: Border.all(
        color: Color(0xFFD1D5DA),
        width: 6.0,
      ),
      activeColor: Color(0xFF271052),
      inactiveColor: Colors.white,
      activeIcon: Icon(
        Icons.nightlight_round,
        color: Color(0xFFF8E3A1),
      ),
      inactiveIcon: Icon(
        Icons.wb_sunny,
        color: Color(0xFFF8E3A1),
      ),
      onToggle: (val) {
        final provider = Provider.of<ThemeProvider>(context, listen: false);
        provider.toggleTheme(val);
      },
    );
  }
}

class Mytheme {
  static ThemeData lightTheme(BuildContext context) => ThemeData(
      primaryColorLight: Color(0xff757575),
      canvasColor: Colors.white,
      fontFamily: GoogleFonts.poppins().fontFamily,
      scaffoldBackgroundColor: lightBlue,
      accentColor: Colors.white,
      iconTheme: IconThemeData(color: lightBlue),
      checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateProperty.all(lightBlue),
          checkColor: MaterialStateProperty.all(Colors.white)),
      buttonColor: lightBlue,
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: lightBlue),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(lightBlue),
        ),
      ));

  static ThemeData darkTheme(BuildContext context) => ThemeData(
      primaryColorLight: Color(0xff04091C),
      canvasColor: lightBlack,
      accentColor: black,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: black,
      fontFamily: GoogleFonts.poppins().fontFamily,
      buttonColor: Colors.white,
      checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateProperty.all(Colors.white),
          checkColor: MaterialStateProperty.all(black)),
      iconTheme: IconThemeData(color: black),
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: Colors.white),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(black),
        ),
      ));

  static Color lightBlue = Colors.lightBlueAccent;
  static Color black = Color(0xff09153E);
  static Color indigo = Color(0xff6B29FA);
  static Color lightBlack = Color(0xff1D2950);
}
