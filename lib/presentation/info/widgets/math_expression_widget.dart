import 'package:flutter/material.dart';

///
class MathExpressionWidget extends StatelessWidget {
  const MathExpressionWidget({super.key, required this.expression});
  final String expression;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.bodyMedium,
        children: [
          
        ],
      ),
    );
  }
}
