import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';

class PhoneCodePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          PinFieldAutoFill()
        ],
      ),
    );
  }
}
