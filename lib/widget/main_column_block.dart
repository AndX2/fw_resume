import 'package:flutter_web/material.dart';


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
