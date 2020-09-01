import 'package:flutter/material.dart';

import './Screens/HomeScreen.dart';
import './Screens/ApartmanScreen.dart';
import './Screens/ReservationViewScreen.dart';
import './Screens/CreateReservationScreen.dart';
import './Screens/AddIncomeScreen.dart';
import './providers/reservations.dart';
import './providers/users.dart';
import './providers/apartmani.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider<Apartmani>(
        create: (context) => Apartmani(),
        lazy: true,
      ),
      ChangeNotifierProvider<Reservations>(
        create: (context) => Reservations(),
      ),
      ChangeNotifierProvider.value(
        value: Users(),
      ),
    ], child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        disabledColor: Colors.red,
        // This is the theme of your application.
        fontFamily: "Minya",
        textTheme: TextTheme(
          headline6: TextStyle(
            fontFamily: "Minya",
            fontStyle: FontStyle.normal,
          ),
        ),
        primaryColor: Color.fromRGBO(30, 20, 255, 1),
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
      routes: {
        ApartmanScreen.routeName: (ctx) => ApartmanScreen(),
        ReservationViewScreen.routeName: (ctx) => ReservationViewScreen(),
        CreateReservationScreen.routeName: (ctx) => CreateReservationScreen(),
        AddIncomeScreen.routeName: (ctx) => AddIncomeScreen(),
      },
    );
  }
}
