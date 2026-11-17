import 'package:flutter/material.dart';

import '../widgets/info_tile.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  static const _keahlianHobi = [
    (Icons.forum, 'Komunikasi'),
    (Icons.groups, 'Kerja sama tim'),
    (Icons.schedule, 'Manajemen waktu'),
    (Icons.sports_soccer, 'Futsal'),
    (Icons.sports_esports, 'Gaming'),
  ];

  static const _pendidikan = [
    ('Institut Teknologi & Bisnis Bina Sarana Global',
        'Teknik Informatika, 2024 - sekarang'),
    ('MA ELBAYAN', '2021 - 2024'),
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Tentang Saya')),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 1,
        onDestinationSelected: (index) {
          if (index == 0) Navigator.pop(context);
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.person), label: 'Profil'),
          NavigationDestination(
              icon: Icon(Icons.info_outline), label: 'Tentang'),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Keahlian & Hobi', style: textTheme.titleLarge),
          const SizedBox(height: 8),
          Card(
            child: Column(
              children: [
                for (final k in _keahlianHobi)
                  ListTile(
                    leading: Icon(k.$1),
                    title: Text(k.$2),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text('Riwayat Pendidikan', style: textTheme.titleLarge),
          const SizedBox(height: 8),
          Card(
            child: Column(
              children: [
                for (final p in _pendidikan)
                  InfoTile(icon: Icons.school, label: p.$1, value: p.$2),
              ],
            ),
          ),
        ],
      ),
    );
  }
}