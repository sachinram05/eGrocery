import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

final colorScheme = ColorScheme.fromSeed(
  onPrimary: const Color.fromARGB(255, 22, 22, 46),
  onPrimaryContainer: const Color.fromARGB(255,247,247,247),
  brightness: Brightness.light,
  seedColor: const Color.fromARGB(255,247,247,247),
  surface: const Color.fromARGB(255, 247, 247, 247),
);

final theme = ThemeData().copyWith(
    scaffoldBackgroundColor: const Color.fromARGB(255,247,247,247),
    colorScheme: colorScheme,
    drawerTheme: const DrawerThemeData(backgroundColor: Colors.white),
    listTileTheme:const  ListTileThemeData(
      tileColor: Color.fromARGB(255,247,247,247),
    ),

bottomNavigationBarTheme:const BottomNavigationBarThemeData(
  elevation: 0,
  showSelectedLabels: false,
  showUnselectedLabels: false,
  type: BottomNavigationBarType.fixed,
  backgroundColor:  Color.fromARGB(255,247,247,247),
      unselectedItemColor:  Color.fromARGB(255, 78, 76, 76)
),

inputDecorationTheme: InputDecorationTheme(
  fillColor: Colors.white,
  filled: true,
  labelStyle: TextStyle(color: Colors.grey.withOpacity(0.8) ,fontSize:20,fontWeight: FontWeight.normal ),
  alignLabelWithHint: true,
  floatingLabelBehavior: FloatingLabelBehavior.never,
  hintStyle: TextStyle(color: Colors.grey.withOpacity(0.4)),
  border: const OutlineInputBorder( 
          borderSide: BorderSide(color: Color.fromARGB(255, 67, 66, 66), width: 1),
          borderRadius: BorderRadius.all(Radius.circular(6.0))),
          enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 142, 140, 140),width: 1),
          borderRadius: BorderRadius.all(Radius.circular(6.0))),
          focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 62, 62, 62),width: 1.4),
          borderRadius: BorderRadius.all(Radius.circular(6.0))),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 14, 206, 129),
        disabledBackgroundColor:
        const Color.fromARGB(255, 14, 206, 129).withOpacity(0.6),
        disabledForegroundColor: Colors.grey,
        padding: const EdgeInsets.symmetric(vertical: 14.0),
        textStyle: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Colors.green, width: 1.5),
        minimumSize: const Size(double.infinity, 56.0),
        disabledForegroundColor: Colors.grey,
        foregroundColor: Colors.green,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        textStyle: GoogleFonts.ubuntuCondensed(fontSize: 16.0, fontWeight: FontWeight.bold),
        shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: const Color.fromARGB(255, 14, 206, 129), textStyle: GoogleFonts.ubuntuCondensed(fontSize: 20.0, fontWeight: FontWeight.bold))),
       
        cardTheme: const CardTheme().copyWith(color: const Color.fromARGB(255, 255, 255, 255),margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 0)),
       
        textTheme: GoogleFonts.ubuntuCondensedTextTheme().copyWith(
          headlineLarge: GoogleFonts.lobster(fontWeight: FontWeight.bold, color: colorScheme.primaryContainer),
          displaySmall: GoogleFonts.exo2(fontSize:18, color: const Color.fromARGB(255, 129, 129, 132)),
          displayLarge: GoogleFonts.lobster(fontWeight: FontWeight.bold, color: colorScheme.onPrimaryContainer),
          displayMedium: GoogleFonts.ubuntuCondensed(fontSize: 24, color: const Color.fromARGB(255, 129, 129, 132)),
          headlineMedium: GoogleFonts.ubuntuCondensed(fontSize: 18, color: Colors.black),
          headlineSmall: GoogleFonts.ubuntuCondensed(fontSize: 16, color: const Color.fromARGB(255, 197, 197, 203)),
       labelLarge: GoogleFonts.ubuntuCondensed(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.black),
       labelMedium: GoogleFonts.ubuntuCondensed(fontSize: 16,  color: colorScheme.secondaryContainer),
       // labelSmall: GoogleFonts.ubuntuCondensed(fontWeight: FontWeight.bold, color: Colors.white),
      
          bodyMedium: GoogleFonts.ubuntuCondensed(fontSize: 16,color: colorScheme.onPrimary),
          bodyLarge: GoogleFonts.ubuntuCondensed(fontSize: 24,fontWeight: FontWeight.w600,color:Colors.black),
          titleSmall: GoogleFonts.ubuntuCondensed(fontWeight: FontWeight.w600,fontSize: 30,color: colorScheme.onPrimary),
          titleMedium: GoogleFonts.ubuntuCondensed(fontWeight: FontWeight.bold, fontSize: 34, color: colorScheme.onPrimary),
          titleLarge: GoogleFonts.ubuntuCondensed(fontWeight: FontWeight.bold, color: Colors.white),
    )
    );
