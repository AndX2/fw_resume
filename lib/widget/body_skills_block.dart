import 'package:flutter_web/material.dart';

import 'package:fw_resume/api/data.dart';
import 'package:fw_resume/utils/screen_builder.dart';
import 'package:fw_resume/widget/skill_vertical.dart';

class BodySkillsBlock extends StatelessWidget {
  const BodySkillsBlock({
    Key key,
    @required this.params,
  }) : super(key: key);

  final ScreenParams params;

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 30.0 * params.scale),
      height: 300.0 * params.scale,
      width: double.infinity,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 30.0 * params.scale),
        scrollDirection: Axis.horizontal,
        itemCount: skills.length,
        itemBuilder: (context, index) {
          return SkillVerticalWidget(
            params: params,
            skill: skills[index],
          );
        },
      ),
    );
  }
}
