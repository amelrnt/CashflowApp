class Dana{
  final String tanggal;
  final int jumlah;
  final int status; // 1= pemasukan, 0=pengeluaran
  final String keterangan;

  const Dana({
    required this.tanggal,
    required this.jumlah, 
    required this.status, 
    required this.keterangan
    });

  Map<String, dynamic> toMap() {
    return {
      'tanggal': tanggal,
      'jumlah': jumlah,
      'status': status,
      'keterangan' : keterangan,
    };
  }
  @override
  String toString() {
    return 'Dana{tanggal: $tanggal,jumlah: $jumlah, status: $status, keterangan: $keterangan}';
  }

}



// var dataList =[
//   Dana(
//     jumlah: 25000,
//     status: 0,
//     keterangan: 'urunan makan',
//   ),
//   Dana(
//     jumlah: 1000000,
//     status: 1,
//     keterangan: 'payment freelance',
//   ),
// ];