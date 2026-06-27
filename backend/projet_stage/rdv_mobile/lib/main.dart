import 'package:flutter/material.dart';

import 'screens/login_screen.dart';

void main() {

  runApp(
    const MyApp()
  );

}



class MyApp extends StatelessWidget {


  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {


    return MaterialApp(

      debugShowCheckedModeBanner: false,

      title: "RDV Médical",


      home: LoginScreen(),

   
   theme: ThemeData(

  useMaterial3: true,

  scaffoldBackgroundColor:
      const Color(0xffF7F9FF),


  colorScheme: ColorScheme.fromSeed(

    seedColor:
        const Color(0xff7C5CFC),

  ),


  inputDecorationTheme:
      const InputDecorationTheme(

    filled: true,

    fillColor:
        Colors.white,

    border:
        OutlineInputBorder(

      borderRadius:
          BorderRadius.all(
            Radius.circular(20),
          ),

      borderSide:
          BorderSide.none,

    ),

  ),


  cardTheme:
      const CardThemeData(

    color:
        Colors.white,

    elevation:
        4,

    shape:
        RoundedRectangleBorder(

      borderRadius:
          BorderRadius.all(
            Radius.circular(25),
          ),

    ),

  ),


) );


  }

}