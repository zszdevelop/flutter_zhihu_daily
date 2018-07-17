import 'package:flutter/material.dart';
import '../pages/DailyDetailPage.dart';

class BannerView extends StatefulWidget {
  var data;

  BannerView(data) {
    this.data = data;
  }

  @override
  State<StatefulWidget> createState() => new _BannerViewState(data);


}

class _BannerViewState extends State<BannerView>
    with SingleTickerProviderStateMixin {
  List data;
  TextStyle titleStyle = new TextStyle(color: Colors.white, fontSize: 18.0);

  TabController tabController;


  _BannerViewState(data) {
    this.data = data;
  }

  @override
  void initState() {
    super.initState();
    tabController =
    new TabController(length: data == null ? 0 : data.length, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [];
    if (data != null && data.length > 0) {
      for (var i = 0; i < data.length; i++) {
        var item = data[i];
        var image = item['image'];
        var title = item['title'];
        var id = item['id'];
        items.add(new GestureDetector(
          onTap: () { // 点击跳转详情页面
            Navigator.of(context).push(new MaterialPageRoute(
                builder: (context)=>DailyDetailPage(id:id)));
          },
          child: new Stack(
            children: <Widget>[
              new Image.network(image, width: MediaQuery
                  .of(context)
                  .size
                  .width, fit: BoxFit.fitWidth,),
              new Container(
                alignment: Alignment.bottomCenter,
                margin: const EdgeInsets.only(
                    bottom: 30.0, left: 15.0, right: 15.0),
                child: Text(title, style: titleStyle,),
              )
            ],
          ),
        ));
      }
    }
    return new Stack(
        children: <Widget>[
          new TabBarView(
              controller: tabController,
              children: items
          ),
          // 小圆点指示器
          new Container(
            alignment: Alignment.bottomCenter,
            margin: const EdgeInsets.only(bottom: 10.0),
            child: new TabPageSelector(
                indicatorSize: 5.0,
                color: Colors.grey,
                selectedColor: Colors.white,
                controller: tabController),
          ),
        ]
    );
  }
}