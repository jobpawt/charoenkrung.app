import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  final Future<List<dynamic>> products;

  Body({this.products});

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Widget buildBody(BuildContext context) {
    double _crossAxisSpacing = 8;
    double _screenWidth = MediaQuery.of(context).size.width;
    int _crossAxisCount = 2;
    double _width =
        (_screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) /
            _crossAxisCount;
    double _cellHeight = 250;
    double _aspectRatio = _width / _cellHeight;
    if (products != null) {
      //have data
      return Expanded(
          child: FutureBuilder(
        future: this.products,
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
            return GridView.builder(
                itemCount: productList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: _crossAxisCount,
                    crossAxisSpacing: _crossAxisSpacing,
                    mainAxisSpacing: _crossAxisSpacing,
                    childAspectRatio: _aspectRatio),
                itemBuilder: (context, index) => null);
          }
        },
      ));
    } else {
      //not have data
      return Center(
        child: Container(
          child: Text('not have data'),
        ),
      );
    }
  }
}
