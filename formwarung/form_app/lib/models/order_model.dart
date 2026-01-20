class OrderModel {
  final int id;
  final String namaPemesan;
  final String tipe;
  final int total;
  final String statusOrder;
  final String tanggal;
  final String jam;
  final String? alamat;
  final String? catatan;

  OrderModel({
    required this.id,
    required this.namaPemesan,
    required this.tipe,
    required this.total,
    required this.statusOrder,
    required this.tanggal,
    required this.jam,
    this.alamat,
    this.catatan,
  });

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'],
      namaPemesan: map['nama_pemesan'],
      tipe: map['tipe'],
      total: map['total'],
      statusOrder: map['status_order'],
      tanggal: map['tanggal'],
      jam: map['jam'],
      alamat: map['alamat'],
      catatan: map['catatan'],
    );
  }
}
