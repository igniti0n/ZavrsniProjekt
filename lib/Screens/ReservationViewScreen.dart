import 'package:ZavrsniProjekt/providers/reservations.dart';
import 'package:flutter/material.dart';

import '../models/Reservation.dart';
import '../providers/users.dart';
import '../providers/reservations.dart';
import '../providers/apartmani.dart';

import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ReservationViewScreen extends StatefulWidget {
  static final routeName = "/reservationViewScreen";

  @override
  _ReservationViewScreenState createState() => _ReservationViewScreenState();
}

class _ReservationViewScreenState extends State<ReservationViewScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Reservation> _reservationList =
        ModalRoute.of(context).settings.arguments as List<Reservation>;

    final _theme = Theme.of(context).textTheme;
    final _trailingStyle =
        _theme.headline6.copyWith(fontWeight: FontWeight.normal, fontSize: 16);

    return Scaffold(
      backgroundColor: Colors.lightBlue[400],
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: Stack(children: [
                Container(
                  //margin: EdgeInsets.symmetric(vertical: 55, horizontal: 15),
                  margin: EdgeInsets.fromLTRB(15, 55, 15, 20),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.lightBlue[800],
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      )),
                  child: ListView.builder(
                      itemCount: _reservationList.length,
                      padding: EdgeInsets.all(4),
                      itemBuilder: (context, index) {
                        String _userName =
                            _reservationList.elementAt(index).customIme;

                        if (_userName == "" || _userName == null) {
                          _userName = Provider.of<Users>(context)
                              .getUserNameById(
                                  _reservationList.elementAt(index).userID);
                        }

                        final bool _viewMode =
                            _reservationList.elementAt(index).approved;

                        return Dismissible(
                          key: Key(
                              _reservationList.elementAt(index).reservationId),
                          direction: _viewMode
                              ? DismissDirection.endToStart
                              : DismissDirection.horizontal,
                          background: ListTile(
                            leading: _viewMode
                                ? null
                                : Padding(
                                    padding: EdgeInsets.only(top: 22),
                                    child: Icon(
                                      Icons.publish,
                                      size: 44,
                                      color: Colors.green[300],
                                    ),
                                  ),
                            trailing: Padding(
                              padding: EdgeInsets.only(top: 22),
                              child: Icon(
                                Icons.delete,
                                size: 36,
                                color: Colors.red,
                              ),
                            ),
                          ),
                          confirmDismiss: (direction) {
                            return showDialog<bool>(
                              context: this.context,
                              builder: (ctx) => AlertDialog(
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                  title: Text(_viewMode
                                      ? "Pokušavate izbrisati rezervaciju! Time oslobođate rezervirane datume, želite li nastaviti?"
                                      : direction == DismissDirection.endToStart
                                          ? "Pokušavate izbrisati zahtjev za rezervaciju! Time PONIŠTAVATE poslani zahtjev, želite li nastaviti?"
                                          : "Pokrenuli ste postupak odobravanja zahtjeva za rezervaciju. Time zauzimate slobodne termine, želite li nastaviti?"),
                                  actions: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        FlatButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(true),
                                          child: direction ==
                                                  DismissDirection.endToStart
                                              ? Text(
                                                  "obriši",
                                                  style:
                                                      _trailingStyle.copyWith(
                                                          fontSize: 17,
                                                          color: Colors.red,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                )
                                              : Text(
                                                  "odobri",
                                                  style:
                                                      _trailingStyle.copyWith(
                                                          fontSize: 17,
                                                          color:
                                                              Colors.green[700],
                                                          fontWeight:
                                                              FontWeight.w600),
                                                ),
                                        ),
                                        FlatButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(false),
                                          child: Text(
                                            "ODUSTANI",
                                            style: _trailingStyle.copyWith(
                                                fontSize: 17,
                                                color: Colors.blue,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ]),
                            );
                          },
                          onDismissed: (direction) async {
                            final Reservation _currReservation =
                                _reservationList.elementAt(index);
                            if (direction == DismissDirection.endToStart) {
                              int _feedback = Provider.of<Reservations>(context,
                                      listen: false)
                                  .deleteReservation(
                                      _currReservation.reservationId);
                              print("BRIŠEM....");
                              if (_feedback != -1) {
                                Provider.of<Apartmani>(context, listen: false)
                                    .chargeApartman(_currReservation.apartmanId,
                                        -_currReservation.price);
                                setState(() {
                                  _reservationList.removeAt(index);
                                  print("feedback nije negativan....");
                                });
                              }
                            } else {
                              Provider.of<Reservations>(context, listen: false)
                                  .approveReservation(
                                      _currReservation.reservationId);
                              _reservationList.removeAt(index);
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.deepOrange[100],
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0.0, 3.0),
                                  color: Colors.blue[900],
                                  spreadRadius: 1,
                                )
                              ],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 2),
                            child: ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 4),
                              enabled: true,
                              onTap: () => {},
                              title: Text(
                                _userName,
                                style: _theme.headline6,
                              ),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    DateFormat.yMMMd().format(_reservationList
                                        .elementAt(index)
                                        .start),
                                    style: _trailingStyle,
                                  ),
                                  Text(
                                    DateFormat.yMMMd().format(
                                        _reservationList.elementAt(index).end),
                                    style: _trailingStyle,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                Positioned(
                  top: 30,
                  left: 85,
                  child: Container(
                    height: 33,
                    width: 240,
                    child: Text(
                      "REZERVACIJE",
                      style: _trailingStyle.copyWith(
                          fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.lightBlue[800],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.bottomCenter,
                  ),
                ),
              ]),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Spacer(
                    flex: 1,
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    iconSize: 50,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    color: Colors.indigo[800],
                  ),
                  Spacer(
                    flex: 5,
                  ),
                  // IconButton(
                  //   icon: Icon(Icons.add),
                  //   iconSize: 50,
                  //   color: Colors.indigo[800],
                  //   onPressed: () {},
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
