import 'package:flutter/material.dart';

import '../widgets/info_tile.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  static const _keahlian = [
    ('Pemrograman', 'Membuat aplikasi atau web'),
    ('Teamwork', 'Mampu bekerja sama sebagai tim'),
    ('Komunikasi', 'Menyampaikan ide dengan jelas, lisan maupun tulisan'),
  ];

  static const _pendidikan = [
    ('SD Negeri Sukatani VI', '2012 - 2018'),
    ('SMP Negeri ...', '2018 - 2021'),
    ('SMA/SMK ...', '2021 - 2024'),
    ('Institut Teknologi & Bisnis Bina Sarana Global', '2024 - sekarang'),
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Tentang Saya')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Keahlian & Hobi', style: textTheme.titleLarge),
          const SizedBox(height: 8),
          Card(
            child: Column(
              children: [
                for (final k in _keahlian)
                  InfoTile(icon: Icons.star, label: k.$1, value: k.$2),
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