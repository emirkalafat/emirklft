import 'package:flutter/material.dart';

class MyBody extends StatelessWidget {
  const MyBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Center(
                    child: Text("Ahmet Emir Kalafat"),
                  ),
                  Center(
                    child: Text("Ahmet Emir Kalafat"),
                  ),
                ],
              ),
              const Center(
                child: Text("Ahmet Emir Kalafat"),
              ),
            ],
          ),
        ),
        Flexible(
          flex: 1,
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer),
            child: const Text("ahmet"),
          ),
        )
      ],
    );
  }
}
