import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoey_flutter/providers/tasks_provider.dart';

class MainHeader extends ConsumerWidget {
  const MainHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, watch) {
    final state = watch(tasksProvider.state);
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
          'counter here ${state.counter}',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
