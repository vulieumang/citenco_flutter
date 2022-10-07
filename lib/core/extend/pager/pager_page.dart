import 'dart:math';

import 'package:cnvsoft/core/base_core/base_page.dart';
import 'package:cnvsoft/base_citenco/package/package.dart';
import 'package:cnvsoft/base_citenco/modify/package.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pager_provider.dart';

abstract class PagerPageState<T extends StatefulWidget, S extends PagerProvider>
    extends BasePage<T, S> with TickerProviderStateMixin {
  ScrollPhysics scrollPhysics = BouncingScrollPhysics();

  TextStyle tabSelected = ModifyPKG()
      .text!
      .smallUpperNormal()
      .copyWith(color: ModifyPKG().color.primaryColor);

  TextStyle tabUnSelected = ModifyPKG()
      .text!
      .smallUpperNormal()
      .copyWith(color: ModifyPKG().color.text.withOpacity(0.6));

  // Color background = ModifyPKG().color.background;

  // Color backgroundTab = ModifyPKG().color.pagerTitleBackground;

  @override
  Widget body() {
    return Column(
      children: [
        AnimatedBuilder(
            animation: provider.headerCtr!,
            builder: (ctx, _) {
              return SizeTransition(
                  sizeFactor: provider.headerAni!, child: _buildHeader());
            }),
        _buildBody()
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      // decoration: BasePKG().decoration!.accentDecoration(),
      color: ModifyPKG().color.card,
      child: Column(
        children: <Widget>[
          if (provider.enablePageBar) ...[
            _buildTitlePager(),
            Consumer<AnimationPageNotifier>(
              builder: (context, value, child) {
                return Row(
                  children: List.generate(2, (index) {
                    Alignment _align = index == 0
                        ? Alignment.centerLeft
                        : Alignment.centerRight;
                    double _width = index == 0
                        ? (size.width * 0.5 * max(1.0 - value.value!, 0.0))
                        : (size.width * 0.5 * max(value.value!, 0.0));
                    return Expanded(
                      child: Container(
                          alignment: _align,
                          width: double.infinity,
                          child: Container(
                            height: 3.0,
                            width: _width,
                            color: tabSelected.color,
                          )),
                    );
                  }),
                );
              },
            )
          ]
        ],
      ),
    );
  }

  Widget _buildTitlePager() {
    return Consumer<PageNotifier>(
      builder: (context, value, child) {
        return Consumer2<FirstTitleNotifier, SecondTitleNotifier>(
          builder: (context, firstTitle, secondTitle, _) {
            var _titles = [firstTitle.value, secondTitle.value];
            return Row(
              children: List.generate(2, (index) {
                String _title = _titles[index]!;
                // TextStyle _style = index == value.value
                //     ? BaseTextStyle.tabSelected()
                //     : BaseTextStyle.tabUnSelected();
                TextStyle _style =
                    index == value.value ? tabSelected : tabUnSelected;
                return Expanded(
                  child: GestureDetector(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 16),
                            child: Text(_title,
                                textAlign: TextAlign.center, style: _style),
                          ),
                        ],
                      ),
                    ),
                    onTap: () => provider.jumpToPage(index),
                  ),
                );
              }).toList(),
            );
          },
        );
      },
    );
  }

  Widget _buildBody() {
    return Flexible(child: Consumer2<FirstPageNotifier, SecondPageNotifier>(
        builder: (context, first, second, child) {
      var pages = [first.value, second.value];
      return NotificationListener(
        onNotification: provider.scrollNotifer,
        child: PageView.builder(
          itemCount: pages.length,
          controller: provider.pageController,
          physics: scrollPhysics,
          onPageChanged: provider.setPage,
          itemBuilder: (BuildContext context, int index) {
            return pages[index]!.child!;
          },
        ),
      );
    }));
  }

  // @override
  // Widget buildBackground() {
  //   return Container(color: ModifyPKG().color.card);
  // }
}
