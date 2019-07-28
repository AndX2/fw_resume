import 'dart:html' as html;
import 'package:flutter_web/material.dart';

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
