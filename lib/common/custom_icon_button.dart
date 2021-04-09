import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  CustomIconButton({this.iconData, this.color, this.size, this.onTap});
  final IconData iconData;
  final Color color;
  final num size;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Icon(
              iconData,
              color: onTap != null ? color : Colors.grey[400],
              size: size,
            ),
          ),
        ),
      ),
    );
  }
}