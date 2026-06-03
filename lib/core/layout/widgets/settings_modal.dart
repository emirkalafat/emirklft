import 'package:flutter/material.dart';
import '../../../core/constants.dart';
import 'theme_switcher.dart';
import 'color_seed_selector.dart';

class SettingsModal extends StatelessWidget {
  const SettingsModal({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          const Icon(Icons.settings),
          const SizedBox(width: 8),
          const Text('Ayarlar'),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      content: SizedBox(
        width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const ThemeSwitcher(),
            const ColorSeedSelector(),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Lisanslar'),
              onTap: () {
                Navigator.pop(context);
                showAboutDialog(
                  context: context,
                  applicationVersion: AppConstants.appVersion,
                );
              },
            ),
            ListTile(
              enabled: false,
              leading: const Icon(Icons.bolt),
              title: Text(AppConstants.appVersion),
            ),
          ],
        ),
      ),
    );
  }
}
