import 'package:ZavrsniProjekt/widgets/CustomizationWidget.dart';
import 'package:flutter/material.dart';

import '../models/Apartman.dart';
import '../models/Reservation.dart';
import '../widgets/reservationsApartmanWidget.dart';
import '../widgets/statisticWidget.dart';
import '../providers/apartmani.dart';
import '../providers/reservations.dart';

import 'package:provider/provider.dart';

class ApartmanScreen extends StatelessWidget {
  static final routeName = "/apartmanRote";

  bool _validateDate(DateTime begin, DateTime end, DateTime picked) {
    if (picked.year <= end.year &&
        picked.month <= end.month &&
        picked.day <= end.day) if (begin.day <= picked.day) return false;
    return true;
  }

   bool _validatePickedDateAllReservations(DateTime begin, List<Reservation> list) {
      bool valid = true;
      list.forEach((element) {
        if (!(_validateDate(element.start, element.end, begin))) valid = false;
      });
      return valid;
    }

  @override
  Widget build(BuildContext context) {
    final Apartman _apartman = ModalRoute.of(context).settings.arguments;
    final query = MediaQuery.of(context);
    final theme = Theme.of(context);
    // final List<Reservation> _list = Provider.of<Reservations>(context)
    //     .getReservationsByApartmanApproved(_apartman.id);

    final List<Reservation> _listNotApproved =
        Provider.of<Reservations>(context, listen: true)
            .getReservationsByApartmanNotApproved(_apartman.id);
    final List<Reservation> _listApproved = Provider.of<Reservations>(context, listen: true)
        .getReservationsByApartmanApproved(_apartman.id);
      String _occupation = "Slobodno";
     if(!_validatePickedDateAllReservations(DateTime.now(), _listApproved))
          _occupation ="Zauzeto";
    // {
    //    Provider.of<Apartmani>(context, listen: false).occupieApartman(_apartman.id);
    // }else{
    //    Provider.of<Apartmani>(context, listen: false).freeApartman(_apartman.id);
    // }
       
   
    // final appBar = AppBar(
    //   centerTitle: true,
    //   primary: true,
    //   elevation: 10,
    //   toolbarOpacity: 0.5,
    //   //  leading: Icon(Icons.arrow_back_ios),
    //   backgroundColor: theme.primaryColor,
    //   title: Text(
    //     apartman.title,
    //     overflow: TextOverflow.fade,
    //     textAlign: TextAlign.center,
    //     style: theme.textTheme.headline4
    //         .copyWith(color: Color.fromRGBO(255, 255, 255, 0.9)),
    //   ),
    // );
    double h = query.size.height - query.padding.bottom - query.padding.top;
    double w = query.size.width;

    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: Colors.white,
        // appBar: appBar,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: h * 0.31,
              width: double.infinity,
              child: Stack(
                fit: StackFit.loose,
                children: [
                  Hero(
                    tag: _apartman.title,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Image.asset(
                        _apartman.image,
                        fit: BoxFit.fill,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 20,
                    left: 15,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: 40,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: h * 0.08,
              child: TabBar(
                indicatorColor: theme.primaryColor,
                unselectedLabelColor: Colors.grey,
                labelColor: theme.primaryColor,
                tabs: [
                  Tab(
                    icon: Icon(
                      Icons.assessment,
                    ),
                  ),
                  Tab(
                    iconMargin: EdgeInsets.all(0),
                    icon: Icon(
                      Icons.assignment,
                    ),
                  ),
                  Tab(
                    icon: Icon(Icons.store),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                // height: h * 0.55,
                padding: EdgeInsets.all(10),
                child: TabBarView(
                  children: [
                    SingleChildScrollView(
                      child: StatisticWidget(_apartman, _occupation),
                    ),
                    ReservationsApartmanWidget(
                        _apartman, _listApproved, _listNotApproved),
                   CustomizationWiget(_apartman),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
