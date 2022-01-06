import 'package:anitcorona/Functions/TextFunction.dart';
import 'package:flutter/material.dart';

class ValidateTextCard extends StatelessWidget {
  final bool Function() validate;
  final String title;
  final IconData onFalse;
  final IconData onTrue;
  const ValidateTextCard(
      {Key? key,
      required this.validate,
      required this.title,
      this.onFalse = Icons.error,
      this.onTrue = Icons.done})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Icon(
            validate() ? onTrue : onFalse,
            color: validate() ? Colors.green : Colors.red,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              textScaleFactor: MyTextFunctions.getTheTextFactor(context),
              style: Theme.of(context)
                  .textTheme
                  .caption!
                  .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
