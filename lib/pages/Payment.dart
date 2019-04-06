import 'package:flutter/material.dart';

class Payment extends StatefulWidget {
  final double total;
  Payment(this.total): super();
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment"),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Image.asset('assets/giphy.gif'),
            Text("Paid ${widget.total}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            Text("Payment received", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
          ],
        ),
      ),
    );
  }
}