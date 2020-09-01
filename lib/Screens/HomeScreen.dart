import 'package:ZavrsniProjekt/models/Apartman.dart';
import 'package:flutter/material.dart';

import '../widgets/HomeApartman.dart';
import '../providers/apartmani.dart';

import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Consumer<Apartmani>(
              builder:(ctx, apartmani, _) {
              List<Apartman> apartmans = apartmani.getApartmans();
              return  ListView.builder(
            padding: EdgeInsets.all(0),
            itemCount: apartmans.length,
            itemBuilder: (context, index) => HomeApartman(apartmans[index]));
              } 
      ),
    );
  }
}

