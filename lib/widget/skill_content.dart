import 'package:flutter_web/material.dart';

import 'package:fw_resume/utils/screen_builder.dart';
import 'package:fw_resume/widget/skill_arc_painter.dart';


class SkillContentWidget extends StatelessWidget {
  const SkillContentWidget({
    Key key,
    @required this.params,
    @required this.context,
    @required this.skill,
  }) : super(key: key);

  final ScreenParams params;
  final BuildContext context;
  final Map<String, dynamic> skill;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Stack(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1.0,
                child: Padding(
                  padding: EdgeInsets.all(30.0 * params.scale),
                  child: Image.asset(
                    skill['image'],
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              AspectRatio(
                aspectRatio: 1.0,
                child: Padding(
                  padding: EdgeInsets.all(20.0 * params.scale),
                  child: CustomPaint(
                    painter: SkillArcPainter(
                        value: skill['rate'],
                        color: Color(int.parse(skill['color'])),
                        screenScale: params.scale),
                  ),
                ),
              )
            ],
          ),
        ),
        Text(
          skill['name'],
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.body1.apply(
              color: Colors.grey[700],
              fontSizeFactor: params.fontScale * params.scale),
        ),
        SizedBox(
          height: 16.0 * params.scale,
        )
      ],
    );
  }
}
