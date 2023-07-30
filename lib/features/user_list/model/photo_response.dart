class PhotoResponse {
  String? id;
  String? author;
  int? width;
  int? height;
  String? url;
  String? downloadUrl;

  PhotoResponse({this.id, this.author, this.width, this.height, this.url, this.downloadUrl});

  PhotoResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    author = json['author'];
    width = json['width'];
    height = json['height'];
    url = json['url'];
    downloadUrl = json['download_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['author'] = author;
    data['width'] = width;
    data['height'] = height;
    data['url'] = url;
    data['download_url'] = downloadUrl;
    return data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PhotoResponse &&
        id == other.id &&
        author == other.author &&
        width == other.width &&
        height == other.height &&
        url == other.url &&
        downloadUrl == other.downloadUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^ author.hashCode ^ width.hashCode ^ height.hashCode ^ url.hashCode ^ downloadUrl.hashCode;
  }
}
