import 'package:flutter/material.dart';

import './ButtonWidget.dart';
import '../Screens/ReservationViewScreen.dart';
import '../Screens/CreateReservationScreen.dart';
import '../models/Apartman.dart';
import '../models/Reservation.dart';

// import '../providers/Reservations.dart';

// import 'package:provider/provider.dart';

class ReservationsApartmanWidget extends StatelessWidget {
  final Apartman apartman;
  final List<Reservation> _listApproved;
  final List<Reservation> _listNotApproved;

  ReservationsApartmanWidget(
      this.apartman, this._listApproved, this._listNotApproved);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 34),
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          ButtonWidget(
            theme: theme,
            text: Text(
              "REZERVACIJE",
              style: theme.headline5.copyWith(color:  Color.fromRGBO(255, 255, 255, 0.95)),
            ),
            onTap: () => Navigator.of(context).pushNamed(
                ReservationViewScreen.routeName,
                arguments: _listApproved),
          ),
          ButtonWidget(
            theme: theme,
            text: _listNotApproved.length == 0 ? Text(
              "ZAHTJEVI",
              style: theme.headline5.copyWith(color: Color.fromRGBO(255, 255, 255, 0.95)),
            ) : Text(
              "!   ZAHTJEVI   !",
              style: theme.headline5.copyWith(color:
               //Color.fromRGBO(255, 255, 0, 0.99)
               Color.fromRGBO(100, 0, 0, 1)
               ),
            ) ,
            onTap: () => Navigator.of(context).pushNamed(
                ReservationViewScreen.routeName,
                arguments: _listNotApproved),
          ),
          ButtonWidget(
            theme: theme,
            text: Text(
              "KREIRANJE",
              style: theme.headline5.copyWith(color:  Color.fromRGBO(255, 255, 255, 0.95)),
            ),
            onTap: () => Navigator.of(context).pushNamed(
                CreateReservationScreen.routeName,
                arguments: apartman.id),
          ),
        ],
      ),
    );
  }
}

