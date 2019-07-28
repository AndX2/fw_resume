import 'dart:html' as html;
import 'package:flutter_web/material.dart';

class LinkWidget extends StatelessWidget {
  LinkWidget(
      {Key key,
      @required this.screenScale,
      @required this.text,
      this.url,
      this.fontSize = 24.0})
      : super(key: key);

  final double screenScale;
  final String text;
  final String url;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    // if (url == null) url = text;
    return InkWell(
      onTap: () => html.window.open(url ?? text, url ?? text),
      child: Text(
        text,
        style: TextStyle(
          decoration: TextDecoration.underline,
          color: Colors.blue[700],
          fontSize: fontSize * screenScale,
        ),
      ),
    );
  }
}
