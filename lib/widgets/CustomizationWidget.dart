import 'package:flutter/material.dart';

import './ButtonWidget.dart';
import '../models/Apartman.dart';
import '../providers/reservations.dart';
import '../Screens/AddIncomeScreen.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CustomizationWiget extends StatelessWidget {
  final Apartman _apartman;

  CustomizationWiget(this._apartman);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final _reservationsProvider = Provider.of<Reservations>(context);

    final _firstAvailableDate = _reservationsProvider.getFirstValidDate();

    return Container(
      padding: EdgeInsets.symmetric(vertical: 44),
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            padding: EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
                border: Border.all(
                  style: BorderStyle.solid,
                  color: Colors.grey[800],
                  width: 4,
                ),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.all(4),
                  child: Text(
                    "Prvi slobodni datum ",
                    style: theme.headline5.copyWith(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Text(
                  DateFormat("dd/MM/y").format(_firstAvailableDate),
                  style: theme.headline5
                      .copyWith(height: 1.3, fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ),
          ButtonWidget(
            theme: theme,
            text: Text(
              "IZMJENI PRIHOD",
              style: theme.headline5
                  .copyWith(color: Color.fromRGBO(255, 255, 255, 0.95)),
            ),
            onTap: () => Navigator.of(context)
                .pushNamed(AddIncomeScreen.routeName, arguments: _apartman.id),
          ),
          ButtonWidget(
            theme: theme,
            text: Text(
              "POMOĆ",
              style: theme.headline5
                  .copyWith(color: Color.fromRGBO(255, 255, 255, 0.95)),
            ),
            onTap: () async {
              await showDialog(
                context: context,
                child: Dialog(
                  //elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                  child: Container(
                      constraints: BoxConstraints(
                        maxHeight: 360,
                        minHeight: 360,
                        minWidth: 250,
                        maxWidth: 350,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(40)),
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              "Za brisanje rezervacija prstom kliznite rezervaciju u LIJEVU stranu, za potvrđivanje u DESNU stranu. Prihodi se nadodaju prilikom kreiranja nove rezervacije te zauzimanja datuma, dodatne prihode možete ručno dodati u \"IZMJENI PRIHOD\". Web stranica je obaviještena o zauzeću datuma. ",
                              style: theme.headline6.copyWith(fontSize: 17),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              "Za dodatne upite obratite se na email adresu istajcer@etfos.hr",
                              style: theme.headline6.copyWith(
                                  fontSize: 17, fontStyle: FontStyle.italic),
                            ),
                          ),
                          FlatButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text(
                              "Uredu",
                              style:
                                  theme.headline6.copyWith(color: Colors.blue),
                            ),
                          ),
                        ],
                      )),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
