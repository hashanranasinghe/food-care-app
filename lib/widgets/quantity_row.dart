import 'package:flutter/material.dart';

import 'buttons.dart';

class QuantityRow extends StatelessWidget {
  final List<String> quantities;
  final Function(int) function;
  const QuantityRow(
      {Key? key, required this.quantities, required this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: quantities.length,
        itemBuilder: (context, index) {
          final quantity = quantities[index];
          return ColorChangeButton(
            onpress: () {
              function(index);
            },
            text: quantity,
            ptop: 5,
            pbottom: 5,
            pleft: 25,
            pright: 25,
          );
        },
      ),
    );
  }
}
