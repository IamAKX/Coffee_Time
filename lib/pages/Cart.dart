import 'package:coffee_time/constants/CoffeeList.dart';
import 'package:coffee_time/pages/Payment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  final List<CoffeeList> cartItems;
  Cart(this.cartItems) : super();
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  double total = 0;
  BuildContext context;
  @override
  void initState() {
    super.initState();
    double sum = 0.0;
    for (CoffeeList item in widget.cartItems) {
      sum += (item.quantity * item.price);
    }
    total = sum;
  }

  void calculateTotal() {
    setState(() {
      double sum = 0.0;
      for (CoffeeList item in widget.cartItems) {
        sum += (item.quantity * item.price);
      }
      total = sum;
    });
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      backgroundColor: Color.fromRGBO(246, 246, 246, 10),
      appBar: AppBar(
        title: Text('Check-out'),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: CircleAvatar(
              radius: 15,
              backgroundColor: Colors.black,
              child: Text("${widget.cartItems.length}"),
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
              child: ListTile(
                title: Text("Net Amount"),
                subtitle: Text("Rs $total"),
              ),
            ),
            Expanded(
                child: MaterialButton(
              onPressed: () => {
                    Navigator.of(context).push(
                        CupertinoPageRoute(builder: (BuildContext context) {
                      return Payment(total);
                    }))
                  },
              child: Text(
                "PAY",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.black,
            ))
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: widget.cartItems.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ListTile(
                    title: Text(widget.cartItems[index].name),
                    subtitle: Text("Rs. ${widget.cartItems[index].price}"),
                    leading: FadeInImage.assetNetwork(
                      fit: BoxFit.fitWidth,
                      width: 80,
                      height: 80,
                      placeholder: 'assets/loading.gif',
                      image: widget.cartItems[index].image,
                    ),
                    trailing: Column(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.arrow_drop_up),
                          onPressed: () {
                            setState(() {
                              widget.cartItems[index].quantity++;
                              calculateTotal();
                            });
                          },
                        ),
                        Text("${widget.cartItems[index].quantity}"),
                        IconButton(
                          icon: Icon(Icons.arrow_drop_down),
                          onPressed: () {
                            setState(() {
                              widget.cartItems[index].quantity--;
                              if (widget.cartItems[index].quantity > 0)
                                calculateTotal();
                              else {
                                calculateTotal();
                                widget.cartItems[index].quantity = 1;
                                widget.cartItems.removeAt(index);
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
