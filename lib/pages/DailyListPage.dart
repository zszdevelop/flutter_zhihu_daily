import 'dart:async';

import 'package:flutter/material.dart';
import '../api/Api.dart';
import '../utils/NetUtils.dart';
import 'dart:convert';
import '../widgets/BannerView.dart';
import 'DailyDetailPage.dart';

/**
 * 日报列表
 * */
class DailyListPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _DailyListPageState();


}

class _DailyListPageState extends State<DailyListPage> {

  var top_stories;
  var stories;

  TextStyle itemTitleStyle = new TextStyle(color: const Color(0xFF0a0a0a), fontSize: 15.0);

  @override
  void initState() {
    super.initState();
    getDailyData(true);
  }

  @override
  Widget build(BuildContext context) {

    if (stories == null) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    } else {
      Widget listView = new ListView.builder(
          itemCount: stories.length+1,
          itemBuilder: (context, i) => renderRow(i));
      return new RefreshIndicator(child: listView, onRefresh: _pullToRefresh);
    }


  }

  /**
   * 刷新日报数据
   */
  getDailyData(bool isRefresh) {
    String url = Api.getLatest;
    print("日报url  $url");
    NetUtils.get(url, (data) {
      if (data != null) {
        Map<String, dynamic> map = json.decode(data);
        var _top_stories = map['top_stories'];
        var _stories = map['stories'];
        setState(() {
          if (isRefresh) {
            top_stories = _top_stories;
            stories = _stories;
          }
        });
      }
    }, errorCallback: (e) {
      print("请求数据异常$e");
    }
    );
  }

  Widget renderRow(int i) {
    if(i == 0){
      return new  Container(
        height: 180.0,
        child: BannerView(top_stories),
      );
    }
    i -= 1;
    var storie = stories[i];
    var content = new Row(
      children: <Widget>[
        new Expanded(
            flex: 3,
            child: new Padding(
              padding: const EdgeInsets.all(15.0),
              child: new Text(storie['title'],style: itemTitleStyle,),
            )),
        new Expanded(
            child: new Padding(
                padding: const EdgeInsets.only(top: 15.0,bottom: 15.0,right: 15.0),
                child: new Center(
                  child: Image.network(storie['images'][0]),
                ),                
            )
        )
      ],
    );

    var card = new Card(
      elevation: 2.0,
      margin: const EdgeInsets.only(
          left: 12.0, top: 6.0, bottom: 6.0, right: 12.0),
      child: content,
    );

    return new InkWell(
      onTap: () async {
        print("点击开始");
       String ss = await Navigator.of(context).push(MaterialPageRoute(builder: (context)=> DailyDetailPage(id: storie['id'],)));
       print("点击回调"+ss);
      },
      child: card,
    );
  }

  Future<Null> _pullToRefresh() async {
    getDailyData(true);
    return null;
  }


}