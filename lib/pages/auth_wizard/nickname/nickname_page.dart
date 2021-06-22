import 'package:flutter/material.dart';

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
            child: const Text(
              'submit',
            ),
          )
        ],
      ),
    );
  }
}
