import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../modals/modal_fit.dart';

class ModalWidget extends StatelessWidget {
  final ValueNotifier<double> scaleNotifier;

  const ModalWidget({super.key, required this.scaleNotifier});

  void _openModal(BuildContext context) {
    scaleNotifier.value = 0.9;
    showCupertinoModalBottomSheet(
      expand: false,
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      builder: (context) => ModalFit(),
    ).then((_) {
      scaleNotifier.value = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(FontAwesomeIcons.circleUser, color: Theme.of(context).colorScheme.secondary, size: 25),
      onPressed: () => _openModal(context),
    );
  }
}
