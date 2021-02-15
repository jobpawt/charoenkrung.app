import 'package:flutter/material.dart';

import 'dialogBox.dart';

class Validate {
  final BuildContext context;
  final String title;
  bool _status = false;
  String _message = '';
  Validate({this.context, this.title});

  Validate isNotEmpty(String data) {
    if (data.isNotEmpty) {
      _status = true;
    } else {
      _status = false;
      _message += 'ไม่ได้กรอกข้อมูล \n';
    }
    return this;
  }

  Validate isEqual(String data1, String data2) {
    if (data1.trim() == data2.trim()) {
      _status = true;
    } else {
      _status = false;
      _message += 'ข้อมูลไม่ตรงกัน \n';
    }
    return this;
  }

  bool check() {
    if (!_status)
      DialogBox.oneButton(
          context: this.context,
          title: title,
          message: _message,
          press: () => DialogBox.close(context));
    return _status;
  }
}
