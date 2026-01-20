class MenuModel {
  final int? id;
  final String nama;
  final int harga;

  MenuModel({
    this.id,
    required this.nama,
    required this.harga,
  });

  factory MenuModel.fromMap(Map<String, dynamic> map) {
    return MenuModel(
      id: map['id'],
      nama: map['nama'],
      harga: map['harga'],
    );
  }
}
