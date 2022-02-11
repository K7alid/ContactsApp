import 'package:bloc/bloc.dart';
import 'package:contacts_app/contact_layout/my_project_home.dart';
import 'package:flutter/material.dart';
import 'shared/bloc_observer.dart';

void main()
{
  BlocOverrides.runZoned(
        ()
    {
      runApp(MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xffd4ddec),
        primarySwatch: Colors.indigo,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xff3e4685),
          selectedItemColor: Color(0xffd4ddec),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xff3e4685),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: MyProjectHome(),
    );
  }
}
