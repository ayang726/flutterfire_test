import 'package:flutter/material.dart';
import 'package:flutterfire_test/services/firebaseAuth.dart';

import 'options.dart';
import 'tags.dart';

class Poll extends StatefulWidget {
  @override
  _PollState createState() => _PollState();
}

class _PollState extends State<Poll> {
  final AuthService _auth = AuthService();
  var voted = false;

  // dummy values
  var date = '01.14.2020';
  List<String> tags = ['Budgeting', 'Saving'];
  var question = 'How much of your income do you put into your savings?';
  Map<String, BigInt> options = {'Less than 40%': BigInt.from(75),
                 'Between 40% - 80%': BigInt.from(150), 
                 'More than 80%': BigInt.from(75)};
  BigInt totalVoters = BigInt.from(300);

  void _handleOptionPressed(String option) {
    print('User voted for $option: ${options[option]}');
    options.update(option, (val) => val + BigInt.one);
    print('New value ${options[option]}');
    setState(() => { 
      voted = true,
      totalVoters = totalVoters + BigInt.one
    });
  }

  void _handleLogout() {
    print('Signing out');
    _auth.logout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Polls'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Log Out'),
            onPressed: _handleLogout,
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Daily Insights',
              style: TextStyle(color: Colors.blue, fontSize: 40),
            ),
            // date | tags            
            Row(
              children: <Widget>[
                Text(
                  date,
                  style: TextStyle(fontWeight: FontWeight.bold)
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  child: VerticalDivider(
                    color: Colors.black, 
                    thickness: 1,
                  ), 
                  height: 30
                ),
                // TODO: Figure out a better way to do these tags so they overflow nicely
                // also see tags.dart for this
                Tags(tags: this.tags),
              ],
            ),
            Divider(color: Colors.transparent),
            // question
            Text(
              question,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)
            ),
            Divider(color: Colors.transparent),
            // options
            Options(
              options: this.options, 
              voted: this.voted,
              totalVoters: totalVoters,
              onOptionPressed: _handleOptionPressed,
            ),
            if (!voted) Divider(color: Colors.transparent),
            if (voted) Text(
              'Thanks for participating!',
              style: TextStyle(fontWeight: FontWeight.bold)
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text('Curious about something?')
                ),
                Expanded(
                  child: FlatButton(
                    child: Text(
                      'Submit your own!', 
                      style: TextStyle(color: Colors.blue)
                    ),
                    // TODO: onPressed: route to poll question submission
                    onPressed: () => print('Question submitted')
                  )
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
