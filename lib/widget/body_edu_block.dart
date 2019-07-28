import 'dart:html' as html;
import 'package:flutter_web/material.dart';

import 'package:fw_resume/utils/screen_builder.dart';
import 'package:fw_resume/api/data.dart';
import 'package:fw_resume/widget/link.dart';

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
