import 'package:flutter/material.dart';
import 'package:spotted/router/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';

class NicknamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextFormField(),
          ElevatedButton(
            onPressed: () => {},
            child: Text(
              'submit',
            ),
          )
        ],
      ),
    );
  }
}
