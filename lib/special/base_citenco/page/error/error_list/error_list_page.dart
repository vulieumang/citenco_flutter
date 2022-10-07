import 'package:cnvsoft/core/base_core/base_appbar.dart';
import 'package:cnvsoft/core/base_core/base_page.dart';

import 'package:cnvsoft/special/base_citenco/package/package.dart';
import 'package:cnvsoft/special/base_citenco/package/trans.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'error_list_provider.dart';

class ErrorListPage extends StatefulWidget {
  ErrorListPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ErrorListPageState();
}

class ErrorListPageState extends BasePage<ErrorListPage, ErrorListProvider> {
  @override
  void initState() {
    appBar = AppBarData.backArrow(context, text: "Error List");
    super.initState();
  }

  @override
  ErrorListProvider initProvider() => ErrorListProvider(this);

  @override
  Widget body() {
    return Consumer<ErrorsNotifier>(
      builder: (context, errors, _) {
        return errors.value!.isEmpty
            ? _buildEmptyData()
            : _buildErrorItem(errors.value!);
      },
    );
  }

  Widget _buildEmptyData() {
    return Container(
      color: BasePKG().color.card,
      width: double.infinity,
      padding: BasePKG().symmetric(horizontal: 20, vertical: 40),
      child: Text(
        BaseTrans().$noContent,
        textAlign: TextAlign.center,
        style: BasePKG()
            .text!
            .smallLowerNormal()
            .copyWith(color: BasePKG().color.description),
      ),
    );
  }

  Widget _buildErrorItem(List<String> errors) {
    return ListView.separated(
      padding: BasePKG().symmetric(horizontal: 20, vertical: 20),
      itemBuilder: (context, index) {
        var item = errors[index];
        return GestureDetector(
          onTap: () => provider.onShowErrorDetail(item),
          child: Container(
            decoration: BoxDecoration(
              color: BasePKG().color.card,
              borderRadius: BorderRadius.circular(5),
            ),
            child: IntrinsicHeight(
              child: Row(
                children: <Widget>[
                  _buildHeaderIcon(),
                  VerticalDivider(width: 1, color: BasePKG().color.line),
                  _buildContent(item),
                  _buildRemoveIcon(index)
                ],
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: 20);
      },
      itemCount: errors.length,
    );
  }

  Widget _buildHeaderIcon() {
    return Container(
      padding: BasePKG().all(5),
      child: SvgPicture.asset(
        "lib/special/base_citenco/asset/image/systems.svg",
        color: BasePKG().color.invertTextColor,
        width: 30,
        height: 30,
      ),
    );
  }

  Widget _buildContent(String content) {
    return Expanded(
      child: Container(
        padding: BasePKG().symmetric(horizontal: 10, vertical: 5),
        child: Text(
          provider.getContent(content),
          style: BasePKG().text!.smallLowerNormal(),
          maxLines: 10,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget _buildRemoveIcon(int index) {
    return GestureDetector(
      onTap: () => provider.onRemoveItem(index),
      child: Container(
        padding: BasePKG().symmetric(horizontal: 8),
        color: Colors.transparent,
        child: Icon(
          Icons.delete_outline,
          color: BasePKG().color.red,
        ),
      ),
    );
  }
}
