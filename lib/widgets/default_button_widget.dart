import 'package:flutter/material.dart';

import '../constants/constants.dart';

class DefaultButtonWidget extends StatelessWidget {
  const DefaultButtonWidget({
    Key? key,
    required this.onPressed,
    required this.title,
  }) : super(key: key);

  final Function() onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        child: Text(
          title,
          style: userStyle,
        ),
      ),
    );
  }
}
