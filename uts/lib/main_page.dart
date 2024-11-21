import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; 

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    TugasPage(),
    SchedulePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SMK Nasional Jatiwangi')),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_turned_in),
            label: 'Tugas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'Jadwal',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

class TugasPage extends StatelessWidget {
  final List<Map<String, String>> tugas = [
    {'judul': 'Tugas Matematika', 'deskripsi': 'Kerjakan soal matematika bab 2'},
    {'judul': 'Tugas Pemograman Mobile 1', 'deskripsi': 'Membuat halaman login'},
    {'judul': 'Tugas Pemrograman Berorientasi Objek', 'deskripsi': 'Membuat aplikasi kalkulator'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tugas Rekayasa Perangkat Lunak')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: tugas.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(tugas[index]['judul']!),
              subtitle: Text(tugas[index]['deskripsi']!),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(tugas[index]['judul']!),
                    content: Text(tugas[index]['deskripsi']!),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Tutup'),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class SchedulePage extends StatelessWidget {
  final List<Map<String, dynamic>> jurusan = [
    {'name': 'RPL', 'icon': Icons.computer, 'color': Colors.blue},
    {'name': 'TKJ', 'icon': Icons.router, 'color': Colors.green},
    {'name': 'TBSM', 'icon': Icons.build, 'color': Colors.orange},
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pilih Jurusan')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemCount: jurusan.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ClassPage(jurusan: jurusan[index]['name']),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: jurusan[index]['color'],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(jurusan[index]['icon'], color: Colors.white, size: 40),
                    SizedBox(height: 8),
                    Text(
                      jurusan[index]['name'],
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ClassPage extends StatelessWidget {
  final String jurusan;
  final List<String> kelas = ['10', '11', '12'];

  final Map<String, String> jurusanFullNames = {
    'RPL': 'Rekayasa Perangkat Lunak',
    'TKJ': 'Teknik Komputer Jaringan',
    'TBSM': 'Teknik dan Bisnis Sepeda Motor',
  };

  ClassPage({required this.jurusan});

  @override
  Widget build(BuildContext context) {
    final String fullName = jurusanFullNames[jurusan] ?? jurusan;

    return Scaffold(
      appBar: AppBar(title: Text(fullName)),
      body: ListView.builder(
        itemCount: kelas.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.school, color: Colors.blueAccent),
            title: Text('Kelas ${kelas[index]}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ScheduleDetailsPage(jurusan: jurusan, kelas: kelas[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}


class ScheduleDetailsPage extends StatelessWidget {
  final String jurusan;
  final String kelas;

  ScheduleDetailsPage({required this.jurusan, required this.kelas});

  final Map<String, IconData> subjectIcons = {
    'Matematika': Icons.calculate,
    'Bahasa Indonesia': Icons.language,
    'Bahasa Inggris': Icons.translate,
    'Pemrograman Dasar': Icons.code,
    'Dasar Desain Grafis': Icons.brush,
    'Penjaskes': Icons.sports,
    'Algoritma': Icons.functions,
    'Simulasi dan Komunikasi Digital': Icons.devices,
    'Sistem Komputer': Icons.memory,
    'Komputer dan Jaringan Dasar': Icons.router,
  };

  final Map<String, Map<String, Map<String, List<String>>>> schedule = {
    'RPL': {
      '10': {
        'Senin': ['Matematika', 'Bahasa Indonesia'],
        'Selasa': ['Algoritma dan Pemograman Dasar', 'Penjaskes', 'Dasar Desain Grafis'],
        'Rabu': ['Bahasa Inggris', 'Sistem Komputer', 'Komputer dan Jaringan Dasar'],
        'Kamis': ['Simulasi dan Komunikasi Digital', 'Bahasa Indonesia'],
        'Jumat': ['Matematika', 'Bahasa Inggris'],
      },
      '11': {
        'Senin': ['Pemrograman Berorientasi Objek', 'Produk Kreatif dan Kewirausahaan'],
        'Selasa': ['Basis Data 1', 'Pemodelan Perangkat Lunak'],
        'Rabu': ['Pemrograman Mobile 1', 'Bahasa Inggris'],
        'Kamis': ['Matematika', 'Bahasa Indonesia'],
        'Jumat': ['Penjaskes', 'Pendidikan Agama Islam'],
      },
      '12': {
        'Senin': ['Pemrograman Berorientasi Objek 2', 'Pemrograman Web 2'],
        'Selasa': ['Basis Data 2', 'Pemodelan Perangkat Lunak 2'],
        'Rabu': ['Pemrograman Mobile 2', 'Bahasa Inggris'],
        'Kamis': ['Penjaskes', 'Pendidikan Agama Islam'],
        'Jumat': ['Matematika', 'Bahasa Indonesia'],
      },
    },
    'TKJ': {
      '10': {
        'Senin': ['Dasar-dasar TJKT', 'IOT (Microcontroller)'],
        'Selasa': ['Matematika', 'Bahasa Inggris'],
        'Rabu': ['Pendidikan Agama Islam', 'Bahasa Indonesia'],
        'Kamis': ['Pemrograman Web', 'Seni Budaya'],
        'Jumat': ['Penjaskes', 'Komputer dan Jaringan Dasar'],
      },
      '11': {
        'Senin': ['Otomasi Industri', 'TKJ (Teknik Komputer dan Jaringan)'],
        'Selasa': ['Pendidikan Agama Islam', 'Project Kreatif KWU'],
        'Rabu': ['Bahasa Indonesia', 'Matematika'],
        'Kamis': ['Sejarah', 'Penjaskes'],
        'Jumat': ['Seni Budaya', 'Desain Grafis'],
      },
      '12': {
        'Senin': ['Teknologi Layangan Jaringan (TLJ)', 'Bahasa Sunda'],
        'Selasa': ['PPKn', 'Sejarah'],
        'Rabu': ['Bahasa Indonesia', 'Produk Kreatif KWU'],
        'Kamis': ['Administrasi Infrastruktur Jaringan (ASJ)'],
        'Jumat': ['Penjaskes', 'Bahasa Inggris'],
      },
    },
    'TBSM': {
      '10': {
        'Senin': ['Teknologi Dasar Otomotif', 'Matematika'],
        'Selasa': ['Pekerjaan Dasar Otomotif', 'Bahasa Indonesia'],
        'Rabu': ['Penjaskes', 'Pendidikan Agama Islam'],
        'Kamis': ['Gambar Teknik Otomotif', 'Simulasi dan Komunikasi Digital'],
        'Jumat': ['Bahasa Inggris', 'Fisika'],
      },
      '11': {
        'Senin': ['Matematika', 'Teknologi Dasar Otomotif'],
        'Selasa': ['Bahasa Indonesia', 'Kelistrikan'],
        'Rabu': ['Penjaskes', 'Pendidikan Agama Islam'],
        'Kamis': ['Gambar Teknik Otomotif', 'Simulasi dan Komunikasi Digital'],
        'Jumat': ['Bahasa Inggris', 'Fisika'],
      },
      '12': {
        'Senin': ['Matematika', 'Teknologi Dasar Otomotif'],
        'Selasa': ['Bahasa Indonesia', 'Kelistrikan'],
        'Rabu': ['Penjaskes', 'Pendidikan Agama Islam'],
        'Kamis': ['Gambar Teknik Otomotif', 'Simulasi dan Komunikasi Digital'],
        'Jumat': ['Bahasa Inggris', 'Fisika'],
      },
    },
  };

  final List<String> days = [
    'Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat'
  ];

  @override
  Widget build(BuildContext context) {
    final dailySchedules = schedule[jurusan]?[kelas] ?? {};

    return Scaffold(
      appBar: AppBar(title: Text('Jadwal Mata Pelajaran')),
      body: ListView.builder(
        itemCount: days.length,
        itemBuilder: (context, dayIndex) {
          final day = days[dayIndex];
          final subjects = dailySchedules[day] ?? [];
          return ExpansionTile(
            title: Text(day),
            children: subjects.map((subject) {
              return ListTile(
                leading: Icon(
                  subjectIcons[subject] ?? Icons.book,
                  color: Colors.blueAccent,
                ),
                title: Text(subject),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}


class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          
          Container(
            width: double.infinity,
            height: 250,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blueAccent, Colors.lightBlue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 60,
                ),
                SizedBox(height: 10),
                Text(
                  'Nuramar',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'RPL (XI)',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Informasi Akun',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                  SizedBox(height: 10),
                  ListTile(
                    leading: Icon(Icons.email, color: Colors.blueAccent),
                    title: Text('Email'),
                    subtitle: Text('nuramar@gmail.com'),
                  ),
                  ListTile(
                    leading: Icon(Icons.phone, color: Colors.blueAccent),
                    title: Text('Telepon'),
                    subtitle: Text('+62 812 3456 7890'),
                  ),
                  ListTile(
                    leading: Icon(Icons.location_on, color: Colors.blueAccent),
                    title: Text('Lokasi'),
                    subtitle: Text('Majalengka, Indonesia'),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                       if (Platform.isAndroid || Platform.isIOS) {
                          SystemNavigator.pop(); 
                        } else {
                          exit(0); 
                        }
                      },
                      icon: Icon(Icons.logout),
                      label: Text('Exit'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
