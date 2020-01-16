import 'dart:collection';

class Poll {
  final DateTime dateTime; // date of poll
  final List<String> tags; // topic tags for question
  final String question; // question
  final SplayTreeMap<String, BigInt> answers; // answer -> # of users that selected that answer

  Poll({this.dateTime, this.tags, this.question, this.answers});
}
