import 'package:flutter/material.dart';
import 'package:flutterfire_test/screens/polls/optionWithVoters.dart';
import 'package:flutterfire_test/screens/polls/optionWithoutVoters.dart';

typedef void OptionPressedCallback(String option);

class Options extends StatelessWidget {
  Options({this.options, this.voted, this.totalVoters, this.onOptionPressed});

  final Map<String, BigInt> options;
  final bool voted;
  final BigInt totalVoters;
  final OptionPressedCallback onOptionPressed;

  @override
  Widget build(BuildContext context) {
    return voted ? 
    Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: options.keys.map((String option) {
        return OptionWithVoters(option: option, voters: options[option], voterPercent: options[option] / totalVoters);
      }).toList(),
    )
    : Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: options.keys.map((String option) {
        // return option render
        // TODO: make different option renders depending on whether user voted or not
        return OptionWithoutVoters(option: option, onOptionPressed: (option) => onOptionPressed(option));
      }).toList(),
    );
  }
}