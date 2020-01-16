import 'package:flutter/material.dart';

import 'tag.dart';

class Tags extends StatelessWidget {
  Tags({
    this.tags
  });

  final List<String> tags;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: this.tags.map((String tag) {
        return Tag(
          tag: tag
        );
      }).toList()
    );
  }
}