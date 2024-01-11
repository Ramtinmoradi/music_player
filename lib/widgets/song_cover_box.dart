import 'package:flutter/material.dart';

class ContainerNeon extends StatelessWidget {
  final Widget child;
  const ContainerNeon({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
            offset: const Offset(4, 6),
            blurRadius: 4.0,
          ),
        ],
        color: Theme.of(context).colorScheme.onBackground,
        borderRadius: const BorderRadius.all(
          Radius.circular(16.0),
        ),
      ),
      child: child,
    );
  }
}
