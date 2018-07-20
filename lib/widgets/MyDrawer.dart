import 'package:flutter/material.dart';
import '../api/Api.dart';
import '../utils/NetUtils.dart';
import 'dart:convert';

class MyDrawer extends StatefulWidget {


  @override
  State<StatefulWidget> createState() => new _MyDrawerState();

}

class _MyDrawerState extends State<MyDrawer> {


  TextStyle textStyle = new TextStyle(color: Colors.white, fontSize: 15.0);
  TextStyle subTextStyle = new TextStyle(color: Colors.white, fontSize: 12.0);
  TextStyle itemTextStyle = new TextStyle(
      color: Colors.black45, fontSize: 15.0);
  TextStyle itemCheckTextStyle = new TextStyle(
      color: Colors.blue, fontSize: 15.0);

  var themes;

  @override
  void initState() {
    super.initState();
    getThemes();
  }

  @override
  Widget build(BuildContext context) {
    return new ConstrainedBox(
      constraints: const BoxConstraints.expand(width: 250.0),
      child: new Material(
        elevation: 16.0,
        child: new Container(
          decoration: new BoxDecoration(
              color: Colors.white
          ),
          child:  new ListView.builder(
              itemCount: themes == null?2:themes.length+1,
              itemBuilder: (context, i) => renderRow(i)),

        ),
      ),
    );
  }


  Widget renderRow(int index) {
    // top
    if (index == 0) {
      return getTop();
    }
    if(themes == null){
      return new Container(
        height: MediaQuery.of(context).size.height-200,
        child: new Center(
          child: new CircularProgressIndicator(),
        ),
      );
    }

    index--;
    var theme = themes[index];
    String menuTitle = theme['name'];
    int id = theme['id'];
//    bool checked = theme.checked;
    return new InkWell(
      onTap: () {
//        Navigator.pop(context,Api.getTheme+id);
      },
      child: new Container(
        height: 40.0,
        padding: const EdgeInsets.only(left: 15.0),
        child: new Row(
          children: <Widget>[

            new Container(
              padding: const EdgeInsets.only(left: 30.0),
              child: Text(menuTitle,
                style: itemTextStyle,),
//                style: checked ? itemCheckTextStyle : itemTextStyle,),
            )
          ],
        ),
      ),
    );
  }

  /**
   * 获取日报主题
   */
  void getThemes() {
    String url = Api.themes;
    print("主题url  $url");
    NetUtils.get(url, (data) {
      if (data != null) {
        Map<String, dynamic> map = json.decode(data);
        var _themes = map['others'];

        setState(() {
          themes = _themes;
        });
      }
    }, errorCallback: (e) {
      print("请求数据异常$e");
    }
    );
  }

  /**
   * 获取top
   */
  Widget getTop() {
    return new Container(
      padding: const EdgeInsets.all(15.0),
      decoration: new BoxDecoration(
        color: Colors.blue,
      ),
      child: new Column(
        children: <Widget>[
          new Row(
            children: <Widget>[
              new Image.asset('./images/menu_avatar.png',
                width: 30.0,
                height: 30.0,),
              new Container(
                padding: const EdgeInsets.only(left: 10.0),
                child: new Text("请登录", style: textStyle,),
              )
            ],
          ),
          new Container(
            padding: const EdgeInsets.only(top: 30.0),
            child: Row(
              children: <Widget>[
                new Image.asset('./images/favorites.png',
                  width: 30.0,
                  height: 30.0,),
                new Container(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: new Text("我的收藏", style: textStyle,),
                )
              ],
            ),
          ),

        ],
      ),
    );
  }



}