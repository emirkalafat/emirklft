import 'package:flutter/material.dart';

import 'glossy_content.dart';

class AvatarAndTextBox extends StatelessWidget {
  const AvatarAndTextBox({
    Key? key,
    required this.screenSize,
  }) : super(key: key);

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 1200,
        child: Column(
          children: [
            Image.asset(
              'assets/images/avatarKare.png',
              width: 100,
            ),
            Spacer(),
            GlassContent(screenSize: screenSize),
            Spacer(flex: 3),
          ],
        ));
  }
}
