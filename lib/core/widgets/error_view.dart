import 'package:flutter/material.dart';


class ErrorView extends StatelessWidget {
  final String title;

  const ErrorView(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.signal_wifi_connected_no_internet_4_outlined,color: Colors.orangeAccent,size: 40,),
            Text(
              title,
              style: TextStyle(color: Colors.orange, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
