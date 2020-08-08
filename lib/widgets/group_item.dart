import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/levels.dart';

import '../screens/level_select_screen.dart';

class GroupItem extends StatelessWidget {
  final String group;

  GroupItem(this.group);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Provider.of<Levels>(context, listen: false).setCurrentGroup(this.group);
        Navigator.of(context).pushNamed(LevelSelectScreen.routeName);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.0),
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
        child: FractionallySizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                this.group,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
