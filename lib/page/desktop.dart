import 'dart:html' as html;
import 'package:flutter_web/material.dart';

import 'package:fw_resume/utils/screen_builder.dart';
import 'package:fw_resume/utils/icons.dart' as icons;
import 'package:fw_resume/api/data.dart';
import 'package:fw_resume/widget/side_bar.dart';
import 'package:fw_resume/widget/pentagon.dart';
import 'package:fw_resume/widget/body_about_block.dart';
import 'package:fw_resume/widget/main_column_block.dart';
import 'package:fw_resume/widget/skill_content.dart';
import 'package:fw_resume/widget/education_item.dart';
import 'package:fw_resume/widget/achivement_item.dart';
import 'package:fw_resume/widget/demo_item.dart';
import 'package:fw_resume/widget/expect_item.dart';

class DesktopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final params = ScreenParams.of(context);
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Card(
        elevation: 4.0,
        color: Colors.grey[800].withOpacity(0.9),
        child: Stack(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 320.0,
                  height: 1400.0,
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(child: SideBar()),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox(height: 50.0),
                          Container(
                            // padding: EdgeInsets.only(left: 10.0),
                            width: 285.0,
                            height: 285.0,
                            child: Pentagon(
                              color: Colors.deepOrange,
                              shadowColor: Colors.black,
                              elevation: 4.0 * params.scale,
                              borderWidth: 3.0 * params.scale,
                              radius: 50.0 * params.scale,
                              child: Image.asset(
                                'image/face_.jpg',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          SizedBox(height: 50.0),
                          BodyAboutBlock(params: params),
                          SizedBox(height: 50.0),
                          IconButton(
                            iconSize: 60.0,
                            icon: Icon(
                              icons.Icons.telegram,
                              color: Colors.grey[300],
                            ),
                            onPressed: () => html.window
                                .open('https://t.me/AndX2', 'Telegram'),
                          ),
                          Text(
                            '@AndX2',
                            style: Theme.of(context).textTheme.body2,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                RotatedBox(
                  quarterTurns: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 150.0),
                    child: Text(
                      'Dart developer'.toUpperCase(),
                      style: Theme.of(context)
                          .textTheme
                          .title
                          .copyWith(fontSize: 70.0),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 250.0),
                      MainColumnBlockWidget(
                        headerImageLink: 'image/skills.png',
                        header: 'Skills',
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: List.generate(skills.length, (index) {
                            return Container(
                              width: 130.0,
                              child: AspectRatio(
                                aspectRatio: .8,
                                child: SkillContentWidget(
                                  context: context,
                                  params: params,
                                  skill: skills[index],
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      MainColumnBlockWidget(
                        headerImageLink: 'image/education.png',
                        header: 'Education',
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 16.0, top: 16.0, right: 32.0, bottom: 16.0),
                          child: Column(
                              children: educations.map((item) {
                            return EducationItemWidget(item: item);
                          }).toList()),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      MainColumnBlockWidget(
                        headerImageLink: 'image/achivement.png',
                        header: 'Achivements',
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 16.0, top: 16.0, right: 32.0, bottom: 16.0),
                          child: Column(
                              children: achive.map((item) {
                            return AchivementItemWidget(item: item);
                          }).toList()),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      MainColumnBlockWidget(
                        headerImageLink: 'image/demo.png',
                        header: 'Public demo',
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 16.0, top: 16.0, right: 32.0, bottom: 16.0),
                          child: Column(
                              children: demo.map((item) {
                            return Column(
                              children: <Widget>[
                                DemoItemWidget(item: item),
                                (demo.last != item) ? Divider() : Container(),
                              ],
                            );
                          }).toList()),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      MainColumnBlockWidget(
                        headerImageLink: 'image/expect.png',
                        header: 'Expectations',
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 16.0, top: 16.0, right: 32.0, bottom: 16.0),
                          child: Column(
                              children: offerExp.map((item) {
                            return Column(
                              children: <Widget>[
                                ExpectItemWidget(item: item),
                                (offerExp.last != item)
                                    ? Divider()
                                    : Container(),
                              ],
                            );
                          }).toList()),
                        ),
                      ),
                      SizedBox(height: 40.0),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
