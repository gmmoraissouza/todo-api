import 'package:flutter/material.dart';
import 'package:todo_api/constants/constants.dart';

class IconEditDataWidget extends StatelessWidget {
  const IconEditDataWidget({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Ink(
        height: 200.0,
        child: InkWell(
          onTap: onTap,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Center(
                child: Column(
                  children: [
                    Icon(
                      icon,
                      size: 100,
                      color: primaryColor,
                    ),
                    Text(
                      title,
                      style: editStyle,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
