class Photo {
  final String albumid;
  final String id;
  final String thumbnailUrl;
  final String title;
  final String image;
  Photo({this.albumid, this.id, this.thumbnailUrl, this.title, this.image});
  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      albumid: json['albumId'].toString(),
      id: json['id'].toString(),
      thumbnailUrl: json['thumbnailUrl'],
      title: json['title'],
      image: json['url'],
    );
  }
}
