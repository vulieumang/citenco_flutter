import 'package:cnvsoft/core/base_core/base_view.dart';
import 'package:cnvsoft/core/view/loading_more.dart';
import 'package:cnvsoft/special/base_citenco/mix/profile_mix.dart';
import 'package:cnvsoft/special/base_citenco/package/package.dart';
import 'package:cnvsoft/special/base_citenco/package/trans.dart';
import 'package:cnvsoft/special/base_citenco/modify/package.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'load_more_provider.dart';

abstract class LoadMoreViewState<
    T extends StatefulWidget,
    S extends LoadMoreProvider,
    Z> extends BaseView<T, S> with TickerProviderStateMixin {
  Color backgroundList = ModifyPKG().color.background;
  Color backgroundCard = ModifyPKG().color.card;
  Color background = ModifyPKG().color.background;
  Color color = ModifyPKG().color.primaryColor;
  TextStyle messageStyle = ModifyPKG().text!.description();
  EdgeInsets? padding;

  Widget? buildHeader() => null;

  Widget? buildScrollHeader() => null;

  Widget? buildFooter() => null;

  Widget? buildUnderList() => null;

  bool? ischeckAppBar = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget body() {
    Widget? _footer = buildFooter();
    Widget? _header = buildHeader();
    return Column(
      children: <Widget>[
        _header ?? SizedBox(),
        Expanded(
          child: Stack(
            children: <Widget>[
              _buildList(),
              _buildLoadMoreTile(),
              _buildScrollToTop()
            ],
          ),
        ),
        if (_footer != null) _footer,
      ],
    );
  }

  _buildLoadMoreTile() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        AnimatedBuilder(
          animation: provider.loadMore!.animation,
          builder: (context, _) {
            return Visibility(
                visible: provider.loadMore!.animation.value != 0,
                child: SizeTransition(
                  sizeFactor: provider.loadMore!.animation,
                  child: SafeArea(
                      child: Container(
                    alignment: Alignment.bottomCenter,
                    color: Colors.transparent,
                    padding: EdgeInsets.all(12),
                    child: LoadingMoreView(color: this.color),
                  )),
                ));
          },
        )
      ],
    );
  }

  _buildList() {
    return provider.enableRefresh && !ischeckAppBar!
        ? RefreshIndicator(
            key: provider.refreshIndicator,
            onRefresh: provider.onRefresh,
            color: BasePKG().color.background,
            child: _buildListBody(),
          )
        : _buildListBody();
  }

  _buildListBody() {
    final Widget? _header = buildHeader();
    final Widget? _scrollHeader = buildScrollHeader();
    return Consumer3<LoadingStatusNotifier, EmptyNotifier, ISScrollToTop>(
      builder: (context, value, empty, isScoll, child) {
        var _length = provider.getCount() + (_scrollHeader == null ? 0 : 1) + 1;
        return Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              color: BasePKG().color.background,
              child: Column(
                children: <Widget>[
                  Flexible(
                    child: Container(
                      color: BasePKG().color.background,
                      child: LayoutBuilder(builder: (context, contrants) {
                        return NotificationListener(
                          onNotification: (notificationInfo) {
                            if (notificationInfo is ScrollStartNotification) {
                              if (ischeckAppBar!) {
                                // if (contrants.biggest.height <= 545) {
                                //   print("listen");
                                //   print(" isScoll.value ${isScoll.value}");
                                //   print(
                                //       "contrants.biggest.height ${contrants.biggest.height}");
                                //   if (_length <= 2) {
                                //     isScoll.value = false;
                                //     // provider.scrollToTop();
                                //   }
                                //   // if (provider.loadMore!.controller.offset <=
                                //   //         provider.loadMore!.controller.position
                                //   //             .minScrollExtent &&
                                //   //     !provider.loadMore!.controller.position
                                //   //         .outOfRange) {
                                //   //   print("ontop");
                                //   //   isScoll.value = false;
                                //   // }
                                // }
                              }
                            }
                            return true;
                          },
                          child: AnimatedList(
                            controller: provider.loadMore!.controller,
                            key: provider.loadMore!.key,
                            shrinkWrap: true,
                            initialItemCount: _length,
                            padding: (_isEmptyList || empty.value!
                                ? EdgeInsets.zero
                                : (this.padding ??
                                    EdgeInsets.only(bottom: 12))),
                            physics: AlwaysScrollableScrollPhysics(),
                            // isScoll.value!
                            //     ? AlwaysScrollableScrollPhysics()
                            //     : NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index, animation) {
                              if (index == _length - 1) {
                                return Consumer<EmptyNotifier>(
                                  builder: (context, value, _) {
                                    return Visibility(
                                      visible:
                                          ((value.value! || _isEmptyList) &&
                                              provider.showEmpty),
                                      child: buildNothingView(),
                                    );
                                  },
                                );
                              } else
                                return _buildItem(
                                    context,
                                    index,
                                    Tween<double>(begin: 1, end: 1)
                                        .animate(animation));
                            },
                          ),
                        );
                      }),
                    ),
                  ),
                  if (buildUnderList() != null) ...[buildUnderList()!]
                ],
              ),
            ),
            if (provider.isRefreshingStatus) ...[
              Container(color: Colors.transparent)
            ]
          ],
        );
      },
    );
  }

  bool get _isEmptyList {
    Widget? _scrollHeader = buildScrollHeader();
    if (_scrollHeader == null) {
      return provider.getCount() < 0;
    } else {
      return provider.getCount() < 1;
    }
  }

  Widget buildItemList(Z item, Animation<double> animation, int index);

  @override
  void dispose() {
    // TODO: implement dispose
    provider.loadMore!.animationController.dispose();
    super.dispose();
  }

  Widget _buildItem(
      BuildContext context, int index, Animation<double> animation) {
    Widget? _scrollHeader = buildScrollHeader();
    if (_scrollHeader == null) { 
      Z _item ;
      if( provider.getList().length == 1){
        _item = provider.getList()[0];
      }else _item = provider.getList()[index];
      bool _isLast = provider.getCount() - 1 == index;
      return Column(
        children: <Widget>[
          buildItemList(_item, animation, index),
          if (!_isLast) buildSperator(),
        ],
      );
    } else {
      if (index == 0)
        return _scrollHeader;
      else {
        Z _item = provider.getList()[0];
        if( provider.getList().length > 1){
          _item = provider.getList()[index-1];
        }
        bool _isLast = provider.getCount() == index;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            buildItemList(_item, animation, index),
            if (!_isLast) buildSperator(),
          ],
        );
      }
    }
  }

  Widget buildNothingView() => GestureDetector(
        child: Container(
          color: this.backgroundCard,
          child: Column(children: <Widget>[
            SizeTransition(
              sizeFactor: provider.loginAnimation,
              child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                  color: Color(0xffff8800),
                  child: Text(BaseTrans().$mustLogin,
                      style: this
                          .messageStyle
                          .copyWith(color: Colors.white, fontSize: 10))),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 42),
              child: Text(BaseTrans().$noContent, style: this.messageStyle),
            ),
          ]),
        ),
        onTap: () async {
          if (MyProfile().isGuest) {
            BasePKG().bus!.fire<DashboardData>(
                DashboardData("request_login", data: context));
          }
        },
      );

  Widget buildSperator() => SizedBox();

  _buildScrollToTop() {
    return Consumer<ShowScrollToTop>(
      builder: (context, value, _) {
        return Visibility(
          visible: value.value!,
          child: Positioned(
              bottom: 16,
              right: 16,
              child: GestureDetector(
                onTap: provider.scrollToTop,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(21),
                  child: Container(
                    width: 42,
                    height: 42,
                    decoration:
                        BoxDecoration(color: BasePKG().color.card, boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 20,
                        spreadRadius: 0,
                        offset: Offset(0, 2),
                      )
                    ]),
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Image.asset(
                        "lib/core/asset/image/ic_scroll_top.png",
                        width: 16,
                        height: 18,
                        color: BasePKG().color.primaryColor,
                      ),
                    ),
                  ),
                ),
              )),
        );
      },
    );
  }
}
