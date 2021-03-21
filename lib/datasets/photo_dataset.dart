class PhotoDataset {
  int photoId;
  String url;

  PhotoDataset({
    this.photoId,
    this.url,
  });

  factory PhotoDataset.fromJson(Map<String, dynamic> json) {
    return PhotoDataset(
      photoId: json['photoId'] as int,
      url: json['url'] as String,
    );
  }
}
