import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            child: Icon(
              Icons.error_outline_sharp,
              color: Theme.of(context).errorColor,
            ),
          ),
          Container(
            child: Text(
              "Algo de errado não está certo",
              style: TextStyle(color: Theme.of(context).errorColor),
            ),
          ),
        ],
      ),
    );
  }
}
