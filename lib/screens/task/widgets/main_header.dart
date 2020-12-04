import 'package:flutter/material.dart';

class MainHeader extends StatelessWidget {
  const MainHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CircleAvatar(
          child: Icon(
            Icons.list,
            size: 30.0,
            color: Colors.lightBlueAccent,
          ),
          backgroundColor: Colors.white,
          radius: 30.0,
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          'Todoey',
          style: TextStyle(
            color: Colors.white,
            fontSize: 50.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          'counter here',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
