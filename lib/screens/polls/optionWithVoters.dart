import 'package:flutter/material.dart';

class OptionWithVoters extends StatelessWidget {
  OptionWithVoters({
    this.option,
    this.voters,
    this.voterPercent
  });

  final String option;
  final BigInt voters;
  final double voterPercent;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget> [
                Text(
                  option,
                  style: TextStyle(fontSize: 18)
                ),
                Text(
                  '${(voterPercent * 100).toStringAsFixed(2)}%',
                  style: TextStyle(fontSize: 18, color: Colors.black54)
                )
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 3),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.cyan[300],
                  width: 1
                )
              ),
              child: LinearProgressIndicator(
                value: voterPercent,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.cyan[300]),
                backgroundColor: Colors.white,
              )
            ),
            Text(
              '$voters Voters',
              style: TextStyle(fontSize: 12, color: Colors.black54)
            )
          ],
        )
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.blue)
      ),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      height: 90,
    );
  }
}