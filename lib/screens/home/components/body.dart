import 'package:charoenkrung_app/providers/menuProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return buildGridView(context);
  }

  Future<List<dynamic>> getDataFromDatabase({String menu}) async {
    return null;
  }

  Widget buildGridView(BuildContext context) {
    String menu = Provider.of<MenuProvider>(context).menu;
    double _crossAxisSpacing = 8;
    double _screenWidth = MediaQuery.of(context).size.width;
    int _crossAxisCount = 2;
    double _width =
        (_screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) /
            _crossAxisCount;
    double _cellHeight = 250;
    double _aspectRatio = _width / _cellHeight;
    //have data
    return Expanded(
        child: FutureBuilder(
      future: getDataFromDatabase(menu: menu),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          //waiting downloading data
          return Center(
            child: Container(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          //finished
          var productList = snapshot.data;
          return productList != null
              ? GridView.builder(
                  itemCount: productList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: _crossAxisCount,
                      crossAxisSpacing: _crossAxisSpacing,
                      mainAxisSpacing: _crossAxisSpacing,
                      childAspectRatio: _aspectRatio),
                  itemBuilder: (context, index) => null)
              : Center(
                  child: Container(
                    child: Text('not have data'),
                  ),
                );
        }
      },
    ));
  }
}
