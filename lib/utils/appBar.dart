import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

AppBar createAppBar({BuildContext context, String title, Color color}) {
  return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: Text(title,
          style: Theme.of(context).textTheme.headline5.copyWith(color: color)),
      leading: IconButton(
          icon: SvgPicture.asset(
            'assets/Myprevious.svg',
            color: color,
          ),
          onPressed: () => Navigator.pop(context)));
}
