import 'package:flutter/material.dart';

class ButtonWithIcon extends StatelessWidget {
  final Icon icon;
  final String label;
  final VoidCallback onPressed;
  final Color color;

  ButtonWithIcon({
    required this.icon,
    required this.label,
    required this.onPressed,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36.0),
      child: SizedBox(
        height: 50.0,
        width: double.infinity,
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            primary: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          icon: icon,
          label: Text(
            label,
            style: TextStyle(fontSize: 18.0),
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
