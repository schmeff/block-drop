import 'package:flutter/material.dart';

import '../widgets/groups_list.dart';

class GroupSelectScreen extends StatelessWidget {
  static const routeName = '/groupName';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.8,
            width: MediaQuery.of(context).size.width,
            child: GroupsList(),
          ),
        ],
      ),
    );
  }
}
