import 'package:ZavrsniProjekt/providers/apartmani.dart';
import 'package:flutter/material.dart';

import 'package:ZavrsniProjekt/models/Reservation.dart';
import '../providers/reservations.dart';
import '../providers/users.dart';

import 'package:date_range_picker/date_range_picker.dart' as RangePicker;
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class CreateReservationScreen extends StatefulWidget {
  const CreateReservationScreen({Key key}) : super(key: key);
  static final routeName = "/createReservationScreen";

  @override
  _CreateReservationScreenState createState() =>
      _CreateReservationScreenState();
}

class _CreateReservationScreenState extends State<CreateReservationScreen> {
  var _fromKey = new GlobalKey<FormState>();
  final _moneyFocusNode = new FocusNode();
  DateTime _beginDate = DateTime.now();
  DateTime _endDate = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _moneyFocusNode.dispose();
    super.dispose();
  }

  void printReservations(List<Reservation> reservations) {
    reservations.forEach((element) {
      print(element.start.toString() + "- " + element.end.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    final _apartmanId = ModalRoute.of(context).settings.arguments as String;
    final _reservationsProvider = Provider.of<Reservations>(context);
    final theme = Theme.of(context);
    final _theme = Theme.of(context).textTheme;
    final _trailingStyle =
        _theme.headline6.copyWith(fontWeight: FontWeight.normal, fontSize: 16);
    final List<Reservation> _reservations =
        _reservationsProvider.getReservationsByApartmanApproved(_apartmanId);

    Reservation _newReservation = new Reservation(
        apartmanId: _apartmanId,
        reservationId: new UniqueKey().toString(),
        end: _endDate,
        start: _beginDate,
        approved: true,
        userID: null);

    void _saveForm() {
      _reservationsProvider.addReservation(_newReservation);

      Navigator.of(context).pop();
    }

    DateTime _firstAvailableDate = _reservationsProvider.getFirstValidDate();
    _beginDate = _firstAvailableDate;
    _endDate = _firstAvailableDate;

    return Container(
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
      color: Colors.lightBlue[400],
      child: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: Stack(children: [
                Container(
                  //margin: EdgeInsets.symmetric(vertical: 55, horizontal: 15),
                  margin: EdgeInsets.fromLTRB(15, 55, 15, 0),
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.lightBlue[800],
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      )),

                  child: Form(
                    key: _fromKey,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 6, vertical: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 5),
                            padding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 2),
                            // decoration: BoxDecoration(
                            //   borderRadius:
                            //       BorderRadius.all(Radius.circular(12)),
                            //   color: Colors.grey[300],
                            // ),
                            child: Card(
                              color: Colors.grey[300],
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              child: Padding(
                                  padding: EdgeInsets.all(6),
                                  child: Row(
                                    children: <Widget>[
                                      SizedBox(
                                        width: 50,
                                      ),
                                      Expanded(
                                        child: TextFormField(
                                          validator: (text) {
                                            if (text == null || text == "") {
                                              return "Polje prazno";
                                            } else {
                                              return null;
                                            }
                                          },
                                          onSaved: (text) {
                                            _newReservation.customIme = text;
                                          },
                                          textInputAction: TextInputAction.next,
                                          onFieldSubmitted: (_) =>
                                              FocusScope.of(context)
                                                  .requestFocus(
                                                      _moneyFocusNode),
                                          decoration: InputDecoration(
                                            hintText: "Ime i prezime kupca",
                                          ),
                                          style: theme.textTheme.headline6,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 50,
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(0, 10, 10, 10),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 14),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                    color: Colors.grey[300],
                                  ),
                                  child: Text(
                                    "Ukupna cijena u kunama: ",
                                    style: theme.textTheme.headline6
                                        .copyWith(fontSize: 16),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 0),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 0),
                                width: 100,
                                // decoration: BoxDecoration(
                                //   borderRadius:
                                //       BorderRadius.all(Radius.circular(12)),
                                //   color: Colors.grey[300],
                                // ),
                                child: Card(
                                  color: Colors.grey[300],
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 10),
                                    child: TextFormField(
                                      validator: (text) {
                                        double price = double.tryParse(text);
                                        if (price == null || price < 0)
                                          return "Nevažeći unos cijene!";
                                        else
                                          return null;
                                      },
                                      onSaved: (text) {
                                        final double _price =
                                            double.parse(text);
                                        Provider.of<Apartmani>(context,
                                                listen: false)
                                            .chargeApartman(
                                                _apartmanId, _price);
                                        _newReservation.price = _price;
                                      },
                                      focusNode: _moneyFocusNode,
                                      initialValue: "0",
                                      keyboardType: TextInputType.number,
                                      style: theme.textTheme.headline6,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 14),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  color: Colors.grey[300],
                                ),
                                child: Text(
                                  "Početni datum:  ${DateFormat.yMMMd().format(_beginDate)}",
                                  style: theme.textTheme.headline6.copyWith(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800),
                                ),
                              ),
                              FlatButton(
                                  padding: EdgeInsets.all(10),
                                  onPressed: () async {
                                    final List<DateTime> _pickedDates =
                                        await RangePicker.showDatePicker(
                                            context: context,
                                            initialFirstDate:
                                                _firstAvailableDate,
                                            initialLastDate:
                                                _firstAvailableDate,
                                            firstDate: DateTime.now()
                                                .subtract(Duration(days: 1)),
                                            lastDate: DateTime(2021),
                                            selectableDayPredicate: (picked) {
                                              return _reservationsProvider
                                                  .validatePickedDateAllReservations(
                                                      picked);
                                            });

                                    if (!_reservationsProvider
                                        .validatePickedDateRange(
                                            _pickedDates[0], _pickedDates[1])) {
                                      await showDialog(
                                          context: context,
                                          child: AlertDialog(
                                            title: Text(
                                                "Izabrano razdoblje sadržava već zauzete datume!"),
                                            actions: <Widget>[
                                              FlatButton(
                                                onPressed: () =>
                                                    Navigator.of(context).pop(),
                                                child: Text("Uredu"),
                                              )
                                            ],
                                          ));
                                    } else {
                                      setState(() {
                                        _beginDate = _pickedDates[0];
                                        _endDate = _pickedDates[1];
                                      });
                                    }
                                  },
                                  color: Colors.indigo[800],
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: Text(
                                    "Odabir",
                                    style: theme.textTheme.headline6
                                        .copyWith(color: Colors.white70),
                                  ))
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  color: Colors.grey[300],
                                ),
                                child: Text(
                                  "Završni datum:  ${DateFormat.yMMMd().format(_endDate)}",
                                  overflow: TextOverflow.clip,
                                  style: theme.textTheme.headline6.copyWith(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 30,
                  left: 85,
                  child: Container(
                    height: 33,
                    width: 240,
                    child: Text(
                      "NOVA REZERVACIJA",
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
              padding: EdgeInsets.fromLTRB(10, 20, 10, 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FlatButton(
                    child: Icon(
                      Icons.arrow_back,
                      size: 50,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    //color: Colors.indigo[800],
                  ),
                  FlatButton(
                    child: Icon(
                      Icons.save,
                      size: 50,
                    ),
                    // color: Colors.indigo[800],
                    onPressed: () {
                      bool validated = _fromKey.currentState.validate();
                      if (!validated) return;
                      _fromKey.currentState.save();
                      final result = showDialog<bool>(
                        context: this.context,
                        builder: (ctx) => AlertDialog(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            title: Text(
                                "Nadodaj novu rezervaciju? Time zauzimate slobodne datume."),
                            actions: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  FlatButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(true),
                                    child: Text(
                                      "napravi",
                                      style: _trailingStyle.copyWith(
                                          fontSize: 17,
                                          color: Colors.green[700],
                                          fontWeight: FontWeight.w600),
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
                      ).then((value) => {
                            if (value == true) {_saveForm()}
                          });
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
