import 'package:flutter/material.dart';

class CalenderView extends StatelessWidget {
  const CalenderView({super.key});

  @override
  Widget build(BuildContext context) {
    // get the theme
    final theme = Theme.of(context).colorScheme;
    return Center(
      child: Text('Coming soon',
          style: TextStyle(fontSize: 20, color: theme.onSurface)),
    );
  }
}
