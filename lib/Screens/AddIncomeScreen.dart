import 'package:flutter/material.dart';

import '../models/Apartman.dart';
import '../providers/apartmani.dart';

import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class AddIncomeScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  static final routeName = "/addIncomeScreen";

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _trailingStyle = _theme.textTheme.headline6
        .copyWith(fontWeight: FontWeight.normal, fontSize: 16);

    final String _apartmanId =
        ModalRoute.of(context).settings.arguments as String;

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
                    key: _formKey,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 50),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Iznos novog priljeva/odljeva novca",
                            overflow: TextOverflow.clip,
                            style: _theme.textTheme.headline6.copyWith(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: Colors.white),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 0),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 25),
                            width: 160,
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
                                padding: EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 10),
                                child: TextFormField(
                                  validator: (text) {
                                    double price = double.tryParse(text);
                                    if (price == null)
                                      return "Nevažeći unos cijene!";
                                    else
                                      return null;
                                  },
                                  onSaved: (text) {
                                    Provider.of<Apartmani>(context,
                                            listen: false)
                                        .chargeApartmanYear(
                                            _apartmanId, double.parse(text));
                                  },
                                  decoration: InputDecoration(
                                    hintText: "0.0",
                                  ),
                                  maxLines: 1,
                                  strutStyle: StrutStyle(height: 1),
                                  keyboardType: TextInputType.number,
                                  style: _theme.textTheme.headline6,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "Unešeni iznos novca biti će nadodan ukupnom godišnjem prihodu apartmana.",
                            overflow: TextOverflow.clip,
                            style: _theme.textTheme.headline6.copyWith(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: Colors.white),
                          ),
                          Spacer(flex: 1),
                          Text(
                            "Ako želite upisati odljev novca upišite negativni iznos. Omogućeno je da ukupno prihod bude negativan.",
                            overflow: TextOverflow.clip,
                            style: _theme.textTheme.headline6.copyWith(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: Colors.white),
                          ),
                          Spacer(flex: 10)
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
                      "DODAJ PRIHOD",
                      style: _theme.textTheme.headline5
                          .copyWith(fontWeight: FontWeight.bold, fontSize: 22),
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
                    onPressed: () async {
                      bool validated = _formKey.currentState.validate();
                      if (!validated) return;

                      final result = await showDialog<bool>(
                        context: context,
                        builder: (ctx) => AlertDialog(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            title: Text("Izmjenjujete prihod apartmana."),
                            actions: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  FlatButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(true),
                                    child: Text(
                                      "izmjeni",
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
                      );
                      if (result) {
                        _formKey.currentState.save();
                        Navigator.of(context).pop();
                      }
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
