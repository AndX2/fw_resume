import 'package:flutter_web/material.dart';

import 'package:fw_resume/utils/screen_builder.dart';
import 'package:fw_resume/widget/bracket.dart';
import 'package:fw_resume/widget/pentagon.dart';

class BodyCaptionWidget extends StatelessWidget {
  const BodyCaptionWidget({
    Key key,
    @required this.params,
    @required this.name,
    @required this.iconData,
  }) : super(key: key);

  final ScreenParams params;
  final String name;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130.0 * params.scale,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Bracket(
              color: Colors.grey[400],
              width: 3.0 * params.scale,
              type: BracketType.left,
            ),
          ),
          Column(
            children: <Widget>[
              Container(
                height: 80.0 * params.scale,
                width: 80.0 * params.scale,
                child: Pentagon(
                    color: Colors.grey[400],
                    shadowColor: Colors.black,
                    elevation: 4.0 * params.scale,
                    borderWidth: 3.0 * params.scale,
                    radius: 30.0 * params.scale,
                    child: Center(
                        child: Icon(
                      iconData,
                      size: 50.0 * params.scale,
                    ))),
              ),
              Text(
                name,
                style: Theme.of(context)
                    .textTheme
                    .body2
                    .apply(fontSizeFactor: params.fontScale * params.scale),
              ),
            ],
          ),
          Expanded(
            flex: 1,
            child: Bracket(
              color: Colors.grey[400],
              width: 3.0 * params.scale,
              type: BracketType.rigth,
            ),
          ),
        ],
      ),
    );
  }
}
