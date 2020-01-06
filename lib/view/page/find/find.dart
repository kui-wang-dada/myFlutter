import 'package:flutter/material.dart';
import 'package:hello_world/routes/navigator_util.dart';

class FindPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<FindPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('李同学'),
          actions: <Widget>[
            //导航栏右侧菜单
            IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
          ],
        ),
        body: Padding(
            child: Column(children: <Widget>[
              buildTopRow(context),
              buildCenterRow(context),
            ]),
            padding: EdgeInsets.symmetric(horizontal: 20.0)));
  }

  Widget buildTopRow(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: <Widget>[
        Expanded(flex: 1, child: buildTab(context, '学术历史', '补充我的个人信息')),
        Expanded(flex: 1, child: buildTab(context, '服务记录', '查看沟通记录和文档')),
      ],
    );
  }

  Widget buildCenterRow(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('我的服务'),
        ListView.builder(
            itemCount: 100,
            shrinkWrap: true,
            itemExtent: 50.0, //强制高度为50.0
            itemBuilder: (BuildContext context, int index) {
              return ListTile(title: Text("$index"));
            })
      ],
    );
  }

  Widget buildTab(BuildContext context, String name, String label) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(Icons.ondemand_video),
        Column(
          children: <Widget>[
            Text(name),
            Text(label),
          ],
        )
      ],
    );
  }
}
