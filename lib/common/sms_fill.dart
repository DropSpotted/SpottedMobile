import 'package:sms_autofill/sms_autofill.dart';

abstract class SmsFill {
  Future<void> listenForCode();
}

class SmsFillImpl implements SmsFill {
  SmsFillImpl({
    required SmsAutoFill smsAutoFill,
  }) : _smsAutoFill = smsAutoFill;

  final SmsAutoFill _smsAutoFill;

  @override
  Future<void> listenForCode() async {
    return _smsAutoFill.listenForCode;
  }
}
