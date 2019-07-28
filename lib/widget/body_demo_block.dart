import 'dart:html' as html;
import 'package:flutter_web/material.dart';

import 'package:fw_resume/utils/screen_builder.dart';
import 'package:fw_resume/utils/icons.dart' as icons;
import 'package:fw_resume/api/data.dart';

class BodyDemoBlock extends StatelessWidget {
  const BodyDemoBlock({
    Key key,
    @required this.params,
  }) : super(key: key);

  final ScreenParams params;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      // scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      padding: EdgeInsets.only(
          left: 32.0 * params.scale, right: 32.0 * params.scale),
      itemCount: demo.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 32.0 * params.scale,
          crossAxisSpacing: 32.0 * params.scale,
          childAspectRatio: 3.5,
          crossAxisCount: 2),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () =>
              html.window.open(demo[index]['link'], demo[index]['linkName']),
          child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius:
                    BorderRadius.all(Radius.circular(4.0 * params.scale)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      offset: Offset(8.0 * params.scale, 8.0 * params.scale),
                      blurRadius: 5.0 * params.scale)
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(width: 32.0 * params.scale),
                  Icon(
                    icons.Icons.fromUnicode(demo[index]['icon']),
                    color: Colors.grey[700],
                    size: 40.0 * params.scale,
                  ),
                  SizedBox(width: 32.0 * params.scale),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        demo[index]['value'],
                        textAlign: TextAlign.left,
                        maxLines: 3,
                        style: Theme.of(context).textTheme.caption.apply(
                            color: Colors.grey[700],
                            fontSizeFactor: params.fontScale * params.scale),
                      ),
                    ],
                  ),
                ],
              )),
        );
      },
    );
  }
}
