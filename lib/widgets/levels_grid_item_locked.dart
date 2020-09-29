import 'package:flutter/material.dart';

class LevelsGridItemLocked extends StatelessWidget {
  final Map level;

  LevelsGridItemLocked(this.level);

  @override
  Widget build(BuildContext context) {
    final double containerWidth =
        (MediaQuery.of(context).size.width - 80.0) / 5;
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(31, 31, 31, 1),
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: [
          BoxShadow(
              color: Colors.black45,
              offset: Offset(
                0.0,
                5.0,
              ),
              blurRadius: 5.0),
        ],
      ),
      padding: const EdgeInsets.all(5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: containerWidth * 0.5,
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Icon(
                Icons.lock,
                size: 35,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
