import 'package:flutter/material.dart';
import 'package:hello_world/routes/navigator_util.dart';
import 'package:hello_world/api/home.dart';

class FindPage extends StatefulWidget {
  final String name = '12';
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<FindPage> {
  var homeApi = HomeApi();
  var _list;
  @override
  void initState() {
    super.initState();
    print('init state${widget.name}');
    homeApi.getServiceList((res) {
      setState(() {
        _list = res.data.display;
      });
    });
  }

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
    if (_list == null) {
      return Text('没有数据');
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 10),
          child: Text('我的服务',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Color.fromARGB(255, 20, 20, 20),
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                height: 1.2,
                fontFamily: "Courier",
              )),
        ),
        Container(
          height: 500,
          child: ListView.builder(
              itemCount: _list.length,
              shrinkWrap: true,
              itemExtent: 50.0, //强制高度为50.0
              itemBuilder: buildItem),
        )
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

  Widget buildItem(BuildContext context, int index) {
    return ListTile(title: Text("${_list[index].title}"));
  }
}
