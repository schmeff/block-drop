import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../providers/map.dart';

class BlocksProgressBar extends StatefulWidget {
  @override
  _BlocksProgressBarState createState() => _BlocksProgressBarState();
}

class _BlocksProgressBarState extends State<BlocksProgressBar> {
  double percentage = 1.0;

  @override
  Widget build(BuildContext context) {
    int blockCount = Provider.of<Map>(context).blockCount;
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width * .75 * 0.2,
              ),
              Icon(
                blockCount > 0 ? Icons.star : Icons.star_border,
                color: blockCount > 0
                    ? Color.fromRGBO(207, 255, 4, 1)
                    : Color.fromRGBO(31, 31, 31, 1),
              ),
              SizedBox(
                width: (MediaQuery.of(context).size.width * .75 * 0.4) - 30,
              ),
              Icon(
                blockCount > 2 ? Icons.star : Icons.star_border,
                color: blockCount > 2
                    ? Color.fromRGBO(207, 255, 4, 1)
                    : Color.fromRGBO(31, 31, 31, 1),
              ),
              SizedBox(
                width: (MediaQuery.of(context).size.width * .75 * 0.4) - 45,
              ),
              Icon(
                blockCount >= 5 ? Icons.star : Icons.star_border,
                color: blockCount >= 5
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
              Consumer<Map>(
                builder: (context, map, child) {
                  return LinearPercentIndicator(
                    animation: true,
                    animateFromLastPercent: true,
                    backgroundColor: Color.fromRGBO(31, 31, 31, 1),
                    progressColor: Colors.teal,
                    percent: map.blockPercentage,
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
