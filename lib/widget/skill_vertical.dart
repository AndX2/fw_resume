import 'package:flutter_web/material.dart';

import 'package:fw_resume/utils/screen_builder.dart';
import 'package:fw_resume/widget/skill_content.dart';


class SkillVerticalWidget extends StatelessWidget {
  const SkillVerticalWidget({
    Key key,
    @required this.params,
    @required this.skill,
  }) : super(key: key);

  final ScreenParams params;
  final Map<String, dynamic> skill;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10.0 * params.scale),
        child: AspectRatio(
          aspectRatio: 0.7,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0 * params.scale),
                  bottomRight: Radius.circular(40.0 * params.scale)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26,
                    offset: Offset(8.0 * params.scale, 8.0 * params.scale),
                    blurRadius: 5.0 * params.scale)
              ],
            ),
            child: SkillContentWidget(
                params: params, context: context, skill: skill),
          ),
        ));
  }
}
