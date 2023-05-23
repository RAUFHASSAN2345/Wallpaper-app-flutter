import 'package:flutter/material.dart';

class App_Bar extends StatelessWidget {
  const App_Bar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RichText(
          text: const TextSpan(children: [
        TextSpan(
          text: 'My',
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
        ),
        TextSpan(
            text: ' Wallpaper',
            style: TextStyle(
                color: Colors.orangeAccent,
                fontSize: 20,
                fontWeight: FontWeight.w600))
      ])),
    );
  }
}
