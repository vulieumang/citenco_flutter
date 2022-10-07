import 'package:cnvsoft/core/base_core/base_page.dart';
import 'package:cnvsoft/core/base_core/base_search.dart';
import 'package:cnvsoft/core/extend/search/search_provider.dart';
import 'package:cnvsoft/special/base_citenco/package/package.dart';
import 'package:cnvsoft/special/base_citenco/package/trans.dart';
import 'package:cnvsoft/special/base_citenco/modify/package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

abstract class SearchPageState<T extends StatefulWidget,
    S extends SearchProvider, Z> extends BasePage<T, S> {
  Widget? buildHeader() => null;

  Widget? buildScrollHeader() => null;

  Widget? buildFooter() => null;

  Color backgroundList = ModifyPKG().color.card;
  EdgeInsets? padding;
  String? initMessage;
  String? emptyMessage;
  String? emptyQueryMessage;

  TextStyle messageStyle = ModifyPKG().text!.description();

  @override
  Widget body() {
    Widget? _header = buildHeader();
    Widget? _footer = buildFooter();
    Widget? _scrollHeader = buildScrollHeader();
    return WillPopScope(
      child: Column(
        children: <Widget>[
          _header ?? SizedBox(),
          Flexible(child: _buildList(_header, _scrollHeader)),
          if (_footer != null) _footer
        ],
      ),
      onWillPop: () async {
        provider.onWillPop();
        return true;
      },
    );
  }

  _buildList(Widget? _header, Widget? _scrollHeader) {
    return RefreshIndicator(
      key: GlobalKey<RefreshIndicatorState>(),
      onRefresh: provider.onRefresh,
      child: Stack(
        children: <Widget>[
          Consumer<SearchClientNotifier<Z>>(
            builder: (context, client, _) {
              if (client.value == null || !client.value!.hasData)
                return Column(
                  children: <Widget>[buildInit(), buildFooterList()],
                );
              return _buildCompleted(_scrollHeader, client.value?.items);
            },
          ),
          _buildLoading(),
        ],
      ),
    );
  }

  _buildCompleted(Widget? _scrollHeader, List<Z>? items) {
    if (items!.isEmpty) {
      if (provider.searchController.text.trim().isEmpty)
        return _buildEmptyQuery();
      else
        return _buildEmptyData();
    } else
      return _buildData(_scrollHeader, items);
  }

  buildInit() {
    return _buildMessage(initMessage ?? BaseTrans().$plsInputAddressSearch);
  }

  buildHeaderData() => SizedBox();

  Widget _buildMessage(String text) {
    return Column(
      children: <Widget>[
        Container(
          color: ModifyPKG().color.card,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 36, horizontal: 12),
          child: Text(text, style: messageStyle),
        )
      ],
    );
  }

  _buildData(Widget? _scrollHeader, List<Z>? list) {
    return Column(
      children: <Widget>[
        Flexible(
            child: ListView(
          padding: EdgeInsets.zero,
          physics: AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          children: <Widget>[
            buildHeaderData(),
            Container(
              color: backgroundList,
              child: ListView.separated(
                primary: false,
                itemCount: list!.length,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemBuilder: (BuildContext context, int index) {
                  if (_scrollHeader == null) {
                    return buildItemList(
                        list[index], index, provider.getCount() - 1 == index);
                  } else {
                    if (index == 0)
                      return _scrollHeader;
                    else
                      return buildItemList(list[index - 1], index,
                          provider.getCount() - 1 == index);
                  }
                },
                separatorBuilder: buildSeparator,
              ),
            ),
            buildFooterList()
          ],
        ))
      ],
    );
  }

  _buildLoading() {
    return Consumer<SearchLoadingNotifier>(
      builder: (context, loading, _) {
        if (loading.value!) {
          return Container(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: SpinKitFadingCircle(
                  color: BasePKG().color.primaryColor, size: 44),
            ),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }

  Widget? _buildEmptyData() {
    return Column(
      children: <Widget>[
        buildEmptyData() ??
            _buildMessage(emptyMessage ?? BaseTrans().$notFoundData),
        buildFooterList(),
      ],
    );
  }

  _buildEmptyQuery() {
    return Column(
      children: <Widget>[
        buildEmptyQuery() ??
            _buildMessage(emptyQueryMessage ?? BaseTrans().$bookingInitMessage),
        buildFooterList(),
      ],
    );
  }

  Widget? buildEmptyData() => null;

  Widget? buildEmptyQuery() => null;

  @override
  Widget buildBackground() {
    return Container(color: ModifyPKG().color.background);
  }

  Widget buildItemList(Z item, int index, bool isLast);

  Widget buildSeparator(BuildContext context, int index) {
    return SizedBox();
  }

  Widget buildFooterList() => SizedBox();
}
