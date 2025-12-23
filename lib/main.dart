import 'package:flutter/material.dart';

void main() {
  runApp(const HamburgerMenuApp());
}

class HamburgerMenuApp extends StatelessWidget {
  const HamburgerMenuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hamburger Menu Sample',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MenuHomePage(),
    );
  }
}

class MenuHomePage extends StatefulWidget {
  const MenuHomePage({super.key});

  @override
  State<MenuHomePage> createState() => _MenuHomePageState();
}

class _MenuHomePageState extends State<MenuHomePage> {
  final List<_MenuItem> _menuItems = const [
    _MenuItem(
      title: 'Home',
      icon: Icons.home_outlined,
      description: 'Welcome section with quick tips.',
    ),
    _MenuItem(
      title: 'Profile',
      icon: Icons.person_outline,
      description: 'See your information and progress.',
    ),
    _MenuItem(
      title: 'Settings',
      icon: Icons.settings_outlined,
      description: 'Adjust preferences for the app.',
    ),
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final _MenuItem selected = _menuItems[_selectedIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(selected.title),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.primaryContainer,
                  ],
                ),
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Flutter Drawer',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),
            ..._menuItems.asMap().entries.map(
              (entry) => ListTile(
                leading: Icon(entry.value.icon),
                title: Text(entry.value.title),
                subtitle: Text(entry.value.description),
                selected: entry.key == _selectedIndex,
                selectedColor: Theme.of(context).colorScheme.primary,
                onTap: () {
                  setState(() => _selectedIndex = entry.key);
                  Navigator.pop(context);
                },
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: FilledButton.icon(
                icon: const Icon(Icons.logout),
                label: const Text('Close Menu'),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              selected.title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(selected.description),
            const SizedBox(height: 24),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          selected.icon,
                          size: 32,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          '${selected.title} card',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'This content updates when you pick different menu items from the hamburger drawer.',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: const [
                        Chip(label: Text('Drawer')),
                        Chip(label: Text('ListTile')),
                        Chip(label: Text('Card')),
                        Chip(label: Text('FilledButton')),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuItem {
  const _MenuItem({
    required this.title,
    required this.icon,
    required this.description,
  });

  final String title;
  final IconData icon;
  final String description;
}
