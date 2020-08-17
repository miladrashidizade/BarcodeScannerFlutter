import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

class BarcodeProvider with ChangeNotifier {
  String result = "لطفا بارکدی را اسکن کنید";

  notifyListeners();

  Future scanQR() async {
    try {
      String qrResult = await BarcodeScanner.scan();
      result = qrResult;
      notifyListeners();
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.CameraAccessDenied) {
        result = "اجازه دوربین رد شد";
        notifyListeners();
      } else {
        result = "خطای ناشناخته $ex";
        notifyListeners();
      }
    } on FormatException {
      result = "شما قبل از اسکن هر چیزی دکمه عقب را فشار داده اید";
      notifyListeners();
    } catch (e) {
      result = "خطای ناشناخته $e";
      notifyListeners();
    }
  }
}
