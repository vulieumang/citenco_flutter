import 'package:cnvsoft/special/base_citenco/package/package.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class BuildTabBar extends StatefulWidget {
  final List? widget;
  final bool? scroll;

  const BuildTabBar({Key? key, this.widget, this.scroll = true})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => TabBarState();
}

class TabBarState extends State<BuildTabBar> {
  @override
  Widget build(BuildContext context) {
    return _buildTabBar(widget.widget!, widget.scroll!);
  }
}

_buildTabBar(List widget, bool scroll) {
  return TabBar(
      padding: EdgeInsets.zero,
      indicatorWeight: 3,
      isScrollable: scroll,
      labelStyle: BasePKG().text!.smallBold(),
      unselectedLabelStyle: BasePKG().text!.smallNormal(),
      unselectedLabelColor: BasePKG().color.mainTextColor,
      indicatorColor: BasePKG().color.primaryColor,
      labelColor: BasePKG().color.primaryColor,
      tabs: widget as List<Widget>);
}
