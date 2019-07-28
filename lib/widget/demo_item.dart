import 'dart:html' as html;
import 'package:flutter_web/material.dart';

import 'package:fw_resume/utils/icons.dart' as icons;

class DemoItemWidget extends StatelessWidget {
  DemoItemWidget({
    @required this.item,
    Key key,
  }) : super(key: key);

  final Map<String, dynamic> item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        html.window.open(item['link'], item['linkName']);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(width: 32.0),
            Icon(
              icons.Icons.fromUnicode(item['icon']),
              color: Color(0xFF00569C),
              size: 40.0,
            ),
            SizedBox(width: 16.0),
            Text(
              item['value'],
              textAlign: TextAlign.left,
              maxLines: 3,
              style: Theme.of(context)
                  .textTheme
                  .caption
                  .apply(color: Colors.grey[700]),
            ),
            Spacer(),
            Icon(
              icons.Icons.link,
              color: Colors.grey[700],
              size: 30.0,
            ),
          ],
        ),
      ),
    );
  }
}
