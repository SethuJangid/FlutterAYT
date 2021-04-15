import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      color: Colors.red,
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}