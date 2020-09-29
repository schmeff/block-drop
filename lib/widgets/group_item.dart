import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/levels.dart';

import '../screens/level_select_screen.dart';

class GroupItem extends StatelessWidget {
  final String group;

  GroupItem(this.group);

  @override
  Widget build(BuildContext context) {
    int totalLevels = Provider.of<Levels>(context, listen: false)
        .getTotalLevelsLength(this.group);
    return InkWell(
      onTap: () {
        Provider.of<Levels>(context, listen: false).setCurrentGroup(this.group);
        Navigator.of(context).pushNamed(LevelSelectScreen.routeName);
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.1,
        padding: EdgeInsets.symmetric(vertical: 5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Color.fromRGBO(31, 31, 31, 1),
          border: Border.all(
            color: Theme.of(context).primaryColor,
            width: 3.0,
          ),
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
        child: Row(
          children: <Widget>[
            Flexible(
              child: FractionallySizedBox(
                widthFactor: 1,
              ),
            ),
            Flexible(
              child: FractionallySizedBox(
                widthFactor: 1,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.04,
                  child: FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${this.group}',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              child: FractionallySizedBox(
                widthFactor: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FutureBuilder(
                      future: Provider.of<Levels>(context)
                          .getCompletedLevelsStarCount(this.group),
                      builder: (ctx, starCount) => starCount.hasData
                          ? Container(
                              height: MediaQuery.of(context).size.height * 0.06,
                              child: FittedBox(
                                fit: BoxFit.fitHeight,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Color.fromRGBO(207, 255, 4, 1),
                                    ),
                                    Text(
                                      '${starCount.data.toString()}/${(totalLevels * 3).toString()}',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : SizedBox(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
