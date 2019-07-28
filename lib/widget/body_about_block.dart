import 'package:flutter_web/material.dart';

import 'package:fw_resume/utils/screen_builder.dart';

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
