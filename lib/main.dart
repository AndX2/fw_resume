import 'package:flutter_web/material.dart';
import 'package:flutter_web/widgets.dart';

import 'package:fw_resume/utils/screen_builder.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Andrew: dart dev',
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
        // 'empty': (BuildContext context) => EmptyPage(),
      },
      // onGenerateRoute: (settings) {
      //   return MaterialPageRoute(builder: (context) => EmptyPage());
      // },

      // home: WidthWidget()
      // MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
