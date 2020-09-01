import 'package:ZavrsniProjekt/models/Apartman.dart';
import 'package:flutter/material.dart';

import '../models/Apartman.dart';

class StatisticWidget extends StatelessWidget {
  final Apartman apartman;
  final String _occupation;

  

 const StatisticWidget(this.apartman, this._occupation);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.headline5.copyWith(color: Colors.white70);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Container(
        //height: double.infinity,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(24),
                    margin: EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      // boxShadow: [
                      //   BoxShadow(
                      //     blurRadius: 3,
                      //     spreadRadius: 4,
                      //     color: Colors.blue,
                      //   )
                      // ],
                      color: _occupation == "Slobodno" ? Colors.lightBlue[600] : Colors.redAccent[700],
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    child: Text(
                      _occupation,
                      style: theme.textTheme.headline4
                          .copyWith(color: Color.fromRGBO(255, 255, 225, 1)),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RowCell(
                  style: style,
                  leading: "Kapacitet:    ",
                  text: apartman.capacity.toString(),
                ),
                RowCell(
                    style: style,
                    leading: "Prosječni mjesečni:    ",
                    text: (apartman.totalIncome/ DateTime.now().month).toString()),
                RowCell(
                    style: style,
                    leading: "Prihod ovogodišnji:    ",
                    text: apartman.totalIncome.toString()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class RowCell extends StatelessWidget {
  const RowCell(
      {Key key,
      @required this.style,
      @required this.text,
      @required this.leading})
      : super(key: key);

  final TextStyle style;
  final String leading;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        color: Colors.blueGrey[600],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(
            leading,
            style: style,
          ),
          Text(
            text,
            style: style,
          ),
        ],
      ),
    );
  }
}
