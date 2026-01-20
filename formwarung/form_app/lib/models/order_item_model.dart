// ===================== MENU MODEL =====================
class MenuModel {
  final int? id;
  final String nama;
  final int harga;
  final int aktif;

  MenuModel({
    this.id,
    required this.nama,
    required this.harga,
    required this.aktif,
  });

  factory MenuModel.fromMap(Map<String, dynamic> map) {
    return MenuModel(
      id: map['id'],
      nama: map['nama'],
      harga: map['harga'],
      aktif: map['aktif'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'harga': harga,
      'aktif': aktif,
    };
  }
}

// ===================== ORDER MODEL =====================
class OrderModel {
  final int? id;
  final String namaPemesan;
  final String noHp;
  final String? alamat;
  final String tipe; // takeaway / delivery
  final String metodeBayar; // QRIS / COD
  final String statusBayar; // belum / menunggu_konfirmasi / lunas
  final String statusOrder; // menunggu / diproses / selesai
  final int total;
  final String tanggal;
  final String jam;

  OrderModel({
    this.id,
    required this.namaPemesan,
    required this.noHp,
    this.alamat,
    required this.tipe,
    required this.metodeBayar,
    required this.statusBayar,
    required this.statusOrder,
    required this.total,
    required this.tanggal,
    required this.jam,
  });

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'],
      namaPemesan: map['nama_pemesan'],
      noHp: map['no_hp'],
      alamat: map['alamat'],
      tipe: map['tipe'],
      metodeBayar: map['metode_bayar'],
      statusBayar: map['status_bayar'],
      statusOrder: map['status_order'],
      total: map['total'],
      tanggal: map['tanggal'],
      jam: map['jam'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama_pemesan': namaPemesan,
      'no_hp': noHp,
      'alamat': alamat,
      'tipe': tipe,
      'metode_bayar': metodeBayar,
      'status_bayar': statusBayar,
      'status_order': statusOrder,
      'total': total,
      'tanggal': tanggal,
      'jam': jam,
    };
  }
}

// ===================== ORDER ITEM MODEL =====================
class OrderItemModel {
  final int? id;
  final int orderId;
  final int menuId;
  final int jumlah;
  final int harga;

  OrderItemModel({
    this.id,
    required this.orderId,
    required this.menuId,
    required this.jumlah,
    required this.harga,
  });

  factory OrderItemModel.fromMap(Map<String, dynamic> map) {
    return OrderItemModel(
      id: map['id'],
      orderId: map['order_id'],
      menuId: map['menu_id'],
      jumlah: map['jumlah'],
      harga: map['harga'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'order_id': orderId,
      'menu_id': menuId,
      'jumlah': jumlah,
      'harga': harga,
    };
  }
}
