import 'dart:html' as html;
import 'dart:math';

import 'package:flutter_web/material.dart';
import 'package:flutter_web/painting.dart';
import 'package:flutter_web/widgets.dart';
import 'dart:html';

import 'package:fw_resume/data.dart';
import 'package:fw_resume/widget/pentagon.dart';

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
  static const double smallWidth = 768.0;
  static const double hugeWidth = 1024.0;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final baseSize =
        (mediaQuery.size.width > hugeWidth) ? hugeWidth : mediaQuery.size.width;
    final scale = baseSize / hugeWidth;
    final fontScale = (baseSize < smallWidth) ? 2.0 : 1.0;
    final orientation = mediaQuery.orientation;

    return ScreenParams(
      baseSize: baseSize,
      scale: scale,
      fontScale: fontScale,
      child: (baseSize >= hugeWidth)
          ? _buildDesk(padding: (mediaQuery.size.width - hugeWidth) / 2)
          : (baseSize >= 768.0)
              ? _buildTablet()
              : (orientation == Orientation.portrait)
                  ? _buildPhonePort()
                  : _buildPhoneLand(),
    );
  }

  Widget _buildPhonePort() {
    return Scaffold(body: ResumePage());
  }

  Widget _buildPhoneLand() {
    return Scaffold(body: ResumePage());
  }

  Widget _buildTablet() {
    return Scaffold(body: ResumePage1());
  }

  Widget _buildDesk({double padding}) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: padding),
        child: Card(elevation: 4.0, child: ResumePage()));
  }
}

class ResumePage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final params = ScreenParams.of(context);
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('image/back.png'), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: NestedScrollView(
            headerSliverBuilder: (context, scrolled) {
              return <Widget>[
                SliverPersistentHeader(
                  delegate:
                      _SliverHeaderDelegate(baseSize: 900.0, screenScale: 0.8),
                  pinned: true,
                )
              ];
            },
            body: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) => Container(
                    height: 200.0,
                    color: Colors.red,
                  ),
            )),
      ),
    );
  }
}

class _SliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  final maxHeight = 400.0;
  final minHeight = 100.0;
  final double baseSize;
  final double screenScale;
  _SliverHeaderDelegate({this.baseSize, this.screenScale});
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return LayoutBuilder(builder: (context, cons) {
      final shrinkScale = (cons.maxHeight - minHeight * screenScale) /
          ((maxHeight - minHeight) * screenScale);
      // print(shrinkScale);
      final imageSize = min(cons.maxHeight, cons.maxWidth);
      return Pentagon(
        color: Colors.orange,
        shadowColor: Colors.white,
        elevation: 8.0,
        borderWidth: 3.0,
        child: Image.asset(
          'image/face_.jpg',
          fit: BoxFit.contain,
        ),
      );
    });
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
                ? ResumePage()
                : Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: (constraints.maxWidth - 1024.0) / 2),
                    child: Card(elevation: 4.0, child: ResumePage()),
                  ));
      },
    );
  }
}

class ResumePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final double baseSize = constraints.maxWidth;
      final double screenScale = baseSize / 1024.0;
      final scrollController = ScrollController();
      return Stack(children: [
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Colors.grey[200], Colors.grey[500]],
                  stops: [0.3, 0.8]),
            ),
          ),
        ),
        NestedScrollView(
          headerSliverBuilder: (context, scrolled) {
            return <Widget>[
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                    baseSize: baseSize, screenScale: screenScale),
                pinned: true,
              ),
            ];
          },
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: baseSize * .3),
              child: SkillColumnWidget(
                screenScale: screenScale,
                controller: scrollController,
              ),
            ),
          ),
        ),
        Container(
          width: baseSize * .3,
          decoration: BoxDecoration(
              color: Colors.grey[500].withOpacity(.7),
              boxShadow: [
                BoxShadow(
                    offset: Offset(5.0 * screenScale, 0.0),
                    color: Colors.black38,
                    blurRadius: 5.0 * screenScale)
              ]),
          child: new ProfileColumnWidget(
              screenScale: screenScale, baseSize: baseSize),
        )
      ]);
    });
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
                          fontSize: 28.0 * screenScale,
                          color: Colors.grey[200])),
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
      print(shrinkScale);
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
                            child: new SkillColumnWidget(
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
                    fontSize: 22.0 * widget.screenScale),
              )),
        ),
      ],
    );
  }
}

class SkillWidget extends StatelessWidget {
  final double screenScale;
  final int gridColumnCount;
  final Map<String, dynamic> skill;

  SkillWidget({this.screenScale, this.skill, this.gridColumnCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (1024.0 * 0.6 * screenScale) / (gridColumnCount * 1.15),
      height: ((1024.0 * 0.6 * screenScale) / (gridColumnCount * 1.15) * 1.15) *
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
  double countScale = 1.0;
  final double value;
  Paint _paint;

  SkillArcPainter(
      {@required this.value,
      @required this.screenScale,
      @required Color color,
      this.countScale = 1}) {
    _paint = Paint()
      ..color = color
      ..strokeWidth = 16.0 * screenScale * countScale
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
