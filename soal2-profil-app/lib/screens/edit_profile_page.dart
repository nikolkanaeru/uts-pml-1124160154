import 'package:flutter/material.dart';

import '../models/profile.dart';

class EditProfilePage extends StatefulWidget {
  final Profile profile;

  const EditProfilePage({super.key, required this.profile});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _namaCtrl;
  late final TextEditingController _nimCtrl;
  late final TextEditingController _prodiCtrl;
  late final TextEditingController _kelasCtrl;
  late final TextEditingController _emailCtrl;
  late final TextEditingController _hpCtrl;
  late final TextEditingController _githubCtrl;
  late final TextEditingController _bioCtrl;

  @override
  void initState() {
    super.initState();
    final p = widget.profile;
    _namaCtrl = TextEditingController(text: p.nama);
    _nimCtrl = TextEditingController(text: p.nim);
    _prodiCtrl = TextEditingController(text: p.prodi);
    _kelasCtrl = TextEditingController(text: p.kelas);
    _emailCtrl = TextEditingController(text: p.email);
    _hpCtrl = TextEditingController(text: p.hp);
    _githubCtrl = TextEditingController(text: p.github);
    _bioCtrl = TextEditingController(text: p.bio);
  }

  @override
  void dispose() {
    _namaCtrl.dispose();
    _nimCtrl.dispose();
    _prodiCtrl.dispose();
    _kelasCtrl.dispose();
    _emailCtrl.dispose();
    _hpCtrl.dispose();
    _githubCtrl.dispose();
    _bioCtrl.dispose();
    super.dispose();
  }

  void _simpan() {
    if (!_formKey.currentState!.validate()) return;

    final dataBaru = widget.profile.copyWith(
      nama: _namaCtrl.text.trim(),
      nim: _nimCtrl.text.trim(),
      prodi: _prodiCtrl.text.trim(),
      kelas: _kelasCtrl.text.trim(),
      email: _emailCtrl.text.trim(),
      hp: _hpCtrl.text.trim(),
      github: _githubCtrl.text.trim(),
      bio: _bioCtrl.text.trim(),
    );
    Navigator.pop(context, dataBaru);
  }

  Widget _field(
    TextEditingController ctrl,
    String label,
    IconData icon, {
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: ctrl,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: const OutlineInputBorder(),
        ),
        validator: validator,
      ),
    );
  }

  String? _wajib(String? v, String nama) =>
      (v == null || v.trim().isEmpty) ? '$nama wajib diisi' : null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profil')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _field(_namaCtrl, 'Nama Lengkap', Icons.person,
                    validator: (v) => _wajib(v, 'Nama')),
                _field(_nimCtrl, 'NIM', Icons.badge,
                    keyboardType: TextInputType.number,
                    validator: (v) => _wajib(v, 'NIM')),
                _field(_prodiCtrl, 'Program Studi', Icons.school,
                    validator: (v) => _wajib(v, 'Program studi')),
                _field(_kelasCtrl, 'Kelas', Icons.class_,
                    validator: (v) => _wajib(v, 'Kelas')),
                _field(
                  _emailCtrl,
                  'Email',
                  Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) {
                      return 'Email wajib diisi';
                    }
                    final valid = RegExp(r'^[\w.+-]+@[\w-]+(\.[\w-]+)+$')
                        .hasMatch(v.trim());
                    return valid ? null : 'Format email tidak valid';
                  },
                ),
                _field(
                  _hpCtrl,
                  'Nomor HP',
                  Icons.phone,
                  keyboardType: TextInputType.phone,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) {
                      return 'Nomor HP wajib diisi';
                    }
                    if (!RegExp(r'^\d{10,13}$').hasMatch(v.trim())) {
                      return 'Nomor HP harus angka 10-13 digit';
                    }
                    return null;
                  },
                ),
                _field(_githubCtrl, 'Akun GitHub', Icons.code,
                    validator: (v) => _wajib(v, 'Akun GitHub')),
                _field(_bioCtrl, 'Bio singkat', Icons.notes, maxLines: 3),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: FilledButton.icon(
                    onPressed: _simpan,
                    icon: const Icon(Icons.save),
                    label: const Text('Simpan'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}