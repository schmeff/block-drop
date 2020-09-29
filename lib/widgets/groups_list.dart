import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/levels.dart';

import './group_item.dart';

class GroupsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> groups = Provider.of<Levels>(context, listen: false).groups;
    return MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: ListView.builder(
        itemCount: groups.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.all(8.0),
            child: GroupItem(groups[index]),
          );
        },
      ),
    );
  }
}
