import 'package:flutter/material.dart';

class LoadMoreAnimation {
  final GlobalKey<AnimatedListState> _listAnimatedKey =
      GlobalKey<AnimatedListState>();
  final ScrollController _controller = ScrollController();
  Animation<double>? _animation;
  AnimationController? _animtionController;
  Function()? _onLoadMore;
  Function()? _onScroll;
  Function(int index)? _onRemoveItem;
  Function? _onMounted;
  bool lockLoadMore = false;

  LoadMoreAnimation(
    TickerProviderStateMixin ticker, {
    required Function(GlobalKey<AnimatedListState> key)? onLoadMore,
    Function(int index)? onRemoveItem,
    required Function()? onScroll,
    required Function()? onMounted,
  }) {
    this._onMounted = onMounted;
    this._onRemoveItem = onRemoveItem;
    this._onScroll = onScroll;
    _animtionController = AnimationController(
        vsync: ticker, duration: Duration(milliseconds: 300));
    _animation = CurvedAnimation(
        curve: Curves.linearToEaseOut, parent: _animtionController!);

    this._onLoadMore = () async {
      if (_isNotLoadingMore &&
          !_animtionController!.isAnimating &&
          !lockLoadMore) {
        _showLoadingMore();
        await onLoadMore!(_listAnimatedKey);
        _hideLoadingMore();
      }
    };

    _controller.addListener(() {
      if (_controller.position.maxScrollExtent != 0 &&
          _controller.offset > 0 &&
          _controller.offset >= _controller.position.maxScrollExtent - 100) {
        if (onMounted!()) this._onLoadMore!();
      }

      this._onScroll!();
    });
  }

  bool get _isNotLoadingMore => this._animtionController?.value == 0;

  GlobalKey<AnimatedListState> get key => this._listAnimatedKey;

  ScrollController get controller => this._controller;

  Animation<double> get animation => this._animation!;

  AnimationController get animationController => this._animtionController!;

  void _showLoadingMore() {
    if (_onMounted!()) this._animtionController?.forward(from: 0.0);
  }

  void _hideLoadingMore() {
    if (_onMounted!()) this._animtionController?.reverse(from: 1.0);
  }

  void clear(int length) {
    if (_onRemoveItem == null) {
      print("Please set onRemoveItem");
    } else {
      controller.jumpTo(0);
      for (int i = length - 1; i >= 0; i--) {
        _onRemoveItem!(i);
        key.currentState?.removeItem(i, (context, animation) {
          return Container();
        });
      }
    }
  }
}
