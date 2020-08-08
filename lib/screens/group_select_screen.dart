import 'package:flutter/material.dart';

import '../widgets/groups_list.dart';

class GroupSelectScreen extends StatelessWidget {
  static const routeName = '/groupName';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Levels',
                style: TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.75,
            child: GroupsList(),
          ),
        ],
      ),
    );
  }
}
