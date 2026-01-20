class BookModel {
  final VolumeInfo volumeInfo;

  BookModel({required this.volumeInfo});

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      volumeInfo: VolumeInfo.fromJson(json['volumeInfo'] ?? {}),
    );
  }
}

class VolumeInfo {
  final String title;
  final List<String>? authors;
  final ImageLinks? imageLinks;

  VolumeInfo({
    required this.title,
    this.authors,
    this.imageLinks,
  });

  factory VolumeInfo.fromJson(Map<String, dynamic> json) {
    return VolumeInfo(
      title: json['title'] ?? 'No Title',
      authors: json['authors'] != null
          ? List<String>.from(json['authors'])
          : null,
      imageLinks: json['imageLinks'] != null
          ? ImageLinks.fromJson(json['imageLinks'])
          : null,
    );
  }
}

class ImageLinks {
  final String? thumbnail;

  ImageLinks({this.thumbnail});

  factory ImageLinks.fromJson(Map<String, dynamic> json) {
    return ImageLinks(
      thumbnail: json['thumbnail'],
    );
  }
}
