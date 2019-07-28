import 'dart:html' as html;

import 'package:flutter_web/material.dart';

import 'package:fw_resume/utils/screen_builder.dart';
import 'package:fw_resume/utils/icons.dart' as icons;
import 'package:fw_resume/widget/body_caption.dart';
import 'package:fw_resume/widget/pentagon.dart';
import 'package:fw_resume/widget/body_about_block.dart';
import 'package:fw_resume/widget/body_skills_block.dart';
import 'package:fw_resume/widget/body_edu_block.dart';
import 'package:fw_resume/widget/body_achive_block.dart';
import 'package:fw_resume/widget/body_demo_block.dart';
import 'package:fw_resume/widget/body_expect_block.dart';
import 'package:fw_resume/widget/bar_painter.dart';



class MobilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final params = ScreenParams.of(context);
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('image/code_back.png'), fit: BoxFit.cover)),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: NestedScrollView(
            headerSliverBuilder: (context, scrolled) {
              return <Widget>[
                SliverPersistentHeader(
                  delegate: _SliverHeaderDelegate(
                      baseSize: params.baseSize, screenScale: params.scale),
                  pinned: true,
                )
              ];
            },
            body: SingleChildScrollView(
              child: Card(
                margin: EdgeInsets.symmetric(
                    horizontal: 30.0 * params.scale,
                    vertical: 30.0 * params.scale),
                color: Colors.grey[800].withOpacity(.85),
                elevation: 16.0 * params.scale,
                //TODO: blur not impl yet by flutter_web_ui/ui.dart
                // child: Padding(
                //   padding:
                //       const EdgeInsets.only(left: 12.0, bottom: 8.0, right: 12.0),
                //   child: BackdropFilter(
                //       filter: ui.ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                //       child: Text('Some text')),
                // ),
                child: Column(
                  children: <Widget>[
                    BodyCaptionWidget(
                      params: params,
                      name: 'about',
                      iconData: icons.Icons.bolt,
                    ),
                    BodyAboutBlock(params: params),
                    SizedBox(height: 30.0 * params.scale),
                    BodyCaptionWidget(
                      params: params,
                      name: 'skills',
                      iconData: icons.Icons.brief,
                    ),
                    BodySkillsBlock(params: params),
                    SizedBox(height: 30.0 * params.scale),
                    BodyCaptionWidget(
                      params: params,
                      name: 'education',
                      iconData: icons.Icons.book,
                    ),
                    BodyEduBlock(params: params),
                    SizedBox(height: 30.0 * params.scale),
                    BodyCaptionWidget(
                      params: params,
                      name: 'achivements',
                      iconData: icons.Icons.achive,
                    ),
                    BodyAchiveBlock(params: params),
                    SizedBox(height: 30.0 * params.scale),
                    BodyCaptionWidget(
                      params: params,
                      name: 'public demo',
                      iconData: icons.Icons.gitFork,
                    ),
                    BodyDemoBlock(params: params),
                    // ),
                    SizedBox(height: 30.0 * params.scale),
                    BodyCaptionWidget(
                      params: params,
                      name: 'expectations',
                      iconData: icons.Icons.handRight,
                    ),
                    BodyExpectBlock(params: params),
                    SizedBox(height: 30.0 * params.scale),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: IconButton(
            iconSize: 80.0 * params.scale * params.fontScale,
            icon: Icon(
              icons.Icons.telegram,
              color: Colors.blue[600],
            ),
            onPressed: () => html.window.open('https://t.me/AndX2', 'Telegram'),
          )),
    );
  }
}


class _SliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  final curveBarHeight = .25;
  final curveBarWidth = .25;
  final avatarLeftPadding = .1;
  final avatarWidth = .3;

  double _maxHeight;
  double _minHeight;
  final double baseSize;
  final double screenScale;
  _SliverHeaderDelegate({this.baseSize, this.screenScale}) {
    this._maxHeight = .5 * baseSize;
    this._minHeight = .1 * baseSize;
  }
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return LayoutBuilder(builder: (context, cons) {
      final params = ScreenParams.of(context);
      final shrinkScale =
          (cons.maxHeight - _minHeight) / ((_maxHeight - _minHeight));
      // print(cons.maxHeight * shrinkScale);
      return Stack(children: <Widget>[
        Positioned.fill(
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: CustomPaint(
                  painter: BarShadowPainter(
                      shrinkScale: shrinkScale,
                      color: Colors.black,
                      elevation: 8.0 * params.scale),
                ),
              ),
              ClipPath(
                clipper: BarClipper(shrinkScale: shrinkScale),
                child: Container(
                  color: Color(0xFF215796),
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        left: ((32.0 + 16.0) * params.scale + cons.maxHeight) *
                                (1 - shrinkScale) +
                            48.0 * shrinkScale * params.scale,
                        top: 4.0 * params.scale * (1 - shrinkScale),
                        bottom: cons.maxHeight * .4 * shrinkScale,
                        // right: (cons.maxWidth * (1.0 + avatarWidth)) / 2.0,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Spacer(flex: 5),
                            Text(
                              'Andrew',
                              style: Theme.of(context).textTheme.title.apply(
                                  fontSizeFactor:
                                      params.fontScale * params.scale),
                            ),
                            Spacer(flex: 5),
                            Text(
                              'dart',
                              style: Theme.of(context).textTheme.title.apply(
                                  fontSizeFactor:
                                      params.fontScale * params.scale),
                            ),
                            Spacer(flex: 5),
                            Text(
                              'developer',
                              style: Theme.of(context).textTheme.title.apply(
                                  fontSizeFactor:
                                      params.fontScale * params.scale),
                            ),
                            Spacer(flex: 5 + (100 * (1 - shrinkScale)).floor()),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned.fill(
          top: (cons.maxHeight - cons.maxWidth * avatarWidth) * shrinkScale,
          left: (cons.maxWidth * (1 - avatarWidth) / 2) * shrinkScale +
              (32.0 * params.scale) * (1 - shrinkScale),
          right: (cons.maxWidth * (1 - avatarWidth) / 2) * shrinkScale +
              (cons.maxWidth - 32.0 * params.scale - cons.maxHeight) *
                  (1 - shrinkScale),
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
      ]);
    });
  }

  @override
  double get maxExtent => _maxHeight;

  @override
  double get minExtent => _minHeight;

  @override
  bool shouldRebuild(_SliverHeaderDelegate oldDelegate) {
    return false;
  }
}

