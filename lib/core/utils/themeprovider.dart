import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDark = false;

  bool get isDark => _isDark;

  void toggleTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }
}

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return IconButton(
      icon: Icon(
        themeProvider.isDark ? Icons.dark_mode : Icons.light_mode,
        color: themeProvider.isDark ? Colors.yellow : Colors.black,
      ),
      onPressed: () {
        themeProvider.toggleTheme();
      },
      tooltip: themeProvider.isDark
          ? 'Switch to Light Mode'
          : 'Switch to Dark Mode',
    );
  }
}
