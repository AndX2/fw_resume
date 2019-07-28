import 'package:flutter_web/material.dart';


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
