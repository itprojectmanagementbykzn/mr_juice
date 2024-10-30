import 'package:flutter/material.dart';
import 'package:learnease/main.dart';

import 'model.dart';

class DetailPage extends StatefulWidget {
  IceCream iceCream;
  String tagImage;

  DetailPage({required this.iceCream, required this.tagImage});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Hero(
              tag: widget.tagImage,
              child: Center(
                  child: Image.asset(
                    widget.iceCream.image,
                    height: size.height / 3,
                  ))),
          const SizedBox(
            height: 20,
          ),
          Text(
            widget.iceCream.name,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,
            color: kPrimaryColor),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            widget.iceCream.price,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 25,
            color: Colors.red),
          ),
          Padding(
            padding: const EdgeInsets.all(25),
            child: Text(
              widget.iceCream.desc,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
