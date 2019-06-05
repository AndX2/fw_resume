import 'dart:math';

import 'package:flutter_web/material.dart';
import 'package:flutter_web/widgets.dart';

import 'package:fw_resume/data.dart';

import 'icons.dart' as icons;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Andrew: flutter dev',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'gs',
        textTheme: TextTheme(
          title: TextStyle(fontFamily: 'ss'),
        ),
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
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
                                'Everything is a Widget!'.toUpperCase(),
                                style: TextStyle(
                                  color: Colors.grey[200],
                                  fontSize: 24.0 * screenScale,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Flexible(
                        child: Container(
                          height: constraints.maxHeight,
                          padding: EdgeInsets.only(top: baseSize * 0.35),
                          child: SingleChildScrollView(
                            controller: _controller,
                            child: Column(
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .title
                                          .copyWith(
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
                                    firstChild: Text(
                                      educations[0],
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 24.0 * screenScale,
                                      ),
                                    ),
                                    secondChild: Column(
                                      children: <Widget>[
                                        Text(
                                          educations[0],
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 24.0 * screenScale,
                                          ),
                                        ),
                                        Text(
                                          educations[0],
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 24.0 * screenScale,
                                          ),
                                        ),
                                      ],
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
                                      icons.Icons.brief,
                                      color: Colors.grey[600],
                                      size: 40.0 * screenScale,
                                    ),
                                    SizedBox(width: 10.0 * screenScale),
                                    Text(
                                      'SKILLs',
                                      style: Theme.of(context)
                                          .textTheme
                                          .title
                                          .copyWith(
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
                                    int gridColumnCount = 3;
                                    double h = ((skills.length * 1.0) /
                                                gridColumnCount)
                                            .ceil() *
                                        (230.0 * screenScale);
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
                                              padding: EdgeInsets.all(
                                                  8.0 * screenScale),
                                              child: SkillWidget(
                                                screenScale: screenScale,
                                                skill: skills[index],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    );
                                  }),
                                ),
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
                                      'ACHIVEMENTs',
                                      style: Theme.of(context)
                                          .textTheme
                                          .title
                                          .copyWith(
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
                                _buildBlockPadding(screenScale,
                                    child: Container()),
                              ],
                            ),
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

class ExpandableTextBlock extends StatefulWidget {
  final double screenScale;
  final Widget firstChild;
  final Widget secondChild;

  ExpandableTextBlock({this.screenScale, this.firstChild, this.secondChild});

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
                isExpanded ? "less" : "more..",
                style: TextStyle(
                    color: Color(0xFFFB382F),
                    fontWeight: FontWeight.w700,
                    fontSize: 18.0 * widget.screenScale),
              )),
        ),
      ],
    );
  }
}

class SkillWidget extends StatelessWidget {
  final double screenScale;
  final Map<String, dynamic> skill;

  SkillWidget({this.screenScale, this.skill});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230.0 * screenScale,
      width: 200.0 * screenScale,
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
                left: 32.0 * screenScale,
                right: 32.0 * screenScale,
                bottom: 64.0 * screenScale),
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
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 24.0 * screenScale,
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
  final double value;
  Paint _paint;

  SkillArcPainter(
      {@required this.value,
      @required this.screenScale,
      @required Color color}) {
    _paint = Paint()
      ..color = color
      ..strokeWidth = 16.0 * screenScale
      ..strokeCap = StrokeCap.round
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
