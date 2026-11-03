
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final List<Map<String, String>> orders;

  const ProfilePage({
    super.key,
    required this.orders,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final Color beige = const Color(0xFFF3EBDD);
  final Color dark = const Color(0xFF292522);
  final Color background = const Color(0xFFFAF8F4);

  String currentPage = 'Profil';

  // Data pribadi disimpan di halaman utama profil
  String namaPengguna = 'Pengguna StyleUp';
  String usernamePengguna = 'styleup_user';
  String emailPengguna = 'user@styleup.com';
  String teleponPengguna = '081234567890';
  String genderPengguna = 'Perempuan';
  String tanggalLahirPengguna = 'Belum diatur';

  void bukaHalaman(String halaman) {
    setState(() {
      currentPage = halaman;
    });
  }

  void kembaliProfil() {
    setState(() {
      currentPage = 'Profil';
    });
  }

  void pesan(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        centerTitle: true,
        leading: currentPage == 'Profil'
            ? null
            : IconButton(
                icon: const Icon(Icons.arrow_back),
                color: dark,
                onPressed: kembaliProfil,
              ),
        title: Text(
          currentPage,
          style: TextStyle(
            color: dark,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: currentPage == 'Profil'
          ? halamanProfil()
          : currentPage == 'Pesanan Saya'
              ? halamanPesanan()
              : currentPage == 'Informasi Pribadi'
                  ? halamanInformasi()
                  : halamanAlamat(),
    );
  }

  // ================= HALAMAN PROFIL =================

  Widget halamanProfil() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: beige,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 35,
                backgroundColor: Colors.white,
                backgroundImage: const AssetImage(
                  'assets/images/profil.png',
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      namaPengguna,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      emailPengguna,
                      style: const TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                    Text(
                      '@$usernamePengguna',
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.edit_outlined),
            ],
          ),
        ),

        const SizedBox(height: 25),

        const Text(
          'Akun Saya',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 12),

        menuProfil(
          Icons.shopping_bag_outlined,
          'Pesanan Saya',
          'Lihat status dan riwayat pesanan',
        ),

        menuProfil(
          Icons.person_outline,
          'Informasi Pribadi',
          'Atur informasi akun kamu',
        ),

        menuProfil(
          Icons.location_on_outlined,
          'Alamat Pengiriman',
          'Atur alamat tujuan pengiriman',
        ),

        const SizedBox(height: 25),

        const Text(
          'Pengaturan',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 12),

        ListTile(
          leading: const Icon(Icons.notifications_none),
          title: const Text('Notifikasi'),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 16,
          ),
          onTap: () => pesan('Pengaturan notifikasi'),
        ),

        ListTile(
          leading: const Icon(Icons.help_outline),
          title: const Text('Pusat Bantuan'),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 16,
          ),
          onTap: () => pesan('Pusat bantuan StyleUp'),
        ),

        ListTile(
          leading: const Icon(Icons.info_outline),
          title: const Text('Tentang StyleUp'),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 16,
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Tentang StyleUp'),
                content: const Text(
                  'StyleUp adalah aplikasi belanja fashion '
                  'untuk menemukan pakaian, sepatu, tas, '
                  'dan aksesoris favorit kamu.',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Tutup'),
                  ),
                ],
              ),
            );
          },
        ),

        const SizedBox(height: 20),

        OutlinedButton.icon(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Keluar Akun'),
                content: const Text(
                  'Apakah kamu yakin ingin keluar?',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Batal'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      pesan('Fitur logout belum terhubung');
                    },
                    child: const Text(
                      'Keluar',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            );
          },
          icon: const Icon(
            Icons.logout,
            color: Colors.red,
          ),
          label: const Text(
            'Keluar',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }

  Widget menuProfil(
    IconData icon,
    String title,
    String subtitle,
  ) {
    return Card(
      color: Colors.white,
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 7,
        ),
        leading: CircleAvatar(
          backgroundColor: beige,
          child: Icon(icon, color: dark),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (title == 'Pesanan Saya' &&
                widget.orders.isNotEmpty)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 9,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${widget.orders.length}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            const SizedBox(width: 8),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
            ),
          ],
        ),
        onTap: () => bukaHalaman(title),
      ),
    );
  }

  // ================= HALAMAN PESANAN =================

  Widget halamanPesanan() {
    final List<String> tabs = [
      'Semua',
      'Belum Bayar',
      'Dikemas',
      'Dikirim',
      'Selesai',
      'Dibatalkan',
    ];

    final List<Map<String, String>> pesanan = widget.orders;

    return DefaultTabController(
      length: tabs.length,
      child: Column(
        children: [
          TabBar(
            isScrollable: true,
            labelColor: Colors.brown,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.brown,
            tabs: tabs.map((tab) => Tab(text: tab)).toList(),
          ),
          Expanded(
            child: TabBarView(
              children: tabs.map((status) {
                final daftar = status == 'Semua'
                    ? pesanan
                    : pesanan
                        .where(
                          (item) => item['status'] == status,
                        )
                        .toList();

                if (daftar.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_bag_outlined,
                          size: 65,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 12),
                        Text('Belum ada pesanan'),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: daftar.length,
                  itemBuilder: (context, index) {
                    final item = daftar[index];

                    return Card(
                      color: Colors.white,
                      elevation: 0,
                      margin: const EdgeInsets.only(bottom: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  item['kode'] ?? '-',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  item['status'] ?? '-',
                                  style: const TextStyle(
                                    color: Colors.brown,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const Divider(height: 25),
                            Row(
                              children: [
                                Container(
                                  width: 65,
                                  height: 65,
                                  decoration: BoxDecoration(
                                    color: beige,
                                    borderRadius:
                                        BorderRadius.circular(12),
                                  ),
                                  child: const Icon(
                                    Icons.shopping_bag_outlined,
                                    size: 32,
                                    color: Colors.brown,
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item['nama'] ?? '-',
                                        style: const TextStyle(
                                          fontWeight:
                                              FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        item['harga'] ?? '-',
                                        style: const TextStyle(
                                          color: Colors.brown,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  // ================= HALAMAN INFORMASI PRIBADI =================

  Widget halamanInformasi() {
    return InformasiPribadiContent(
      namaAwal: namaPengguna,
      usernameAwal: usernamePengguna,
      emailAwal: emailPengguna,
      teleponAwal: teleponPengguna,
      genderAwal: genderPengguna,
      tanggalLahirAwal: tanggalLahirPengguna,
      onPesan: pesan,
      onSimpan: (data) {
        setState(() {
          namaPengguna = data['nama']!;
          usernamePengguna = data['username']!;
          emailPengguna = data['email']!;
          teleponPengguna = data['telepon']!;
          genderPengguna = data['gender']!;
          tanggalLahirPengguna = data['tanggalLahir']!;
        });
      },
    );
  }

  // ================= HALAMAN ALAMAT =================

  Widget halamanAlamat() {
    return AlamatContent(
      onPesan: pesan,
    );
  }
}

// ======================================================
// INFORMASI PRIBADI
// ======================================================

class InformasiPribadiContent extends StatefulWidget {
  final Function(String) onPesan;
  final Function(Map<String, String>) onSimpan;

  final String namaAwal;
  final String usernameAwal;
  final String emailAwal;
  final String teleponAwal;
  final String genderAwal;
  final String tanggalLahirAwal;

  const InformasiPribadiContent({
    super.key,
    required this.onPesan,
    required this.onSimpan,
    required this.namaAwal,
    required this.usernameAwal,
    required this.emailAwal,
    required this.teleponAwal,
    required this.genderAwal,
    required this.tanggalLahirAwal,
  });

  @override
  State<InformasiPribadiContent> createState() =>
      _InformasiPribadiContentState();
}

class _InformasiPribadiContentState
    extends State<InformasiPribadiContent> {
  late final TextEditingController nama;
  late final TextEditingController username;
  late final TextEditingController email;
  late final TextEditingController telepon;

  late String gender;
  late String tanggalLahir;

  @override
  void initState() {
    super.initState();

    nama = TextEditingController(text: widget.namaAwal);
    username = TextEditingController(
      text: widget.usernameAwal,
    );
    email = TextEditingController(text: widget.emailAwal);
    telepon = TextEditingController(
      text: widget.teleponAwal,
    );

    gender = widget.genderAwal;
    tanggalLahir = widget.tanggalLahirAwal;
  }

  @override
  void dispose() {
    nama.dispose();
    username.dispose();
    email.dispose();
    telepon.dispose();
    super.dispose();
  }

  Future<void> pilihTanggal() async {
    final tanggal = await showDatePicker(
      context: context,
      initialDate: DateTime(2004, 1, 1),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (tanggal != null) {
      setState(() {
        tanggalLahir =
            '${tanggal.day}/${tanggal.month}/${tanggal.year}';
      });
    }
  }

  InputDecoration dekorasi(IconData icon) {
    return InputDecoration(
      prefixIcon: Icon(
        icon,
        color: Colors.brown,
      ),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }

  Widget field(
    String label,
    TextEditingController controller,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            decoration: dekorasi(icon),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Center(
          child: CircleAvatar(
            radius: 45,
            backgroundColor: Color(0xFFF3EBDD),
            child: Icon(
              Icons.person,
              size: 55,
              color: Colors.brown,
            ),
          ),
        ),
        Center(
          child: TextButton.icon(
            onPressed: () {
              widget.onPesan(
                'Fitur ubah foto belum tersedia',
              );
            },
            icon: const Icon(Icons.camera_alt_outlined),
            label: const Text('Ubah Foto Profil'),
          ),
        ),

        const SizedBox(height: 15),

        field('Nama Lengkap', nama, Icons.person_outline),
        field('Username', username, Icons.alternate_email),
        field('Email', email, Icons.email_outlined),
        field('Nomor Telepon', telepon, Icons.phone_outlined),

        const Text(
          'Jenis Kelamin',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),

        DropdownButtonFormField<String>(
          value: gender,
          decoration: dekorasi(Icons.people_outline),
          items: ['Perempuan', 'Laki-laki']
              .map(
                (item) => DropdownMenuItem(
                  value: item,
                  child: Text(item),
                ),
              )
              .toList(),
          onChanged: (value) {
            if (value != null) {
              setState(() => gender = value);
            }
          },
        ),

        const SizedBox(height: 16),

        const Text(
          'Tanggal Lahir',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),

        InkWell(
          onTap: pilihTanggal,
          child: InputDecorator(
            decoration: dekorasi(
              Icons.calendar_today_outlined,
            ),
            child: Text(tanggalLahir),
          ),
        ),

        const SizedBox(height: 25),

        ElevatedButton(
          onPressed: () {
            if (nama.text.trim().isEmpty ||
                username.text.trim().isEmpty ||
                email.text.trim().isEmpty ||
                telepon.text.trim().isEmpty) {
              widget.onPesan(
                'Mohon lengkapi semua informasi pribadi',
              );
              return;
            }

            // Mengirim data terbaru ke halaman Profil
            widget.onSimpan({
              'nama': nama.text.trim(),
              'username': username.text.trim(),
              'email': email.text.trim(),
              'telepon': telepon.text.trim(),
              'gender': gender,
              'tanggalLahir': tanggalLahir,
            });

            widget.onPesan(
              'Informasi pribadi berhasil disimpan',
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF292522),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(
              vertical: 15,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text('Simpan Perubahan'),
        ),

        const SizedBox(height: 12),

        OutlinedButton.icon(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Ubah Kata Sandi'),
                content: const Text(
                  'Fitur ubah kata sandi dapat dihubungkan '
                  'dengan sistem login aplikasi.',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Tutup'),
                  ),
                ],
              ),
            );
          },
          icon: const Icon(Icons.lock_outline),
          label: const Text('Ubah Kata Sandi'),
        ),
      ],
    );
  }
}

// ======================================================
// ALAMAT PENGIRIMAN
// ======================================================

class AlamatContent extends StatefulWidget {
  final Function(String) onPesan;

  const AlamatContent({
    super.key,
    required this.onPesan,
  });

  @override
  State<AlamatContent> createState() => _AlamatContentState();
}

class _AlamatContentState extends State<AlamatContent> {
  final List<Map<String, dynamic>> alamatList = [
    {
      'nama': 'Pengguna StyleUp',
      'telepon': '081234567890',
      'label': 'Rumah',
      'alamat': 'Jl. Pandanaran No. 10',
      'kota': 'Semarang',
      'kodepos': '50241',
      'utama': true,
    },
    {
      'nama': 'Pengguna StyleUp',
      'telepon': '081234567890',
      'label': 'Kantor',
      'alamat': 'Jl. Pemuda No. 25',
      'kota': 'Semarang',
      'kodepos': '50132',
      'utama': false,
    },
  ];

  void bukaForm({int? index}) {
    final data = index == null ? null : alamatList[index];

    final nama = TextEditingController(
      text: data?['nama'] ?? '',
    );
    final telepon = TextEditingController(
      text: data?['telepon'] ?? '',
    );
    final alamat = TextEditingController(
      text: data?['alamat'] ?? '',
    );
    final kota = TextEditingController(
      text: data?['kota'] ?? '',
    );
    final kodepos = TextEditingController(
      text: data?['kodepos'] ?? '',
    );

    String label = data?['label'] ?? 'Rumah';
    bool utama = data?['utama'] ?? alamatList.isEmpty;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text(
                index == null
                    ? 'Tambah Alamat'
                    : 'Edit Alamat',
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    inputAlamat(nama, 'Nama Penerima'),
                    inputAlamat(telepon, 'Nomor Telepon'),

                    DropdownButtonFormField<String>(
                      value: label,
                      decoration: const InputDecoration(
                        labelText: 'Label Alamat',
                      ),
                      items: ['Rumah', 'Kantor', 'Lainnya']
                          .map(
                            (item) => DropdownMenuItem(
                              value: item,
                              child: Text(item),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setDialogState(() => label = value);
                        }
                      },
                    ),

                    inputAlamat(alamat, 'Alamat Lengkap'),
                    inputAlamat(kota, 'Kota/Kabupaten'),
                    inputAlamat(kodepos, 'Kode Pos'),

                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text(
                        'Jadikan alamat utama',
                      ),
                      value: utama,
                      onChanged: (value) {
                        setDialogState(() {
                          utama = value ?? false;
                        });
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                  },
                  child: const Text('Batal'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF292522),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    if (nama.text.trim().isEmpty ||
                        telepon.text.trim().isEmpty ||
                        alamat.text.trim().isEmpty ||
                        kota.text.trim().isEmpty ||
                        kodepos.text.trim().isEmpty) {
                      widget.onPesan(
                        'Lengkapi semua data alamat',
                      );
                      return;
                    }

                    final alamatBaru = {
                      'nama': nama.text.trim(),
                      'telepon': telepon.text.trim(),
                      'label': label,
                      'alamat': alamat.text.trim(),
                      'kota': kota.text.trim(),
                      'kodepos': kodepos.text.trim(),
                      'utama': utama,
                    };

                    setState(() {
                      if (utama) {
                        for (final item in alamatList) {
                          item['utama'] = false;
                        }
                      }

                      if (index == null) {
                        alamatList.add(alamatBaru);
                      } else {
                        alamatList[index] = alamatBaru;
                      }

                      if (alamatList.isNotEmpty &&
                          !alamatList.any(
                            (item) => item['utama'] == true,
                          )) {
                        alamatList[0]['utama'] = true;
                      }
                    });

                    Navigator.pop(dialogContext);
                    widget.onPesan(
                      'Alamat berhasil disimpan',
                    );
                  },
                  child: const Text('Simpan'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget inputAlamat(
    TextEditingController controller,
    String label,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  void hapusAlamat(int index) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Hapus Alamat'),
        content: const Text(
          'Apakah kamu yakin ingin menghapus alamat ini?',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
            },
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                final alamatUtama =
                    alamatList[index]['utama'] == true;

                alamatList.removeAt(index);

                if (alamatUtama && alamatList.isNotEmpty) {
                  alamatList[0]['utama'] = true;
                }
              });

              Navigator.pop(dialogContext);
              widget.onPesan('Alamat berhasil dihapus');
            },
            child: const Text(
              'Hapus',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void jadikanUtama(int index) {
    setState(() {
      for (final item in alamatList) {
        item['utama'] = false;
      }

      alamatList[index]['utama'] = true;
    });

    widget.onPesan('Alamat utama berhasil diubah');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => bukaForm(),
              icon: const Icon(
                Icons.add_location_alt_outlined,
              ),
              label: const Text('Tambah Alamat Baru'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF292522),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ),

        Expanded(
          child: alamatList.isEmpty
              ? const Center(
                  child: Text('Belum ada alamat tersimpan'),
                )
              : ListView.builder(
                  padding: 
                  const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  itemCount: alamatList.length,
                  itemBuilder: (context, index) {
                    final item = alamatList[index];

                    return Card(
                      color: Colors.white,
                      elevation: 0,
                      margin: const EdgeInsets.only(
                        bottom: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on_outlined,
                                  color: Colors.brown,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  item['label'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const Spacer(),
                                if (item['utama'] == true)
                                  Container(
                                    padding:
                                        const EdgeInsets.symmetric(
                                      horizontal: 9,
                                      vertical: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(
                                        0xFFF3EBDD,
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(8),
                                    ),
                                    child: const Text(
                                      'Utama',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.brown,
                                        fontWeight:
                                            FontWeight.bold,
                                      ),
                                    ),
                                  ),
                              ],
                            ),

                            const SizedBox(height: 12),

                            Text(
                              item['nama'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(item['telepon']),
                            const SizedBox(height: 8),
                            Text(item['alamat']),
                            Text(
                              '${item['kota']}, ${item['kodepos']}',
                            ),

                            const Divider(height: 25),

                            Wrap(
                              spacing: 8,
                              children: [
                                TextButton.icon(
                                  onPressed: () {
                                    bukaForm(index: index);
                                  },
                                  icon: const Icon(
                                    Icons.edit_outlined,
                                    size: 17,
                                  ),
                                  label: const Text('Edit'),
                                ),
                                TextButton.icon(
                                  onPressed: () {
                                    hapusAlamat(index);
                                  },
                                  icon: const Icon(
                                    Icons.delete_outline,
                                    size: 17,
                                    color: Colors.red,
                                  ),
                                  label: const Text(
                                    'Hapus',
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                                if (item['utama'] != true)
                                  TextButton(
                                    onPressed: () {
                                      jadikanUtama(index);
                                    },
                                    child: const Text(
                                      'Jadikan Utama',
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
