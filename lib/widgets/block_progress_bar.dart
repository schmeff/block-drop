import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../providers/grid.dart';

class BlocksProgressBar extends StatefulWidget {
  @override
  _BlocksProgressBarState createState() => _BlocksProgressBarState();
}

class _BlocksProgressBarState extends State<BlocksProgressBar> {
  double percentage = 1.0;

  @override
  Widget build(BuildContext context) {
    int blockCount = Provider.of<Grid>(context).blockCount;
    Map<String, int> stars = Provider.of<Grid>(context, listen: false).stars;
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width *
                    .75 *
                    (1 / stars['three']),
              ),
              Icon(
                Icons.star,
                color: blockCount >= stars['one']
                    ? Color.fromRGBO(207, 255, 4, 1)
                    : Color.fromRGBO(31, 31, 31, 1),
              ),
              SizedBox(
                width: (MediaQuery.of(context).size.width *
                        .75 *
                        (1 / stars['three']) *
                        (stars['two'] - 1)) -
                    30,
              ),
              Icon(
                Icons.star,
                color: blockCount >= stars['two']
                    ? Color.fromRGBO(207, 255, 4, 1)
                    : Color.fromRGBO(31, 31, 31, 1),
              ),
              SizedBox(
                width: (MediaQuery.of(context).size.width *
                        .75 *
                        (1 / stars['three']) *
                        (stars['three'] - stars['two'])) -
                    45,
              ),
              Icon(
                Icons.star,
                color: blockCount >= stars['three']
                    ? Color.fromRGBO(207, 255, 4, 1)
                    : Color.fromRGBO(31, 31, 31, 1),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Consumer<Grid>(
                builder: (context, grid, child) {
                  return LinearPercentIndicator(
                    animation: true,
                    animateFromLastPercent: true,
                    backgroundColor: Color.fromRGBO(31, 31, 31, 1),
                    progressColor: Colors.teal,
                    percent: grid.blockPercentage,
                    lineHeight: 15,
                    width: MediaQuery.of(context).size.width * 0.75,
                  );
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
