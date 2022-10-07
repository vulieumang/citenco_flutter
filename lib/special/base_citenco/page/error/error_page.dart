import 'dart:convert';
import 'dart:io';
import 'package:cnvsoft/core/base_core/base_appbar.dart';
import 'package:cnvsoft/core/base_core/base_page.dart';
import 'package:cnvsoft/core/base_core/data_mix.dart';
import 'package:cnvsoft/special/base_citenco/package/package.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_json_view/flutter_json_view.dart';
import 'error_provider.dart';

class ErrorPage extends StatefulWidget {
  final dynamic error;

  const ErrorPage({Key? key, this.error}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _ErrorPageState();
}

class _ErrorPageState extends BasePage<ErrorPage, ErrorProvider> with DataMix {
  @override
  void initState() {
    appBar = AppBarData.backArrow(context, text: "Error Page");
    super.initState();
  }

  @override
  ErrorProvider initProvider() => ErrorProvider(this);

  Map<String, dynamic> get errors {
    if (widget.error is DioError) {
      return {
        "base Url": BasePKG()
            .stringOf(() => (widget.error as DioError).requestOptions.baseUrl),
        "path": BasePKG()
            .stringOf(() => (widget.error as DioError).requestOptions.uri.path),
        "message": BasePKG().stringOf(() => (widget.error as DioError).message),
        "method": BasePKG()
            .stringOf(() => (widget.error as DioError).requestOptions.method),
        "query": BasePKG().dataOf(
            () => (widget.error as DioError).requestOptions.queryParameters,
            ""),
        "data": BasePKG()
            .dataOf((widget.error as DioError).requestOptions.data, ""),
        "status Message": BasePKG()
            .stringOf(() => (widget.error as DioError).response!.statusMessage!)
      };
    } else if (widget.error is TypeError) {
      return {
        "error": (widget.error as TypeError),
        "stack Trace":
            BasePKG().dataOf(() => (widget.error as TypeError).stackTrace, "")
      };
    } else if (widget.error is SocketException) {
      return {
        "error": (widget.error as SocketException),
        "message":
            BasePKG().stringOf(() => (widget.error as SocketException).message),
        "address": BasePKG()
            .stringOf(() => (widget.error as SocketException).address!.address),
        "port": BasePKG().intOf(() => (widget.error as SocketException).port!),
      };
    } else if (widget.error is NoSuchMethodError) {
      return {
        "error": (widget.error as NoSuchMethodError),
        "stack Trace": BasePKG()
            .dataOf(() => (widget.error as NoSuchMethodError).stackTrace, "")
      };
    } else if (widget.error is Map) {
      return (widget.error as Map<String, dynamic>);
    } else {
      return {"message": BasePKG().stringOf(() => widget.error.toString())};
    }
  }

  @override
  Widget body() {
    return ListView.builder(
      itemCount: errors.length,
      padding: EdgeInsets.all(12),
      itemBuilder: (context, index) {
        String title = errors.keys.toList()[index];
        dynamic content = errors.values.toList()[index];
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 6),
          child: Material(
            shape: RoundedRectangleBorder(),
            elevation: 2,
            child: ListTile(
              title: Text(title.toUpperCase()),
              subtitle: content is Map
                  ? JsonView.string(json.encode(content))
                  : Text(content.toString()),
            ),
          ),
        );
      },
    );
  }
}
