class Album {
  final String albumid;
  final String title;
  final String userid;

  Album._({this.albumid, this.title, this.userid});
  factory Album.fromJson(Map<String, dynamic> json) {
    return Album._(
      albumid: json['id'].toString(),
      userid: json['userid'].toString(),
      title: json['title'],
    );
  }
}
