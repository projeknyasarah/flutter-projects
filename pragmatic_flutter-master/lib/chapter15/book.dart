class Book {
  final String id;
  final VolumeInfo volumeInfo;

  Book({
    required this.id,
    required this.volumeInfo,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'] ?? '',
      volumeInfo: VolumeInfo.fromJson(json['volumeInfo']),
    );
  }
}

class VolumeInfo {
  final String? title;
  final List<String>? authors;
  final String? description;
  final ImageLinks? imageLinks;

  VolumeInfo({
    this.title,
    this.authors,
    this.description,
    this.imageLinks,
  });

  factory VolumeInfo.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return VolumeInfo(
        title: null,
        authors: null,
        description: null,
        imageLinks: null,
      );
    }

    return VolumeInfo(
      title: json['title'] as String?,
      authors: (json['authors'] != null)
          ? List<String>.from(json['authors'])
          : null,
      description: json['description'] as String?,
      imageLinks: ImageLinks.fromJson(json['imageLinks']),
    );
  }
}

class ImageLinks {
  final String? smallThumbnail;
  final String? thumbnail;

  ImageLinks({
    this.smallThumbnail,
    this.thumbnail,
  });

  factory ImageLinks.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return ImageLinks(
        smallThumbnail: null,
        thumbnail: null,
      );
    }

    String? small = json['smallThumbnail'] as String?;
    String? large = json['thumbnail'] as String?;

    // Fix 'http://' → 'https://'
    if (small != null) {
      small = small.replaceAll("http://", "https://");
    }
    if (large != null) {
      large = large.replaceAll("http://", "https://");
    }

    return ImageLinks(
      smallThumbnail: small,
      thumbnail: large,
    );
  }
}
