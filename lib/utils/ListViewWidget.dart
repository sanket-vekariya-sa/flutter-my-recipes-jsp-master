import 'package:flutter/material.dart';

Widget listViewSteps(_instructionDetails) {
  final int a = _instructionDetails.length;
  return ListView.separated(
    primary: false,
    shrinkWrap: true,
    itemCount: a,
    itemBuilder: (context, index) {
      return ListTile(
        leading: CircleAvatar(
          child: Text(
            (index + 1).toString(),
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
          maxRadius: 12.0,
        ),
        title: Text(
          _instructionDetails[index].instruction,
        ),
      );
    },
    separatorBuilder: (context, index) {
      return Divider();
    },
  );
}


Widget listViewIndergents(_feedDetails) {
  return ListView.separated(
    primary: false,
    shrinkWrap: true,
    itemCount: _feedDetails.length,
    itemBuilder: (context, index) {
      return ListTile(
        leading: CircleAvatar(
          child: Text(
            (index + 1).toString(),
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
          maxRadius: 12.0,
        ),
        title: Text(_feedDetails[index].ingredient),
      );
    },
    separatorBuilder: (context, index) {
      return Divider();
    },
  );
}
