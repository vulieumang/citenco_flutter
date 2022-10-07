import 'package:cnvsoft/core/base_core/base_appbar.dart';
import 'package:cnvsoft/core/base_core/base_page.dart';
import 'package:cnvsoft/core/base_core/data_mix.dart';

import 'package:cnvsoft/base_citenco/package/trans.dart';
import 'package:flutter/material.dart';
import 'blank_provider.dart';

class BlankPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BlankPageState();
}

class _BlankPageState extends BasePage<BlankPage, BlankProvider> with DataMix {
  @override
  void initState() {
    appBar = AppBarData.backArrow(context,text: BaseTrans().$blankPage);
    super.initState();
  }

  @override
  BlankProvider initProvider() => BlankProvider(this);

  @override
  Widget body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Text(BaseTrans().$blankPage)],
        )
      ],
    );
  }
}
