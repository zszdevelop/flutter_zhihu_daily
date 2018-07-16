import 'package:flutter/material.dart';
import 'DailyListPage.dart';
import '../widgets/MyDrawer.dart';

/**
 * 主页
 */
class DailyPage extends StatefulWidget{


  @override
  State<StatefulWidget> createState() {
   return new _DailyPageState();
  }

}

class _DailyPageState extends State<DailyPage> {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "flutter知乎日报",
      home: new Scaffold(
        // 设置appbar
        appBar: new AppBar(
          title: new Text("首页"),
          actions: <Widget>[
            new IconButton(
                icon: new Icon(Icons.notifications),
                onPressed: (){}),

            new PopupMenuButton(itemBuilder: (BuildContext context){
              List<PopupMenuItem> list = <PopupMenuItem>[
                new PopupMenuItem(child: new Text("夜间模式")),
                new PopupMenuItem(child: new Text("设置选项")),
              ];
              return list;
            })
          ],
        ),

        // 设置body,日报列表
        body: new DailyListPage(),
        drawer:new  MyDrawer(),

      ),
    );
  }
}
