import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  ReusableCard({
    this.selectedCurrency,
    this.cyptoCoin,
    this.showCypto,
  });
  final String cyptoCoin;
  final String selectedCurrency;
  final String showCypto;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightBlueAccent,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
        child: Text(
          '1 $showCypto = $cyptoCoin $selectedCurrency',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
