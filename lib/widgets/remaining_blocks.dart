import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/grid.dart';

class RemainingBlocks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            height: 30,
            width: 30,
            margin: EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(2.0),
            ),
          ),
          Consumer<Grid>(
            builder: (context, grid, child) => Container(
              child: Text(
                "x ${grid.blockCount.toString()}",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
