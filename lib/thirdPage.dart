// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_foody/database/db_helper.dart';
import 'package:flutter_foody/entity/cart.dart';
import 'package:flutter_foody/firstPage.dart';
import 'package:flutter_foody/model/dataMakanan.dart';
import 'package:flutter_foody/secondPage.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'dao/cartDAO.dart';
import 'fourthPage.dart';

class ThirdPage extends StatefulWidget {
  final String foodName;
  final int price;
  final String image;
  // final DataMakanan dataMakanan;
  final String names;

  const ThirdPage(this.foodName, this.image, this.price, this.names, {Key? key})
      : super(key: key);

  set cart(Cart cart) {}

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  List<Map<String, dynamic>> allCart = [];
  String qty = "";
  int counter = 0;

  TextEditingController textInput = TextEditingController(text: '1');

  // TextEditingController textInput = TextEditingController();

  void incrementCounter() {
    setState(() {
      counter++;
    });
  }

  void decrementCounter() {
    setState(() {
      counter--;
    });
  }

  // late CartDAO dao;

  // _ThirdPageState() {
  //   for (int i = 0; i < 15; i++) {
  //     widgets.add(Text("Data " + i.toString()));
  //   }
  // widgets.add(Text("Data 1"));
  // widgets.add(Text("Data 2"));

  void refreshData() async {
    final data = await SQLHelper.getAllData();
    setState(() {
      allCart = data;
    });
  }

  @override
  void initState() {
    super.initState();
    refreshData();
  }

  void printTextFieldValue() {
    qty = textInput.text;
  }

  void handleTextFieldChange(String value) {
    setState(() {
      textInput.text = value;
      qty = value;
    });
  }

  Future<void> addData(String food, int price, int qty, String cashier) async {
    await SQLHelper.createData(food, price, qty, cashier);
    refreshData();
  }

  Future<void> updateData(
      int id, String food, int price, int qty, String cashier) async {
    await SQLHelper.updateData(id, food, price, qty, cashier);
    refreshData();
  }

  void deleteData(int id) async {
    await SQLHelper.deleteData(id);
    refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          title: const Text(
            'Foody',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          backgroundColor: const Color(0xffffb300),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              color: Colors.transparent,
              height: 150,
              width: 150,
              padding: EdgeInsets.all(4),
              child: Image.asset(
                // widget.dataMakanan.image,
                widget.image,
                fit: BoxFit.cover,
              ),
            ),
            // Text(widget.dataMakanan.nama),
            Text(widget.foodName),
            Row(
              children: [
                // Container(
                //   margin: const EdgeInsets.all(16),
                //   height: 56,
                //   width: 80,
                //   child: ElevatedButton(
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: const Color(0xffffb300),
                //     ),
                //     onPressed: () {
                //       decrementCounter();
                //       // Navigator.push(
                //       //     context,
                //       //     MaterialPageRoute(
                //       //         builder: (context) => SecondPage(name)));
                //     },
                //     child: const Text(
                //       "-",
                //       style: TextStyle(
                //         color: Colors.black,
                //       ),
                //     ),
                //   ),
                // ),
                Container(
                  width: 350,
                  margin: const EdgeInsets.all(16),
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: textInput,
                    onChanged: handleTextFieldChange,
                    keyboardType: TextInputType.number,
                    // onChanged: (String value) {
                    //   // qty = textInput.text;
                    //   qty = value;
                    // },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xffffb300)),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Color(0xffffb300))),
                      hintText: 'Quantity',
                    ),
                  ),
                ),
                // Container(
                //   margin: const EdgeInsets.all(16),
                //   height: 56,
                //   width: 80,
                //   child: ElevatedButton(
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: const Color(0xffffb300),
                //     ),
                //     onPressed: () {
                //       incrementCounter();
                //       // Navigator.push(
                //       //     context,
                //       //     MaterialPageRoute(
                //       //         builder: (context) => SecondPage(name)));
                //     },
                //     child: const Text(
                //       "+",
                //       style: TextStyle(
                //         color: Colors.black,
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
            Container(
              margin: const EdgeInsets.all(16),
              height: 56,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffffb300),
                ),
                onPressed: () async {
                  await addData(widget.foodName, widget.price,
                      int.parse(textInput.text), widget.names);

                  // await addData(
                  //     widget.dataMakanan.nama,
                  //     widget.dataMakanan.harga,
                  //     int.parse(textInput.text),
                  //     widget.names);
                  // widget.dataMakanan.harga, int.parse(qty), widget.names);

                  // widget.cart = Cart(1, widget.dataMakanan.nama,
                  //     widget.dataMakanan.harga, int.parse(qty), widget.names);

                  // await dao.insertCart(cart);

                  Navigator.pop(context);
                  // context,
                  // MaterialPageRoute(
                  //     builder: (context) =>
                  //         // FourthPage(widget.dataMakanan, qty, widget.names)
                  // SecondPage(widget.names)));
                  // setState(() {
                  //   widgets.add(Text(widget.dataMakanan.toString()));
                  //   widgets.add(Text(qty));
                  //   counter++;
                  // });
                  // FourthPage(widget.dataMakanan, qty, widget.names)));
                  // FourthPage(dataMakanan, qty, names)));
                  // showAlertDialog(context);
                },
                child: const Text(
                  "Add to Cart",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
