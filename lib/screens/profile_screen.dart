import 'package:flutter/material.dart';
import '../app.dart';
import 'language_provider.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = context.watch<LanguageProvider>();
    final theme = Theme.of(context);

    Widget themeTile(ThemeMode mode, String label, IconData icon) {
      final selected = appThemeMode.value == mode;
      return ListTile(
        leading: Icon(icon, color: selected ? theme.colorScheme.primary : null),
        title: Text(label),
        trailing: selected
            ? const Icon(Icons.check_circle, color: Colors.green)
            : const Icon(Icons.circle_outlined),
        onTap: () => appThemeMode.value = mode,
      );
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(12),
          children: [
            Card(
              child: Column(
                children: [
                  const ListTile(
                    title: Text('Tasma mavzusi (Theme Mode)'),
                    subtitle: Text('Sistem, Yorug\' yoki Qorong\'i'),
                  ),
                  themeTile(
                    ThemeMode.system,
                    'Tizim (System)',
                    Icons.phone_android,
                  ),
                  const Divider(height: 1),
                  themeTile(
                    ThemeMode.light,
                    'Yorug\' (Light)',
                    Icons.light_mode,
                  ),
                  const Divider(height: 1),
                  themeTile(
                    ThemeMode.dark,
                    'Qorong\'i (Dark)',
                    Icons.dark_mode,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: Column(
                children: [
                  const ListTile(
                    title: Text('Til (Language)'),
                    subtitle: Text('RU / UZ / EN'),
                  ),
                  RadioListTile<String>(
                    value: 'ru',
                    groupValue: lang.currentLocale.languageCode,
                    title: const Text('Русский'),
                    onChanged: (v) => lang.setLanguage(v!),
                  ),
                  RadioListTile<String>(
                    value: 'uz',
                    groupValue: lang.currentLocale.languageCode,
                    title: const Text("O'zbekcha"),
                    onChanged: (v) => lang.setLanguage(v!),
                  ),
                  RadioListTile<String>(
                    value: 'en',
                    groupValue: lang.currentLocale.languageCode,
                    title: const Text('English'),
                    onChanged: (v) => lang.setLanguage(v!),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
