import 'package:flutter_web/material.dart';

import 'package:fw_resume/utils/icons.dart' as icons;

class ExpectItemWidget extends StatelessWidget {
  ExpectItemWidget({
    @required this.item,
    Key key,
  }) : super(key: key);

  final Map<String, dynamic> item;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            item['title'],
            textAlign: TextAlign.left,
            maxLines: 3,
            style: Theme.of(context)
                .textTheme
                .caption
                .apply(color: Colors.grey[700]),
          ),
          Spacer(),
          Text(
            item['value'],
            textAlign: TextAlign.right,
            maxLines: 3,
            style: Theme.of(context)
                .textTheme
                .caption
                .apply(color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }
}
