import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme.dart';
import '../../../core/constants.dart';

class ColorSeedSelector extends ConsumerWidget {
  const ColorSeedSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeNotifier = ref.watch(themeNotifierProvider.notifier);

    return ListTile(
      leading: const Icon(Icons.color_lens),
      title: const Text('Tema Rengi'),
      trailing: DropdownButton<ColorSeed>(
        value: themeNotifier.colorSeed,
        items: ColorSeed.values
            .map((color) => DropdownMenuItem(
                  value: color,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: color.color,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(color.label)
                    ],
                  ),
                ))
            .toList(),
        onChanged: (color) {
          if (color != null) themeNotifier.setColorSeed(color);
        },
      ),
    );
  }
}
