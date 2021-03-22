import 'package:flutter/material.dart';
import 'package:spotted/pages/dashboard/dashboard_page.dart';

class SpottedApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DashboardPage(),
    );
  }
}
