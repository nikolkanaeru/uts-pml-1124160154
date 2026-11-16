import 'package:flutter/material.dart';

import '../models/profile.dart';
import '../widgets/info_tile.dart';
import 'edit_profile_page.dart'; 

class ProfilePage extends StatefulWidget {
  final bool isDark;
  final VoidCallback onToggleTheme;

  const ProfilePage({
    super.key,
    required this.isDark,
    required this.onToggleTheme,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Profile _profile = const Profile(
    nama: 'Muhamad Azmi Ma'mun',
    nim: '1124160154',
    prodi: 'Teknik Informatika',
    kelas: 'TI SE M 2024',
    email: 'mazmimamun@gmail.com',
    hp: '08231807985',
    github: 'https://github.com/nikolkanaeru/',
    bio: 'yang ini teknik baik',
  );

  Future<void> _editProfile() async {
    final result = await Navigator.push<Profile>(
      context,
      MaterialPageRoute(builder: (_) => EditProfilePage(profile: _profile)),
    );
    if (result != null) {
      setState(() => _profile = result);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profil berhasil diperbarui')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Mahasiswa'),
        actions: [
          IconButton(
            tooltip: 'Mode gelap',
            icon: Icon(widget.isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: widget.onToggleTheme,
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(_profile.nama),
              accountEmail: Text(_profile.email),
              currentAccountPicture: const CircleAvatar(
                backgroundImage: AssetImage('assets/images/profile_photo.jpg'),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profil'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Tentang Saya'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/about');
              },
            ),
            SwitchListTile(
              secondary: const Icon(Icons.dark_mode),
              title: const Text('Mode Gelap'),
              value: widget.isDark,
              onChanged: (_) => widget.onToggleTheme(),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Keluar'),
              onTap: () =>
                  Navigator.pushNamedAndRemoveUntil(context, '/login', (r) => false),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _editProfile,
        icon: const Icon(Icons.edit),
        label: const Text('Edit Profil'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/images/profile_photo.jpg'),
              ),
              const SizedBox(height: 16),
              Text(_profile.nama,
                  style: textTheme.headlineSmall, textAlign: TextAlign.center),
              const SizedBox(height: 4),
              Text('NIM: ${_profile.nim}', style: textTheme.bodyMedium),
              Text('${_profile.prodi} - Kelas ${_profile.kelas}',
                  style: textTheme.bodyMedium, textAlign: TextAlign.center),
              const SizedBox(height: 16),
              Text(_profile.bio,
                  style: textTheme.bodyLarge, textAlign: TextAlign.center),
              const SizedBox(height: 16),
              Card(
                child: Column(
                  children: [
                    InfoTile(
                        icon: Icons.email,
                        label: 'Email',
                        value: _profile.email),
                    InfoTile(
                        icon: Icons.phone,
                        label: 'Nomor HP',
                        value: _profile.hp),
                    InfoTile(
                        icon: Icons.code,
                        label: 'GitHub',
                        value: _profile.github),
                  ],
                ),
              ),
              const SizedBox(height: 80), 
            ],
          ),
        ),
      ),
    );
  }
}