import 'package:flutter_web/material.dart';

import 'package:fw_resume/utils/screen_builder.dart';
import 'package:fw_resume/api/data.dart';


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
