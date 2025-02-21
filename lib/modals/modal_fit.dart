import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tp_final/theme/theme.dart';
import '../theme/theme_provider.dart';

class ModalFit extends StatefulWidget {
  const ModalFit({super.key});

  @override
  _ModalFitState createState() => _ModalFitState();
}

class _ModalFitState extends State<ModalFit> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Material(
      color: Theme.of(context).colorScheme.surface,
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
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
              leading: AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                transitionBuilder: (child, animation) => RotationTransition(
                  turns: Tween(begin: 0.75, end: 1.0).animate(animation),
                  child: child,
                ),
                child: Icon(
                  themeProvider.themeData == darkMode ? Icons.dark_mode : Icons.light_mode,
                  key: ValueKey<bool>(themeProvider.themeData == darkMode),
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              trailing: Switch.adaptive(
                value: themeProvider.themeData == darkMode,
                onChanged: (value) {
                  themeProvider.toggleTheme();
                },
                activeColor: Theme.of(context).colorScheme.secondary,
                inactiveThumbColor: Colors.white,
                inactiveTrackColor: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
