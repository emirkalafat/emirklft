import 'package:flutter/material.dart';

class TopBarContents extends StatefulWidget {
  const TopBarContents({super.key});

  @override
  State<TopBarContents> createState() => _TopBarContentsState();
}

List<bool> isHovering = [
  false,
  false,
  false,
  false,
];

class _TopBarContentsState extends State<TopBarContents> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Spacer(),
        Text("Ahmet Emir Kalafat"),
        Spacer(),
        InkWell(
          onHover: (value) {
            setState(() {
              value ? isHovering[0] = true : isHovering[0] = false;
            });
          },
          onTap: () {}, //?Seçilen Sayfaya gitme özelliği eklenecek
          child: Text(
            "Hakkımda",
            style: TextStyle(
                color: isHovering[0] ? colorScheme.primary : Colors.black,
                decoration: isHovering[0]
                    ? TextDecoration.underline
                    : TextDecoration.none),
          ),
        ),
        Spacer(),
      ],
    );
  }
}
