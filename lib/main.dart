import 'dart:html' as html;
import 'dart:math';

import 'package:flutter_web/material.dart';
import 'package:flutter_web/painting.dart';
import 'package:flutter_web/widgets.dart';
// import 'package:flutter_web_ui/ui.dart' as ui;
import 'dart:html';

import 'package:fw_resume/data.dart';
import 'package:fw_resume/widget/pentagon.dart';
import 'package:fw_resume/widget/side_bar.dart';
// import 'package:fw_resume/widget/pentagon_outline.dart';
import './data.dart';

import 'icons.dart' as icons;
import 'widget/bracket.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Andrew: flutter dev',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        // fontFamily: 'gs',

        textTheme: TextTheme(
          title: TextStyle(
              fontFamily: 'ss', fontSize: 36.0, color: Colors.grey[300]),
          body1: TextStyle(
              fontFamily: 'roboto', fontSize: 18.0, color: Colors.grey[300]),
          body2: TextStyle(
              fontFamily: 'ss', fontSize: 24.0, color: Colors.grey[300]),
          button: TextStyle(
              fontFamily: 'ss', fontSize: 28.0, color: Colors.grey[300]),
          subtitle: TextStyle(
              fontFamily: 'ss', fontSize: 26.0, color: Colors.grey[300]),
          caption: TextStyle(
              fontFamily: 'roboto', fontSize: 14.0, color: Colors.grey[300]),
        ),
      ),
      routes: {
        // '/': (BuildContext context) => WidthWidget(),
        '/': (BuildContext context) => ScreenBuilder(),
        'empty': (BuildContext context) => EmptyPage(),
      },
      // onGenerateRoute: (settings) {
      //   return MaterialPageRoute(builder: (context) => EmptyPage());
      // },

      // home: WidthWidget()
      // MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class ScreenBuilder extends StatelessWidget {
  static const double SMALL_WIDTH = 768.0;
  static const double HUGE_WIDTH = 1024.0;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    // print('PixelRatio: ${mediaQuery.devicePixelRatio}');
    final baseSize = (mediaQuery.size.width > HUGE_WIDTH)
        ? HUGE_WIDTH
        : mediaQuery.size.width;
    final minSize = (mediaQuery.size.width > mediaQuery.size.height)
        ? mediaQuery.size.height
        : mediaQuery.size.width;
    final scale = baseSize / HUGE_WIDTH;
    final fontScale = (baseSize <= SMALL_WIDTH) ? 1.5 : 1.2;
    final orientation = mediaQuery.orientation;
    // html.window.console.log(mediaQuery);

    return ScreenParams(
      baseSize: baseSize,
      scale: scale,
      fontScale: fontScale,
      child: (mediaQuery.size.width > HUGE_WIDTH && minSize >= 600.0)
          ? _buildDesk(padding: (mediaQuery.size.width - HUGE_WIDTH) / 2)
          : (minSize >= 768.0)
              ? _buildTablet()
              : (orientation == Orientation.portrait)
                  ? _buildPhonePort()
                  : _buildPhoneLand(),
    );
  }

  Widget _buildPhonePort() {
    return MobilePage();
  }

  Widget _buildPhoneLand() {
    return MobilePage();
  }

  Widget _buildTablet() {
    return MobilePage();
  }

  Widget _buildDesk({double padding}) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: Image.asset(
            'image/code_back.png',
            fit: BoxFit.cover,
          ),
        ),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: padding),
            child: DesktopPage()),
      ],
    );
  }
}

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

class BodyAchiveBlock extends StatelessWidget {
  const BodyAchiveBlock({
    Key key,
    @required this.params,
  }) : super(key: key);

  final ScreenParams params;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0 * params.scale,
      width: double.infinity,
      child: PageView.builder(
        controller: PageController(viewportFraction: 0.8, initialPage: 0),
        itemCount: achive.length,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 32.0 * params.scale, vertical: 8.0 * params.scale),
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
            child: Row(
              children: <Widget>[
                Flexible(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0 * params.scale),
                      ),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          achive[index]['image'],
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 32.0 * params.scale,
                        right: 32.0 * params.scale,
                        top: 24.0 * params.scale),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          achive[index]['time'],
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.caption.apply(
                              color: Colors.grey[700],
                              fontSizeFactor: params.fontScale * params.scale),
                        ),
                        SizedBox(height: 12.0 * params.scale),
                        Text(
                          achive[index]['value'],
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.caption.apply(
                              color: Colors.grey[700],
                              fontSizeFactor: params.fontScale * params.scale),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BodyEduBlock extends StatelessWidget {
  const BodyEduBlock({
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
        itemCount: educations.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => html.window
                .open(educations[index]['link'], educations[index]['linkName']),
            child: Padding(
              padding: EdgeInsets.all(16.0 * params.scale),
              child: AspectRatio(
                aspectRatio: 2.0,
                child: Stack(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 50.0 * params.scale),
                      padding: EdgeInsets.only(
                          left: 170.0 * params.scale, top: 24.0 * params.scale),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40.0 * params.scale),
                            bottomRight: Radius.circular(40.0 * params.scale)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              offset: Offset(
                                  8.0 * params.scale, 8.0 * params.scale),
                              blurRadius: 5.0 * params.scale)
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            educations[index]['time'],
                            textAlign: TextAlign.left,
                            style: Theme.of(context).textTheme.caption.apply(
                                color: Colors.grey[700],
                                fontSizeFactor:
                                    params.fontScale * params.scale),
                          ),
                          SizedBox(height: 12.0 * params.scale),
                          Text(
                            educations[index]['value'],
                            textAlign: TextAlign.left,
                            style: Theme.of(context).textTheme.caption.apply(
                                color: Colors.grey[700],
                                fontSizeFactor:
                                    params.fontScale * params.scale),
                          ),
                          SizedBox(height: 12.0 * params.scale),
                          LinkWidget(
                            screenScale: params.scale,
                            text: educations[index]['linkName'],
                            url: educations[index]['link'],
                            fontSize:
                                Theme.of(context).textTheme.caption.fontSize *
                                    params.fontScale,
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 50.0 * params.scale),
                      height: 160.0 * params.scale,
                      width: 200.0 * params.scale,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                            Radius.circular(20.0 * params.scale)),
                        image: DecorationImage(
                            image: AssetImage(educations[index]['image']),
                            fit: BoxFit.cover),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              offset: Offset(
                                  4.0 * params.scale, 4.0 * params.scale),
                              blurRadius: 2.0 * params.scale)
                        ],
                      ),
                      // child: Image.asset(
                      //   educations[index]['image'],
                      //   fit: BoxFit.cover,
                      // ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

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

class BodyAboutBlock extends StatelessWidget {
  const BodyAboutBlock({
    Key key,
    @required this.params,
  }) : super(key: key);

  final ScreenParams params;

  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        TableRow(children: [
          TableCell(
            child: Text(
              'name: ',
              textAlign: TextAlign.right,
              style: Theme.of(context)
                  .textTheme
                  .body1
                  .apply(fontSizeFactor: params.fontScale * params.scale),
            ),
          ),
          TableCell(
            child: Text(
              'Andrew',
              textAlign: TextAlign.left,
              style: Theme.of(context)
                  .textTheme
                  .body1
                  .apply(fontSizeFactor: params.fontScale * params.scale),
            ),
          )
        ]),
        TableRow(children: [
          TableCell(
            child: Text(
              'age: ',
              textAlign: TextAlign.right,
              style: Theme.of(context)
                  .textTheme
                  .body1
                  .apply(fontSizeFactor: params.fontScale * params.scale),
            ),
          ),
          TableCell(
            child: Text(
              '${(DateTime.now().difference(DateTime(1982, 10, 12)).inDays / 365).floor().toString()} years',
              textAlign: TextAlign.left,
              style: Theme.of(context)
                  .textTheme
                  .body1
                  .apply(fontSizeFactor: params.fontScale * params.scale),
            ),
          )
        ]),
        TableRow(children: [
          TableCell(
            child: Text(
              'expirience: ',
              textAlign: TextAlign.right,
              style: Theme.of(context)
                  .textTheme
                  .body1
                  .apply(fontSizeFactor: params.fontScale * params.scale),
            ),
          ),
          TableCell(
            child: Text(
              '${(DateTime.now().difference(DateTime(2000, 6)).inDays / 365).floor().toString()} years',
              textAlign: TextAlign.left,
              style: Theme.of(context)
                  .textTheme
                  .body1
                  .apply(fontSizeFactor: params.fontScale * params.scale),
            ),
          )
        ]),
        TableRow(children: [
          TableCell(
            child: Text(
              'mobile dev: ',
              textAlign: TextAlign.right,
              style: Theme.of(context)
                  .textTheme
                  .body1
                  .apply(fontSizeFactor: params.fontScale * params.scale),
            ),
          ),
          TableCell(
            child: Text(
              '${(DateTime.now().difference(DateTime(2014, 9)).inDays / 365).floor().toString()} years',
              textAlign: TextAlign.left,
              style: Theme.of(context)
                  .textTheme
                  .body1
                  .apply(fontSizeFactor: params.fontScale * params.scale),
            ),
          )
        ]),
      ],
    );
  }
}

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

class BarShadowPainter extends CustomPainter {
  final double elevation;
  final Color color;
  final double shrinkScale;
  BarShadowPainter(
      {@required this.shrinkScale,
      @required this.color,
      @required this.elevation});
  @override
  void paint(Canvas canvas, Size size) {
    final startHeight = (.1 + .2 * shrinkScale) * size.width;
    final path = Path();
    path.lineTo(.0, startHeight);
    path.quadraticBezierTo(size.width / 2.0,
        size.width * .45 * (.1 + shrinkScale), size.width, startHeight);
    path.lineTo(size.width, .0);
    path.close();
    canvas.drawShadow(path, color, elevation, true);
  }

  @override
  bool shouldRepaint(BarShadowPainter oldDelegate) {
    return true;
  }
}

class BarClipper extends CustomClipper<Path> {
  final curveBarHeight = .25;
  final curveBarWidth = .8;
  final leftPadding = .25;
  final shrinkScale;
  BarClipper({@required this.shrinkScale});
  @override
  Path getClip(Size size) {
    final startHeight = (.1 + .2 * shrinkScale) * size.width;
    final path = Path();
    path.lineTo(.0, startHeight);
    path.quadraticBezierTo(size.width / 2.0,
        size.width * .45 * (.1 + shrinkScale), size.width, startHeight);
    path.lineTo(size.width, .0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(BarClipper oldClipper) {
    return true;
  }
}

class ScreenParams extends InheritedModel {
  final double baseSize;
  final double scale;
  final double fontScale;

  ScreenParams(
      {@required this.baseSize,
      @required this.scale,
      @required this.fontScale,
      @required Widget child})
      : super(child: child);

  static ScreenParams of(BuildContext context) {
    return InheritedModel.inheritFrom<ScreenParams>(context);
  }

  @override
  bool updateShouldNotify(ScreenParams old) {
    if (baseSize == old.baseSize &&
        scale == old.scale &&
        fontScale == old.fontScale) return false;
    return true;
  }

  @override
  bool updateShouldNotifyDependent(ScreenParams oldWidget, Set dependencies) {
    return false;
  }
}

class EmptyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final params = ScreenParams.of(context);
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('image/back.png'), fit: BoxFit.cover)),
      child: Center(
        child: Text(
          'centeredText',
          // 'baseSize: ${params.baseSize}, fontScale: ${params.fontScale}, scale: ${params.scale}',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class WidthWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Card(
            elevation: 4.0,
            margin: EdgeInsets.only(left: 4.0, right: 4.0, bottom: 4.0),
            child: (constraints.maxWidth < 1024.0)
                ? DesktopPage()
                : Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: (constraints.maxWidth - 1024.0) / 2),
                    child: Card(elevation: 4.0, child: DesktopPage()),
                  ));
      },
    );
  }
}

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

class MainColumnBlockWidget extends StatelessWidget {
  const MainColumnBlockWidget({
    @required this.header,
    @required this.headerImageLink,
    @required this.child,
    Key key,
  }) : super(key: key);

  final String headerImageLink;
  final Widget child;
  final String header;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Card(
        color: Colors.white,
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 100.0,
                width: double.infinity,
                padding: EdgeInsets.only(left: 32.0, bottom: 8.0),
                alignment: Alignment.bottomLeft,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(headerImageLink),
                      fit: BoxFit.cover,
                      colorFilter:
                          ColorFilter.mode(Colors.black, BlendMode.clear),
                      alignment: Alignment.topCenter),
                ),
                foregroundDecoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.black87, Colors.black12],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomCenter)),
                child: Text(header.toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .copyWith(color: Colors.grey[200], fontSize: 36.0)),
              ),
              child,
            ],
          ),
        ),
      ),
    );
  }
}

class AchivementItemWidget extends StatelessWidget {
  AchivementItemWidget({
    @required this.item,
    Key key,
  }) : super(key: key);

  final Map<String, String> item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 100.0,
            alignment: Alignment.topRight,
            child: Text(
              item['time'],
              style: Theme.of(context).textTheme.caption.copyWith(
                  fontWeight: FontWeight.bold, color: Color(0xFF00569C)),
            ),
          ),
          SizedBox(width: 10.0),
          Image.asset(
            item['image'],
            width: 60.0,
            height: 60.0,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  item['value'],
                  style: Theme.of(context).textTheme.caption.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.grey[700]),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class DemoItemWidget extends StatelessWidget {
  DemoItemWidget({
    @required this.item,
    Key key,
  }) : super(key: key);

  final Map<String, dynamic> item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: InkWell(
        onTap: () {
          html.window.open(item['link'], item['linkName']);
        },
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

class EducationItemWidget extends StatefulWidget {
  const EducationItemWidget({
    @required this.item,
    Key key,
  }) : super(key: key);

  final Map<String, String> item;

  @override
  _EducationItemWidgetState createState() => _EducationItemWidgetState();
}

class _EducationItemWidgetState extends State<EducationItemWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        html.window.open(widget.item['link'], widget.item['linkName']);
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 130.0,
              alignment: Alignment.topRight,
              child: Text(
                widget.item['time'],
                style: Theme.of(context).textTheme.caption.copyWith(
                    fontWeight: FontWeight.bold, color: Color(0xFF00569C)),
              ),
            ),
            SizedBox(width: 10.0),
            Image.asset(
              widget.item['image'],
              width: 60.0,
              height: 60.0,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.item['value'],
                    style: Theme.of(context).textTheme.caption.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.grey[700]),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ProfileColumnWidget extends StatelessWidget {
  const ProfileColumnWidget({
    Key key,
    @required this.screenScale,
    @required this.baseSize,
  }) : super(key: key);

  final double screenScale;
  final double baseSize;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        SizedBox(
          height: 100.0 * screenScale,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: AspectRatio(
            aspectRatio: 1.0,
            child: CircleAvatar(
              backgroundImage: AssetImage('image/face.jpg'),
            ),
          ),
        ),
        SizedBox(
          height: 32.0 * screenScale,
        ),
        Row(
          children: <Widget>[
            SizedBox(width: 24.0 * screenScale),
            Icon(
              icons.Icons.globe,
              color: Colors.grey[200],
              size: 40.0 * screenScale,
            ),
            SizedBox(width: 10.0 * screenScale),
            Flexible(
              child: Container(
                height: 1.0 * screenScale,
                color: Colors.grey[200],
              ),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.all(28.0 * screenScale),
          child: Text('Everything is a Widget'.toUpperCase(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.title.copyWith(
                  fontSize: 28.0 * screenScale, color: Colors.grey[200])),
        ),
        SizedBox(height: 16.0 * screenScale),
        Row(
          children: <Widget>[
            SizedBox(width: 24.0 * screenScale),
            Icon(
              icons.Icons.globe,
              color: Colors.grey[200],
              size: 40.0 * screenScale,
            ),
            SizedBox(width: 10.0 * screenScale),
            Text('PROFILE',
                style: Theme.of(context).textTheme.title.copyWith(
                    fontSize: 28.0 * screenScale, color: Colors.grey[200])),
            SizedBox(width: 5.0),
            Flexible(
              child: Container(
                height: 1.0 * screenScale,
                color: Colors.grey[200],
              ),
            )
          ],
        ),
        Table(
          children: [
            TableRow(children: [
              TableCell(
                child: Text(
                  'name: ',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.grey[200],
                    fontSize: 24.0 * screenScale,
                  ),
                ),
              ),
              TableCell(
                child: Text(
                  'Andrew',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.grey[200],
                    fontSize: 24.0 * screenScale,
                  ),
                ),
              )
            ]),
            TableRow(children: [
              TableCell(
                child: Text(
                  'age: ',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.grey[200],
                    fontSize: 24.0 * screenScale,
                  ),
                ),
              ),
              TableCell(
                child: Text(
                  '${(DateTime.now().difference(DateTime(1982, 10, 12)).inDays / 365).floor().toString()} years',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.grey[200],
                    fontSize: 24.0 * screenScale,
                  ),
                ),
              )
            ]),
            TableRow(children: [
              TableCell(
                child: Text(
                  'expirience: ',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.grey[200],
                    fontSize: 24.0 * screenScale,
                  ),
                ),
              ),
              TableCell(
                child: Text(
                  '${(DateTime.now().difference(DateTime(2000, 6)).inDays / 365).floor().toString()} years',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.grey[200],
                    fontSize: 24.0 * screenScale,
                  ),
                ),
              )
            ]),
            TableRow(children: [
              TableCell(
                child: Text(
                  'mobile dev: ',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.grey[200],
                    fontSize: 24.0 * screenScale,
                  ),
                ),
              ),
              TableCell(
                child: Text(
                  '${(DateTime.now().difference(DateTime(2014, 9)).inDays / 365).floor().toString()} years',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.grey[200],
                    fontSize: 24.0 * screenScale,
                  ),
                ),
              )
            ]),
          ],
        ),
        SizedBox(
          height: 40.0 * screenScale,
        ),
        DragTarget(
          builder: (context, candidateData, rejectedData) => Row(
            children: <Widget>[
              SizedBox(width: 24.0 * screenScale),
              Icon(
                icons.Icons.email,
                color: Colors.grey[200],
                size: 40.0 * screenScale,
              ),
              SizedBox(width: 10.0 * screenScale),
              Text('CONTACTs',
                  style: Theme.of(context).textTheme.title.copyWith(
                      fontSize: 28.0 * screenScale, color: Colors.grey[200])),
              SizedBox(width: 5.0),
              Flexible(
                child: Container(
                  height: 2.0 * screenScale,
                  color: Colors.grey[200],
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 24.0 * screenScale),
        FlatButton(
          onPressed: () {
            // final params = ScreenParams.of(context);
            // print(
            //     'baseSize: ${params.baseSize}, fontScale: ${params.fontScale}, scale: ${params.scale}');
            Navigator.pushNamed(context, 'empty');
            // html.window.open('https://t.me/AndX2', 'Telegram');
          },
          child: Column(
            children: <Widget>[
              Icon(
                icons.Icons.telegram,
                color: Colors.blue[700],
                size: 40.0 * screenScale,
              ),
              SizedBox(height: 16.0 * screenScale),
              Text(
                '@AndX2',
                textAlign: TextAlign.center,
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.blue[700],
                  fontSize: 24.0 * screenScale,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final maxHeight = 400.0;
  final minHeight = 100.0;
  final double baseSize;
  final double screenScale;
  _SliverAppBarDelegate({this.baseSize, this.screenScale});
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return LayoutBuilder(builder: (context, cons) {
      final shrinkScale = (cons.maxHeight - minHeight * screenScale) /
          ((maxHeight - minHeight) * screenScale);
      // print(shrinkScale);
      return Stack(
        children: <Widget>[
          ClipPath(
            clipper: HeaderClipper(shrinkScale: shrinkScale),
            child: Container(
                height: double.infinity,
                width: double.infinity,
                color: Color(0xffB25035)),
          ),
          Positioned.fill(
            left: baseSize * .3,
            child: Container(
              child: AnimatedCrossFade(
                firstChild: Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 24.0 * screenScale),
                    child: Column(
                      children: _buildTitleItemsList(),
                    ),
                  ),
                ),
                secondChild: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildTitleItemsList(),
                  ),
                ),
                crossFadeState: (shrinkScale > 0.6)
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: Duration(milliseconds: 400),
                reverseDuration: Duration(milliseconds: 400),
              ),
            ),
          )
        ],
      );
    });
  }

  List<Widget> _buildTitleItemsList() {
    var list = List<Widget>();
    list.add(
      Text(
        'Andrew'.toUpperCase(),
        textAlign: TextAlign.start,
        style: TextStyle(
            fontFamily: 'nova',
            color: Colors.grey[300],
            fontSize: 80.0 * screenScale,
            fontWeight: FontWeight.bold),
      ),
    );
    list.add(SizedBox(height: 10.0 * screenScale, width: 10.0 * screenScale));
    list.add(
      Text(
        'flutter developer'.toUpperCase(),
        textAlign: TextAlign.start,
        maxLines: 2,
        style: TextStyle(
          decoration: TextDecoration.underline,
          fontFamily: 'nova',
          color: Colors.grey[300],
          fontSize: 48.0 * screenScale,
        ),
      ),
    );
    return list;
  }

  @override
  double get maxExtent => maxHeight * screenScale;

  @override
  double get minExtent => minHeight * screenScale;

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

class HeaderClipper extends CustomClipper<Path> {
  final double shrinkScale;
  HeaderClipper({@required this.shrinkScale});

  @override
  getClip(Size size) {
    var path = Path();
    // print(shrinkScale);
    final curvedScale = Curves.fastLinearToSlowEaseIn.transform(shrinkScale);
    path.lineTo(0.0, size.height * (0.4 + (1.0 - curvedScale) * 0.5));
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(HeaderClipper oldClipper) {
    return true;
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final String title;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 1024.0) {
          return MainPage(scaffoldKey: scaffoldKey);
        } else {
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: (constraints.maxWidth - 1024.0) / 2),
            child: MainPage(scaffoldKey: scaffoldKey),
          );
        }
      },
    );
  }
}

class MainPage extends StatelessWidget {
  MainPage({
    Key key,
    @required this.scaffoldKey,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[Colors.grey[200], Colors.grey[500]],
            stops: [0.3, 0.8]),
      ),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.transparent,
        body: LayoutBuilder(
          builder: (context, constraints) {
            final double baseSize = constraints.maxWidth;
            final double screenScale = baseSize / 1024.0;
            var photoPlateBorder = BorderRadius.only(
              topLeft: Radius.circular(baseSize * 0.1),
              bottomLeft: Radius.circular(baseSize * 0.1),
              topRight: Radius.circular(baseSize * 0.01),
              bottomRight: Radius.circular(baseSize * 0.01),
            );
            return Stack(
              children: <Widget>[
                Container(
                  height: double.infinity,
                  width: double.infinity,
                ),
                Positioned.fill(
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: constraints.maxHeight,
                        width: baseSize * 0.3,
                        decoration:
                            BoxDecoration(color: Colors.grey[500], boxShadow: [
                          BoxShadow(
                              offset: Offset(5.0 * screenScale, 0.0),
                              color: Colors.black26,
                              blurRadius: 5.0 * screenScale)
                        ]),
                        padding: EdgeInsets.only(top: baseSize * 0.35),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                SizedBox(width: 24.0 * screenScale),
                                Icon(
                                  icons.Icons.globe,
                                  color: Colors.grey[200],
                                  size: 40.0 * screenScale,
                                ),
                                SizedBox(width: 10.0 * screenScale),
                                Text(
                                  'PROFOLE',
                                  style: Theme.of(context)
                                      .textTheme
                                      .title
                                      .copyWith(
                                          color: Colors.grey[200],
                                          fontSize: 28.0 * screenScale,
                                          fontWeight: FontWeight.bold),
                                ),
                                SizedBox(width: 5.0),
                                Flexible(
                                  child: Container(
                                    height: 2.0 * screenScale,
                                    color: Colors.grey[200],
                                  ),
                                )
                              ],
                            ),
                            _buildBlockPadding(
                              screenScale,
                              child: Text(
                                'Pixcel perfect UI developer'.toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.grey[200],
                                  fontSize: 24.0 * screenScale,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 16.0 * screenScale,
                            ),
                            Row(
                              children: <Widget>[
                                SizedBox(width: 24.0 * screenScale),
                                Icon(
                                  icons.Icons.email,
                                  color: Colors.grey[200],
                                  size: 40.0 * screenScale,
                                ),
                                SizedBox(width: 10.0 * screenScale),
                                Text(
                                  'CONTACTs',
                                  style: Theme.of(context)
                                      .textTheme
                                      .title
                                      .copyWith(
                                          color: Colors.grey[200],
                                          fontSize: 28.0 * screenScale,
                                          fontWeight: FontWeight.bold),
                                ),
                                SizedBox(width: 5.0),
                                Flexible(
                                  child: Container(
                                    height: 2.0 * screenScale,
                                    color: Colors.grey[200],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 24.0 * screenScale),
                            FlatButton(
                              onPressed: () {
                                html.window
                                    .open('https://t.me/AndX2', 'Telegram');
                              },
                              child: Column(
                                children: <Widget>[
                                  Icon(
                                    icons.Icons.telegram,
                                    color: Colors.grey[200],
                                    size: 40.0 * screenScale,
                                  ),
                                  _buildBlockPadding(
                                    screenScale,
                                    child: Text(
                                      '@AndX2',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Colors.blue[600],
                                        fontSize: 24.0 * screenScale,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 16.0 * screenScale,
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        child: Container(
                          height: constraints.maxHeight,
                          padding: EdgeInsets.only(top: baseSize * 0.35),
                          child: SingleChildScrollView(
                            controller: _controller,
                            child: SkillColumnWidget(
                                screenScale: screenScale,
                                controller: _controller),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: baseSize * 0.1, top: baseSize * 0.05),
                  child: Container(
                      height: baseSize * 0.25,
                      width: baseSize * 0.6,
                      decoration: BoxDecoration(
                          color: Colors.grey[600],
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black26,
                                spreadRadius: 10.0 * screenScale,
                                blurRadius: 10.0 * screenScale)
                          ],
                          borderRadius: photoPlateBorder),
                      foregroundDecoration: BoxDecoration(
                          borderRadius: photoPlateBorder,
                          image: DecorationImage(
                              alignment: Alignment.centerLeft,
                              image: AssetImage('image/face.jpg'))),
                      child: Row()),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Padding _buildBlockPadding(double screenScale, {@required Widget child}) {
    return Padding(
        padding: EdgeInsets.only(
          top: 12.0 * screenScale,
          left: 24.0 * screenScale,
          bottom: 12.0 * screenScale,
          right: 12.0 * screenScale,
        ),
        child: child);
  }
}

class SkillColumnWidget extends StatelessWidget {
  const SkillColumnWidget({
    Key key,
    @required this.screenScale,
    @required ScrollController controller,
  })  : _controller = controller,
        super(key: key);

  final double screenScale;
  final ScrollController _controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            SizedBox(width: 24.0 * screenScale),
            Icon(
              icons.Icons.book,
              color: Colors.grey[600],
              size: 40.0 * screenScale,
            ),
            SizedBox(width: 10.0 * screenScale),
            Text(
              'EDUCATION',
              style: Theme.of(context).textTheme.title.copyWith(
                  color: Colors.grey[600],
                  fontSize: 28.0 * screenScale,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 5.0),
            Flexible(
              child: Container(
                height: 2.0 * screenScale,
                color: Colors.grey[600],
              ),
            )
          ],
        ),
        _buildBlockPadding(
          screenScale,
          child: ExpandableTextBlock(
            screenScale: screenScale,
            firstChild: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '${educations[0]['time']}\n ${educations[0]['value']}',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 24.0 * screenScale,
                  ),
                ),
                LinkWidget(
                  screenScale: screenScale,
                  text: educations[0]['link'],
                  fontSize: 22.0,
                ),
              ],
            ),
            secondChild: Padding(
              padding: EdgeInsets.only(left: 32.0 * screenScale),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: educations.map((item) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '${item['time']}\n ${item['value']}',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 22.0 * screenScale,
                          ),
                        ),
                        LinkWidget(
                          screenScale: screenScale,
                          text: item['linkName'],
                          url: item['link'],
                        ),
                        (item != educations.last) ? Divider() : Container(),
                      ],
                    );
                  }).toList()),
            ),
          ),
        ),
        SizedBox(
          height: 32.0 * screenScale,
        ),
        Row(
          children: <Widget>[
            SizedBox(width: 24.0 * screenScale),
            Icon(
              icons.Icons.brief,
              color: Colors.grey[600],
              size: 40.0 * screenScale,
            ),
            SizedBox(width: 10.0 * screenScale),
            Text(
              'SKILLs',
              style: Theme.of(context).textTheme.title.copyWith(
                  color: Colors.grey[600],
                  fontSize: 28.0 * screenScale,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 5.0),
            Flexible(
              child: Container(
                height: 2.0 * screenScale,
                color: Colors.grey[600],
              ),
            )
          ],
        ),
        _buildBlockPadding(
          screenScale,
          child: Builder(builder: (context) {
            int gridColumnCount = 4;
            double h = ((skills.length * 1.0) / gridColumnCount).ceil() *
                (((1024.0 * 0.6 * screenScale) /
                    (gridColumnCount * 1.15) *
                    1.3));
            return Container(
              height: h,
              child: GridView.count(
                controller: _controller,
                addAutomaticKeepAlives: false,
                crossAxisCount: gridColumnCount,
                children: List.generate(
                  skills.length,
                  (index) {
                    return Padding(
                      padding: EdgeInsets.all(8.0 * screenScale),
                      child: SkillWidget(
                        screenScale: screenScale,
                        skill: skills[index],
                        gridColumnCount: gridColumnCount,
                      ),
                    );
                  },
                ),
              ),
            );
          }),
        ),
        SizedBox(
          height: 32.0 * screenScale,
        ),
        Row(
          children: <Widget>[
            SizedBox(width: 24.0 * screenScale),
            Icon(
              icons.Icons.achive,
              color: Colors.grey[600],
              size: 40.0 * screenScale,
            ),
            SizedBox(width: 10.0 * screenScale),
            Text(
              'ACHIVEMENTs',
              style: Theme.of(context).textTheme.title.copyWith(
                  color: Colors.grey[600],
                  fontSize: 28.0 * screenScale,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 5.0),
            Flexible(
              child: Container(
                height: 2.0 * screenScale,
                color: Colors.grey[600],
              ),
            )
          ],
        ),
        _buildBlockPadding(
          screenScale,
          child: ExpandableTextBlock(
            screenScale: screenScale,
            firstChild: Column(
              children: <Widget>[
                Text(
                  '${achive[2]['time']}\n${achive[2]['value']}',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 24.0 * screenScale,
                  ),
                ),
              ],
            ),
            secondChild: Column(
                children: achive.map<Widget>((item) {
              return Padding(
                padding: EdgeInsets.only(left: 32.0 * screenScale),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${item['time']}\n${item['value']}',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 24.0 * screenScale,
                      ),
                    ),
                    (item != achive.last) ? Divider() : Container(),
                  ],
                ),
              );
            }).toList()),
          ),
        ),
        SizedBox(
          height: 32.0 * screenScale,
        ),
      ],
    );
  }

  Padding _buildBlockPadding(double screenScale, {@required Widget child}) {
    return Padding(
        padding: EdgeInsets.only(
          top: 12.0 * screenScale,
          left: 24.0 * screenScale,
          bottom: 12.0 * screenScale,
          right: 12.0 * screenScale,
        ),
        child: child);
  }
}

class LinkWidget extends StatelessWidget {
  LinkWidget(
      {Key key,
      @required this.screenScale,
      @required this.text,
      this.url,
      this.fontSize = 24.0})
      : super(key: key);

  final double screenScale;
  final String text;
  final String url;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    // if (url == null) url = text;
    return InkWell(
      onTap: () => html.window.open(url ?? text, url ?? text),
      child: Text(
        text,
        style: TextStyle(
          decoration: TextDecoration.underline,
          color: Colors.blue[700],
          fontSize: fontSize * screenScale,
        ),
      ),
    );
  }
}

class ExpandableTextBlock extends StatefulWidget {
  final double screenScale;
  final Widget firstChild;
  final Widget secondChild;

  ExpandableTextBlock(
      {this.screenScale = 1.0, this.firstChild, this.secondChild});

  @override
  State<StatefulWidget> createState() {
    return _ExpandableTextBlockState();
  }
}

class _ExpandableTextBlockState extends State<ExpandableTextBlock> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        AnimatedCrossFade(
          firstChild: widget.firstChild,
          secondChild: widget.secondChild,
          crossFadeState:
              isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: kThemeAnimationDuration,
        ),
        Padding(
          padding: EdgeInsets.only(
              left: 20.0 * widget.screenScale,
              right: 20.0 * widget.screenScale),
          child: GestureDetector(
            onTap: () {
              setState(() {
                isExpanded ? isExpanded = false : isExpanded = true;
              });
            },
            child: Text(
              isExpanded ? "less" : "more...",
              style: Theme.of(context)
                  .textTheme
                  .body1
                  .apply(color: Color(0xFFFB382F)),
            ),
          ),
        ),
      ],
    );
  }
}
// Color(0xFFFB382F)

class SkillWidget extends StatelessWidget {
  final double screenScale;
  final int gridColumnCount;
  final Map<String, dynamic> skill;

  SkillWidget(
      {this.screenScale = 1.0, @required this.skill, this.gridColumnCount = 4});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (1024.0 * 0.6 * screenScale) / (gridColumnCount * 1.15),
      height: ((1024.0 * 0.6 * screenScale) / (gridColumnCount * 1.15) * 1.2) *
          screenScale,
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
                    left: 32.0 * screenScale * (3.0 / gridColumnCount),
                    right: 32.0 * screenScale * (3.0 / gridColumnCount),
                    bottom: 64.0 * screenScale) *
                (3.0 / gridColumnCount),
            child: Image.asset(
              skill['image'],
              fit: BoxFit.contain,
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                skill['name'],
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 24.0 * screenScale * (3.0 / gridColumnCount),
                ),
              ),
            ),
          ),
          Container(
            height: 200.0 * screenScale,
            width: 200.0 * screenScale,
            padding: EdgeInsets.only(
                left: 8.0, right: 8.0, bottom: 32.0 * screenScale),
            child: CustomPaint(
              painter: SkillArcPainter(
                  value: skill['rate'],
                  screenScale: screenScale,
                  countScale: (3.0 / gridColumnCount),
                  color: Color(int.parse(skill['color']))),
            ),
          )
        ],
      ),
    );
  }
}

class SkillArcPainter extends CustomPainter {
  final double screenScale;
  double countScale;
  final double value;
  Paint _paint;

  SkillArcPainter(
      {@required this.value,
      @required this.screenScale,
      @required Color color,
      this.countScale = 1}) {
    double width = 16.0 * screenScale * countScale;
    _paint = Paint()
      ..color = color
      ..strokeWidth = width > 8.0 ? 8.0 : 16.0 * screenScale * countScale
      ..strokeCap = StrokeCap.square
      ..style = PaintingStyle.stroke;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset(0.0, 0.0) & size;
    canvas.drawArc(rect, 0.0, 2 * pi * value, false, _paint);
  }

  @override
  bool shouldRepaint(SkillArcPainter oldDelegate) {
    return false;
  }
}
