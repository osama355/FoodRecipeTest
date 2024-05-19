class SearchResult {
  final int id;
  final String title;
  final String image;
  final String imageType;

  SearchResult({
    required this.id,
    required this.title,
    required this.image,
    required this.imageType,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    return SearchResult(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      imageType: json['imageType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'imageType': imageType,
    };
  }
}
