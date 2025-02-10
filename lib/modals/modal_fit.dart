import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ModalFit extends StatefulWidget {
  final VoidCallback toggleTheme;

  const ModalFit({super.key, required this.toggleTheme});

  @override
  _ModalFitState createState() => _ModalFitState();
}

class _ModalFitState extends State<ModalFit> {
  bool isDarkMode = false;

  void _toggleDarkMode() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
    widget.toggleTheme();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isDarkMode ? Colors.black : Colors.white,
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text(
                'Log out',
                style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
              ),
              leading: Icon(
                FontAwesomeIcons.arrowRightFromBracket,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
              onTap: () => Navigator.of(context).pop(),
            ),
            ListTile(
              title: Text(
                'Edit your profile',
                style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
              ),
              leading: Icon(
                FontAwesomeIcons.penToSquare,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
              onTap: () => Navigator.of(context).pop(),
            ),
            ListTile(
              title: Text(
                'Dark mode',
                style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
              ),
              leading: Icon(
                Icons.dark_mode,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
              onTap: _toggleDarkMode,
            ),
          ],
        ),
      ),
    );
  }
}
