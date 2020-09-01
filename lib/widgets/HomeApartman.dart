import 'package:flutter/material.dart';

import '../models/Apartman.dart';
import '../Screens/ApartmanScreen.dart';

//import 'package:google_fonts/google_fonts.dart';

class HomeApartman extends StatefulWidget {
  final Apartman apartman;

  HomeApartman(this.apartman);

  @override
  _HomeApartmanState createState() => _HomeApartmanState();
}

class _HomeApartmanState extends State<HomeApartman> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final double w = mediaQuery.size.width;
    final double h = mediaQuery.size.height;

    return Container(
      height: h / 3,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Hero(
              tag: widget.apartman.title,
              child: Image.asset(widget.apartman.image, fit: BoxFit.fill)),
          Container(
            color: Color.fromRGBO(60, 70, 40, 0.1),
          ),
          Positioned(
            bottom: 10,
            right: 6,
            left: 6,
            child: GestureDetector(
              onTapDown: (details) {
                Navigator.of(context).pushNamed(ApartmanScreen.routeName,
                    arguments: widget.apartman);
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 400),
                curve: Curves.easeIn,

                onEnd: () {
                  // change = false;
                },
                height: 60,
                //    constraints: BoxConstraints.loose(Size(400, 55)),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    color: Color.fromRGBO(0, 0, 0, 0.8),
                    //color: Color.fromRGBO(14, 79, 115, 0.8),
                    boxShadow: [
                      // BoxShadow(
                      //   color: Color.fromRGBO(34, 49, 235, 0.7),
                      //   blurRadius: 2,
                      //   spreadRadius: 4,
                      // ),
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      widget.apartman.title,
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
