import 'package:cnvsoft/base_citenco/package/package.dart';
import 'package:cnvsoft/base_citenco/package/trans.dart';
import 'package:cnvsoft/base_citenco/page/scan_car/qr_flutter/qr_flutter_provider.dart';
import 'package:cnvsoft/core/base_core/base_appbar.dart';
import 'package:cnvsoft/core/base_core/base_page.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

enum QrFlutterScanType { DEFAULT, QRCODE, BARCODE }

class QrFlutterPage extends StatefulWidget {
  final QrFlutterScanType? qrFlutterScanType;
  // final bool? resumeCamera;
  // final BarcodeValueCallback? scanData;

  QrFlutterPage({Key? key, this.qrFlutterScanType = QrFlutterScanType.QRCODE})
      : assert(qrFlutterScanType != null),
        super(key: key);

  @override
  QrFlutterPageState createState() => QrFlutterPageState();

  ///  Use this method to start BarCode and QRCode scanning and get result the Callback [Barcode] on scanData.
  ///
  /// The [Barcode] object holds information about the barcode or qr code.
  ///
  /// [code] is the content of the barcode.
  /// [format] displays which type the code is.
  /// Only for Android, [rawBytes] gives a list of bytes of the result.
  ///
  /// Please import package:qr_code_scanner/qr_code_scanner.dart.
  ///
  /// Code example:
  ///
  ///  QrFlutterPage.scanDefault(
  ///      state,
  ///      scanData: (scanData){},
  ///  );
  static Future<Barcode> scanDefault(State state,
      {required BarcodeValueCallback? scanData}) async {
    return await showDialog(
        context: state.context,
        builder: (context) {
          return QrFlutterPage(qrFlutterScanType: QrFlutterScanType.DEFAULT);
        });
  }

  ///  Use this method to start BarCode scanning and get result the [Barcode].
  ///
  /// The [Barcode] object holds information about the barcode or qr code.
  ///
  /// [code] is the content of the barcode.
  /// [format] displays which type the code is.
  /// Only for Android, [rawBytes] gives a list of bytes of the result.
  ///
  /// Please import package:qr_code_scanner/qr_code_scanner.dart.
  ///
  /// Code example:
  ///
  ///  QrFlutterPage.scanBarCode(
  ///      state,
  ///      scanData: (scanData){},
  ///  );
  static Future<Barcode> scanBarCode(State state,
      {required BarcodeValueCallback? scanData}) async {
    return await showDialog(
        context: state.context,
        builder: (context) {
          return QrFlutterPage(qrFlutterScanType: QrFlutterScanType.BARCODE);
        });
  }

  ///  Use this method to start BarCode and QRCode scanning and get result the [Barcode].
  ///
  /// The [Barcode] object holds information about the barcode or qr code.
  ///
  /// [code] is the content of the barcode.
  /// [format] displays which type the code is.
  /// Only for Android, [rawBytes] gives a list of bytes of the result.
  ///
  /// Please import package:qr_code_scanner/qr_code_scanner.dart.
  ///
  /// Code example:
  ///
  ///  QrFlutterPage.scanQrCode(
  ///      state,
  ///      scanData: (scanData){},
  ///  );
  static Future<Barcode> scanQrCode(State state,
      {required BarcodeValueCallback? scanData}) async {
    return await showDialog(
        context: state.context,
        builder: (context) {
          return QrFlutterPage(qrFlutterScanType: QrFlutterScanType.QRCODE);
        });
  }
}

class QrFlutterPageState extends BasePage<QrFlutterPage, QrFlutterProvider> {
  @override
  void initState() {
    super.initState();
    appBar = AppBarData(context,
        height: 60,
        title: Text(
          "Quét xe vào trạm",
          style: BasePKG().text!.normalNormal().copyWith(color: Colors.white),
          maxLines: 2,
          textAlign: TextAlign.center,
        ));
  }

  @override
  void didUpdateWidget(QrFlutterPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    // if (BasePKG().boolOf(() =>
    //     widget.resumeCamera != null &&
    //     oldWidget.resumeCamera != widget.resumeCamera)) {
    // provider.onOpenCamera(true);
    // }
  }

  @override
  Widget buildBackground() {
    return Container(color: Colors.white);
  }

  @override
  Widget body() {
    return Consumer<PermissionStatusNotifier>(builder: (context, value, child) {
      return value.value != PermissionStatus.granted
          ? _permisstionFalse()
          : _showScanCamera();
    });
  }

  Widget _permisstionFalse() {
    return Column(children: <Widget>[
      Expanded(
          child: GestureDetector(
        onTap: () => provider.showPermissionRequest(),
        child: Container(
          width: double.infinity,
          color: BasePKG().color.accentColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(BaseTrans().$permissionCamera,
                  style: BasePKG().text!.smallUpperNormal()),
              // Text(QrFlutterTrans().$permisstionMess1,
              //     style: QrFlutterPKG().text.smallUpperNormal()),
            ],
          ),
        ),
      )),
    ]);
  }

  Widget _showScanCamera() {
    return Container(
      height: size.height,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image.asset(
            "lib/base_citenco/asset/image/bg_home_bottom.png",
            width: size.width,
          ),
          Container(
            height: size.height,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Bạn vui lòng tìm có QR Code Xe. Sau đó quay hình vào màn hình có camera quét tự động.",
                    style: BasePKG()
                        .text!
                        .largeNormal()
                        .copyWith(color: Colors.black.withOpacity(.7)),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    height: 250,
                    width: 250,
                    child: QRView(
                      key: provider.qrKey,
                      onQRViewCreated: provider.onQRViewCreated,
                      formatsAllowed: provider.formatsAllowed,
                      overlay: QrScannerOverlayShape(
                        borderColor: Color(0xffE8E1E1),
                        borderRadius: 30,
                        borderLength: 130,
                        borderWidth: 13,
                        overlayColor: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      margin: EdgeInsets.symmetric(
                        horizontal: 40,
                      ),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Color(0xffD1E0ED),
                          borderRadius: BorderRadius.circular(15)),
                      child: Consumer<CountDownNotifier>(
                          builder: (context, count, _) {
                        return RichText(
                            text: TextSpan(
                                text: "Quét QRCode (",
                                style: BasePKG()
                                    .text!
                                    .captionNormal()
                                    .copyWith(color: Color(0xff004D99)),
                                children: [
                                  TextSpan(
                                      text: count.value.toString(),
                                      style: BasePKG()
                                          .text!
                                          .captionNormal()
                                          .copyWith(color: Color(0xff004D99))),
                                  TextSpan(
                                      text: ")",
                                      style: BasePKG()
                                          .text!
                                          .captionNormal()
                                          .copyWith(color: Color(0xff004D99)))
                                ]),
                            textAlign: TextAlign.center);
                      })),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  QrFlutterProvider initProvider() => QrFlutterProvider(this);
}
