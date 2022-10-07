import 'package:cnvsoft/base_citenco/package/package.dart';
import 'package:cnvsoft/base_citenco/modify/package.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:html_character_entities/html_character_entities.dart';

class HtmlView extends StatefulWidget {
  final String? data;
  final TextStyle? dataStyle;
  final bool buildAsync;

  const HtmlView(
      {Key? key, required this.data, this.dataStyle, this.buildAsync = false})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HtmlViewState();
  }
}

class HtmlViewState extends State<HtmlView> {
  // List<String> htmls = [];
  // String replaceHtml;

  @override
  Widget build(BuildContext context) {
    var data = widget.data;
    var text = HtmlCharacterEntities.decode(BasePKG().stringOf(() => data));
    print(text);
    return HtmlWidget(text, webView: true, buildAsync: widget.buildAsync, textStyle:  ModifyPKG()
      .text!
      .smallNormal()
      .copyWith(color: ModifyPKG().color.text.withOpacity(0.8)),);
  }
}
