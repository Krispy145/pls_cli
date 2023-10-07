import 'package:flutter/material.dart';
import 'package:utilities/helpers/tuples.dart';

class MainBottomNavBar extends StatelessWidget {
  final List<Pair<IconData, void Function()>> iconButtons;
  const MainBottomNavBar({
    super.key,
    required this.iconButtons,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: iconButtons
            .map(
              (e) => IconButton(
                iconSize: 30,
                onPressed: e.second,
                icon: Icon(e.first),
              ),
            )
            .toList());
  }
}
