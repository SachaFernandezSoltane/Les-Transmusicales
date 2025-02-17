import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../theme/theme_provider.dart';

class ModalFit extends StatefulWidget {

  const ModalFit({super.key});

  @override
  _ModalFitState createState() => _ModalFitState();
}

class _ModalFitState extends State<ModalFit> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surface,
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text(
                'Log out',
                style: TextStyle(color: Theme.of(context).colorScheme.secondary),
              ),
              leading: Icon(
                FontAwesomeIcons.arrowRightFromBracket,
                color: Theme.of(context).colorScheme.secondary,
              ),
              onTap: () => Navigator.of(context).pop(),
            ),
            ListTile(
              title: Text(
                'Edit your profile',
                style: TextStyle(color: Theme.of(context).colorScheme.secondary),
              ),
              leading: Icon(
                FontAwesomeIcons.penToSquare,
                color: Theme.of(context).colorScheme.secondary,
              ),
              onTap: () => Navigator.of(context).pop(),
            ),
            ListTile(
              title: Text(
                'Dark mode',
                style: TextStyle(color: Theme.of(context).colorScheme.secondary),
              ),
              leading: Icon(
                Icons.dark_mode,
                color: Theme.of(context).colorScheme.secondary,
              ),
              onTap: () {
                Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
