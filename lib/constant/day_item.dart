class DayItem {
  final String hari;
  final String pesan;
  final String color;
  final String image;

  const DayItem({
    required this.hari,
    required this.pesan,
    required this.color,
    required this.image,
  });
}

List<DayItem> items = const [
  DayItem(
      hari: 'Senin',
      pesan: 'Lihat daftar matakuliah hari Senin',
      color: '0xff357CA5',
      image: 'assets/icondays/intone_1.png'),
  DayItem(
      hari: 'Selasa',
      pesan: 'Lihat daftar matakuliah hari Selasa',
      color: '0XFF555299',
      image: 'assets/icondays/intone_2.png'),
  DayItem(
      hari: 'Rabu',
      pesan: 'Lihat daftar matakuliah hari Rabu',
      color: '0XFFDB8B0B',
      image: 'assets/icondays/intone_3.png'),
  DayItem(
    hari: 'Kamis',
    pesan: 'Lihat daftar matakuliah hari Kamis',
    color: '0XFF008D4C',
    image: 'assets/icondays/intone_4.png',
  ),
  DayItem(
    hari: 'Jumat',
    pesan: 'Lihat daftar matakuliah hari Jumat',
    color: '0XFF00A7D0',
    image: 'assets/icondays/intone_5.png',
  ),
  DayItem(
    hari: 'Sabtu',
    pesan: 'Lihat daftar matakuliah hari Sabtu',
    color: '0XFFCA195A',
    image: 'assets/icondays/intone_6.png',
  ),
  DayItem(
    hari: 'Minggu',
    pesan: 'Lihat daftar matakuliah hari Minggu',
    color: '0XFFB5BBC8',
    image: 'assets/icondays/intone_7.png',
  ),
];
