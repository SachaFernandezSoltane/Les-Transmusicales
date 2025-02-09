import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ModalFit extends StatelessWidget {
  const ModalFit({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
        child: SafeArea(
      top: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text('Log out'),
            leading: Icon(FontAwesomeIcons.arrowRightFromBracket),
            onTap: () => Navigator.of(context).pop(),
          ),
          ListTile(
            title: Text('Edit your profile'),
            leading: Icon(FontAwesomeIcons.penToSquare),
            onTap: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    ));
  }
}