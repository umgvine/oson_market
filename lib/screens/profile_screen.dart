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
            _LanguageGroup(
              current: lang.currentLocale.languageCode,
              onChanged: (code) => lang.setLanguage(code),
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageGroup extends StatefulWidget {
  const _LanguageGroup({required this.current, required this.onChanged});
  final String current;
  final ValueChanged<String> onChanged;

  @override
  State<_LanguageGroup> createState() => _LanguageGroupState();
}

class _LanguageGroupState extends State<_LanguageGroup> {
  late String _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.current;
  }

  void _select(String value) {
    if (_selected == value) return;
    setState(() => _selected = value);
    widget.onChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          const ListTile(
            title: Text('Til (Language)'),
            subtitle: Text('RU / UZ / EN'),
          ),
          for (final item in const [
            ('ru', 'Русский'),
            ('uz', "O'zbekcha"),
            ('en', 'English'),
          ])
            ListTile(
              title: Text(item.$2),
              leading: Icon(
                _selected == item.$1
                    ? Icons.radio_button_checked
                    : Icons.radio_button_off,
                color: _selected == item.$1
                    ? Theme.of(context).colorScheme.primary
                    : null,
              ),
              onTap: () => _select(item.$1),
            ),
        ],
      ),
    );
  }
}
