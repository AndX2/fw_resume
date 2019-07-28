import 'package:flutter_web/material.dart';

import 'package:fw_resume/utils/screen_builder.dart';
import 'package:fw_resume/api/data.dart';
import 'package:fw_resume/utils/icons.dart' as icons;

class BodyExpectBlock extends StatelessWidget {
  const BodyExpectBlock({
    Key key,
    @required this.params,
  }) : super(key: key);

  final ScreenParams params;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: 32.0 * params.scale, right: 32.0 * params.scale),
      child: Wrap(
        spacing: 32.0 * params.scale,
        runSpacing: 32.0 * params.scale,
        children: <Widget>[
          ...offerExp.map((item) => Card(
              elevation: 8.0 * params.scale,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 400.0 * params.scale,
                    color: Colors.orange,
                    child: Row(
                      children: <Widget>[
                        SizedBox(width: 32.0 * params.scale),
                        Icon(
                          icons.Icons.fromUnicode(item['icon']),
                          color: Colors.grey[700],
                          size: 40.0 * params.scale,
                        ),
                        SizedBox(width: 32.0 * params.scale),
                        Text(
                          item['title'],
                          textAlign: TextAlign.left,
                          maxLines: 3,
                          style: Theme.of(context).textTheme.caption.apply(
                              color: Colors.grey[700],
                              fontSizeFactor: params.fontScale * params.scale),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 32.0 * params.scale),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(width: 32.0 * params.scale),
                      Text(
                        item['value'],
                        textAlign: TextAlign.left,
                        maxLines: 3,
                        style: Theme.of(context).textTheme.caption.apply(
                            color: Colors.grey[700],
                            fontSizeFactor: params.fontScale * params.scale),
                      ),
                    ],
                  ),
                  SizedBox(height: 32.0 * params.scale),
                ],
              ))),
        ],
      ),
    );
  }
}
